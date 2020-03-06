Param([parameter(mandatory=$true)][String] $envName)
. "$PSScriptRoot/util.ps1"
$config_path = "$PSScriptRoot" + "/../config/" + $envName + "_config.ps1"
Write-Host "Read config=$config_path"
. $config_path

function SetupAll {
   Write-Host "SetupAll: Getting ResourceGroups list"
   $script:result_list_rg = Get-AzResourceGroup
   echo $result_list_rg
}

Describe 'Test ResourceGroup specification' {
    SetupAll
    foreach($exp_rg in $SPEC_EXP_RG_ARRAY) {
        $exp_rg_name = $exp_rg.name
        $exp_rg_location = $exp_rg.location
        Context "Checking Resource Group $exp_rg_name" {
            It "Exists rg $exp_rg_name" {
                $result_list_rg.ResourceGroupName | Should -Contain $exp_rg_name
            }
            It "Is location $exp_rg_location" {
                $spec = $result_list_rg| Where-Object { $_.ResourceGroupName -eq $exp_rg_name}
                $spec.Location |Should -Be $exp_rg_location
            }
            It "Is subscription $SUBSCRIPTION" {
                $spec = $result_list_rg| Where-Object { $_.ResourceGroupName -eq $exp_rg_name}
                $spec.ResourceId |Should -BeLike "*$SUBSCRIPTION*"
            }
        }
    }
}
