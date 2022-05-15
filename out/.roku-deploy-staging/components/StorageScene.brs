sub init()
    m.tasks = []

    data1 = {
        action: "set"
        sectionName: "mySection"
        keys: {
           "myData": "test"
        }
    }
    testRegistrySection(data1)
    data2 = {
        action: "clearSection"
        sectionName: "mySection"
    }
    testRegistrySection(data2)
    data3 = {
        action: "delete"
        sectionName: "mySection"
        keys: ["myData3"]  
    }
    testRegistrySection(data3)
    data4 = {
        action: "get"
        sectionName: "mySection3"
        keys: ["myData"] 
    }     
    testRegistrySection(data4)
    data5 = {
        action: "clearRegistry"        
    } 
    testRegistrySection(data5)
    data6 = {
        action: "get"
        sectionName: "mySection3"
        keys: ["myData"] 
    } 
    testRegistrySection(data6)
end sub

sub onStorageServiceResult(msg) 
    result = msg.getData()
    print result 
end sub

sub testRegistrySection(data)
    ' storageservice = m.top.FindNode("storageservice")
    storageservice = createObject("roSGNode", "storageservice")
    storageService.observeFieldScoped("result", "onStorageServiceResult")
    storageService.data = data
    m.tasks.push(storageservice)
    storageService.control = "RUN"  
end sub

