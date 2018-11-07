# function Expand-Tree ($leaf, $currentRootString, $currentRoot) {
#     $type = $leaf.psobject.typenames
#     if ($type -contains "System.Management.Automation.PSCustomObject") {
#         $value = "System.Management.Automation.PSCustomObject"
#         $contains = $leaf.psobject.properties
#         $contains | ForEach-Object {
#             $branch = $_
#             $branchName = $branch.name
#             $branchValue = $branch.value
#             if ( $currentRoot) {
#                 $nextPathObject = @($currentRoot)
#             }
#             $nextPathObject += @($branchName)
#             $nextPath = "$currentRootString.$branchName"
#             Expand-Tree $branchValue $nextPath $nextPathObject
#         }
#     }
#     else {
#         $value = $leaf
#     }
#     $ret += [PSCustomObject]@{
#         path         = $currentRoot
#         propertyType = $value
#         stringPath   = $currentRootString
#     }    
#     if ( $currentRoot) {
#         return $ret
#     }
# }