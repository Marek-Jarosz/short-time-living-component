  '***************************************************
  '** Intive Roku Framework
  '**
  '** Intive, Ovcharuk Stepan, 16/02/2022
  '**
  '** utils functions that are used for data type verification
  '***************************************************

'-------------
' isValid()
'
' @param {dynamic} value - value to be checked
' @return {boolean} - boolean flag indicating if argument is valid 
'
' checks if argument is not an invalid or uninitialized
'-------------
function isValid(value as dynamic) as boolean
    return type(value) <> "Invalid" and type(value) <> "roInvalid" and type(value) <> "<uninitialized>"
  end function
  
  '-------------
  ' isInvalid()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is invalid 
  '
  ' checks if argument is an invalid type
  '-------------
  function isInvalid(value as dynamic) as boolean
    return type(value) = "Invalid" or type(value) = "roInvalid"
  end function
  
  '-------------
  ' isString()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is string
  '
  ' checks if argument is string type
  '-------------
  function isString(value as dynamic) as boolean
    return type(value) = "String" or type(value) = "roString"
  end function
  
  '-------------
  ' isBoolean()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is boolean
  '
  ' checks if argument is boolean type
  '-------------
  function isBoolean(value as dynamic) as boolean
    return type(value) = "Boolean" or type(value) = "roBoolean"
  end function
  
  '-------------
  ' isInteger()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a integer
  '
  ' checks if argument is integer type
  '-------------
  function isInteger(value as dynamic) as boolean
    return type(value) = "Integer" or type(value) = "roInteger" or type(value) = "roInt"
  end function
  
  '-------------
  ' isLongInt()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a long integer
  '
  ' checks if argument is longInteger type
  '-------------
  function isLongInt(value as dynamic) as boolean
    return type(value) = "LongInteger" or type(value) = "roLongInteger"
  end function
  
  '-------------
  ' isFloat()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a float number
  '
  ' checks if argument is float type
  '-------------
  function isFloat(value as dynamic) as boolean
    return type(value) = "Float" or type(value) = "roFloat"
  end function
  
  '-------------
  ' isDouble()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a double number
  '
  ' checks if argument is double type
  '-------------
  function isDouble(value as dynamic) as boolean
    return type(value) = "Double" or type(value) = "roDouble"
  end function
  
  '-------------
  ' isNumber()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a number
  '
  ' checks if argument is one of the numerics type
  '-------------
  function isNumber(value as dynamic) as boolean
    return isInteger(value) or isLongInt(value) or isFloat(value) or isDouble(value)
  end function
  
  '-------------
  ' isNode()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a Node
  '
  ' checks if argument is Node type
  '-------------
  function isNode(value as dynamic) as boolean
    return type(value) = "roSGNode" or type(value) = "SGNode" 
  end function
  
  '-------------
  ' isArray()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is an array
  '
  ' checks if argument is array type
  '-------------
  function isArray(value as dynamic) as boolean
    return type(value) = "Array" or type(value) = "roArray" 
  end function
  
  '-------------
  ' isAA()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is an associative array
  '
  ' checks if argument is associative array type
  '-------------
  function isAA(value as dynamic) as boolean
    return type(value) = "Object" or type(value) = "roAssociativeArray" 
  end function
  
  '-------------
  ' isNotEmptyArray()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a non-empty array
  '
  ' checks if argument is array that has at least one entry
  '-------------
  function isNotEmptyArray(value as dynamic) as boolean
    return isArray(value) and value.count() > 0
  end function
  
  '-------------
  ' isArrayWithMinCount()
  '
  ' @param {dynamic} value - value to be checked
  ' @param {integer} countToCheck - array count to check
  ' @return {boolean} - boolean flag indicating if checked array has at least countToCheck amount of array members
  '
  ' checks if argument is array that has at least the amount of array members (count) passed in second argument
  '-------------
  function isArrayWithMinCount(value as dynamic, countToCheck as integer) as boolean
    return isNotEmptyArray(value) and value.count() >= countToCheck
  end function
  
  '-------------
  ' isNotEmptyAA()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a non-empty associative array
  '
  ' checks if argument is associative array that has at least one entry
  '-------------
  function isNotEmptyAA(value as dynamic) as boolean
    return isAA(value) and value.count() > 0
  end function
  
  '-------------
  ' isAAWithMinCount()
  '
  ' @param {dynamic} value - value to be checked
  ' @param {integer} countToCheck - associative array count to check
  ' @return {boolean} - boolean flag indicating if checked AA has at least countToCheck amount of entries
  '
  ' checks if argument is asocArray that has at least the amount of AA entries (count) passed in second argument
  '-------------
  function isAAWithMinCount(value as dynamic, countToCheck as integer) as boolean
    return isNotEmptyAA(value) and value.count() >= countToCheck
  end function
  
  '-------------
  ' isNotEmptyString()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is a non-empty string
  '
  ' checks if argument is string that contains at least one character
  '-------------
  function isNotEmptyString(value as dynamic) as boolean
    return isString(value) and Len(value) > 0
  end function
  
  '-------------
  ' isEmptyString()
  '
  ' @param {dynamic} value - value to be checked
  ' @return {boolean} - boolean flag indicating if argument is an empty string
  '
  ' checks if argument is string that does not contains a single character (is empty)
  '-------------
  function isEmptyString(value as dynamic) as boolean
    return isString(value) and Len(value) = 0
  end function