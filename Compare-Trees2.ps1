function Compare-Trees2 ($wantedObject, $givenObject) {
    $prop = $wantedObject.psobject.TypeNames
    $isBranch = ($prop -contains "System.Management.Automation.PSCustomObject")
}




# foreach($property in $propsToSelect)
# {
#     $value = $inputObject
#     foreach($level in ($property -split '.'))
#     {
#         if($value -ne $null -and $value.$level -ne $null)
#         {
#             $value = $value.$level
#         }
#         else
#         {
#             $value = $null
#         }
#     }

#     [pscustomobject]@{
#         Name=$property
#         Value= $value
#     }
# }