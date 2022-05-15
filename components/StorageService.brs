' ***************************************************
' ** Intive Roku Framework
' **
' ** Intive, Marek Jarosz, 28/02/2022
' **
' ** Component for working with persistence storage
' ***************************************************

' Native functions 

sub init()
  m.top.functionName = "handleAction"
  m.registry = createObject("roRegistry")
  m.actionHandlers = {
    "get": get
    "set": set
    "delete": delete
    "clearSection": deleteSection
    "clearRegistry": clearRegistry
  }
end sub
  
' Private functions

'-------------
' setResult()
'
' @param {string} action - name of command that was executed 
' @param {dynamic} result - result of the command(invalid, boolean, string)
' @param {boolean} success -  result status: boolean(true, false)
'
' this sub sets the command result to output
'-------------
sub setResult(action as string, result as dynamic, success as boolean)
  m.top.result = {
      action: action
      result: result
      success: success
   }
end sub

'-------------
' handleAction()
'
' this sub checks if the application has at least 512 bytes of available space and if the command is correct and handles the type of input command
'-------------
sub handleAction()
  if (m.registry.getSpaceAvailable() > 512)
    data = m.top.data
    action = data.action
    if (isNotEmptyAA(data) and isNotEmptyString(action) and (isNotEmptyString(data.sectionName) or action = "clearRegistry"))
      actionHandler = m.actionHandlers[data.action]
      if (isValid(actionHandler))
        actionHandler(data)
      else
        print "[StorageService] unknown command name!"
        setResult(data.action, invalid, false)
      end if
    else
      print "[StorageService] command data does not contains required data!"
      setResult(data.action, invalid, false)
    end if
  else
    print "[StorageService] don't have enough memory left!"
    setResult(data.action, invalid, false)
  end if
  m.top.control = "DONE"
end sub

'-------------
' get()
'
' @param {assocarray} data - object with data to take from persistant storage
' 
' this sub handles "get" command and sets the result to output
'-------------
sub get(data as object)
  if (isNotEmptyArray(data.keys))
    outputData = getData(data.sectionName, data.keys)
    if (isNotEmptyAA(outputData))
      setResult(data.action, outputData, true)
    else
      setResult(data.action, invalid, false)
    end if
  else
    print "[StorageService] get: storage entry key name is not in expected format (string) or is empty"
    setResult(data.action, invalid, false)
  end if
end sub

'-------------
' set()
'
' @param {assocarray} data - object with data to save in persistant storage
' 
' this sub handles "set" command and sets the result in output field
'-------------
sub set(data as object)
  if (isNotEmptyAA(data.keys))
    savedSuccess = setData(data.sectionName, data.keys)      
    setResult(data.action, savedSuccess, savedSuccess)       
  else
    print "[StorageService] set: storage entry key name is not in expected format (string) or is empty"
    setResult(data.action, invalid, false)
  end if
  print data.keys
end sub

'-------------
' delete() 
'
' @param {assocarray} data - object with data for deleting entry in storage, can contain array of storage keys
' 
' this sub handles delete command and checks if storage entry is already deleted
'-------------
sub delete(data as object)
  deleteSuccessful = false
  allEntriesDeleted = true
  if (isNotEmptyArray(data.keys))
    for i = 0 to data.keys.count() - 1
      currentkey = data.keys[i]
      if (isNotEmptyString(currentkey))
        deleteSuccessful = deleteData(data.sectionName, currentkey)
        if (not deleteSuccessful)
          allEntriesDeleted = false
          print "[StorageService] delete: one of the storage entry key name is not in expected format (string) or is empty"
        end if
      else
        allEntriesDeleted = false
        print "[StorageService] delete: one of the storage entry key name is not in expected format (string) or is empty"
      end if
    end for
  end if
  success = deleteSuccessful and allEntriesDeleted
  setResult(data.action, invalid, success)
end sub

'-------------
' deleteSection()
'
' @param {assocarray} data - object with data about section to be deleted
' 
' this sub handles deleting whole section  
'-------------
sub deleteSection(data as object)
  deleteSectionResult = false
  sectionFound = false
  sectionNameWithPrefix = appendAppIdPrefix(data.sectionName)
  sectionNamesArray = m.registry.getSectionList().toArray()
  for i = 0 to sectionNamesArray.count() - 1
    if (sectionNamesArray[i] = sectionNameWithPrefix)
      sectionFound = true
      deleteSectionResult = m.registry.delete(sectionNameWithPrefix)
    end if
  end for
  success = deleteSectionResult or not sectionFound
  setResult(data.action, invalid, success)
end sub


'-------------
' appendAppIdPrefix()
'
' @param {string} sectionName - name of section to be distinguish
'
' this function will allow to make distinguish section names
'-------------
function appendAppIdPrefix(sectionName as string)
  sectionNameModified = createObject("roAppInfo").getId() + "_" + sectionName
  return sectionNameModified
end function

'------------- 
' clearRegistry()
'
' @param {assocarray} data - object with command data
' 
' this sub handle clears registry
'-------------
sub clearRegistry(data as object)
  sectionNamesArray = m.registry.getSectionList().toArray()
  for i = 0 to sectionNamesArray.count() - 1
    m.registry.delete(sectionNamesArray[i])
  end for
  setResult(data.action, invalid, true)
end sub

'-------------
' deleteData()
'
' @param {string} sectionName - name of section to be deleted from persistent storage
' @param {object} keys - data to be deleted from persistent storage
'
' this function will deleted section from roRegistrySection
'-------------
function deleteData(sectionName as string, keys as object) as boolean
  sectionNameWithPrefix = appendAppIdPrefix(sectionName)
  section = createObject("roRegistrySection", sectionNameWithPrefix)
  if (section.exists(keys))
    return section.delete(keys)
  end if
  return false
end function

'-------------
' getData()
'
' @param {string} sectionName - name of section to get from persistent storage
' @param {object} keys - data to get from persistent storage
'
' this function reading data from roRegistrySection
'-------------
function getData(sectionName as string, keys as object) as object
  sectionNameWithPrefix = appendAppIdPrefix(sectionName)
  section = createObject("roRegistrySection", sectionNameWithPrefix)
  return section.ReadMulti(keys)
end function

'-------------
' setData()
'
' @param {string} sectionName - name of section to set into persistent storage
' @param {object} keys - data to set into persistent storage
'
' this function writting into roRegistrySection
'-------------
function setData(sectionName as string, keys as object) as boolean
  sectionNameWithPrefix = appendAppIdPrefix(sectionName)
  section = createObject("roRegistrySection", sectionNameWithPrefix)
  result = section.WriteMulti(keys) 
  section.flush()
  return result
end function
