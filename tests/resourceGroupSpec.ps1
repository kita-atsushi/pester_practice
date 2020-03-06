Param([parameter(mandatory=$true)][String] $envName )
$cwd = $PSScriptRoot
. "$cwd/util.ps1"
$config_path = "$cwd" + "/../config/" + $envName + "_config.ps1"
Write-Host "Read config=$config_path"
. $config_path

Describe 'Resource group Spec' {
    $result_list_rg = Get-AzResourceGroup
    foreach($exp_rg in $EXP_RG_ARRAY) {
        $exp_rg_name = $exp_rg.name
        It "Exists rg $exp_rg_name" {
            $result_list_rg.ResourceGroupName | Should -Contain $exp_rg_name
        }
        $exp_rg_location = $exp_rg.location
        It " * Is location $exp_rg_location" {
            $spec = $result_list_rg| Where-Object { $_.ResourceGroupName -eq $exp_rg_name}
            $spec.Location |Should -Be $exp_rg_location
        }
        It " * In subscription $SUBSCRIPTION" {
            $spec = $result_list_rg| Where-Object { $_.ResourceGroupName -eq $exp_rg_name}
            $spec.ResourceId |Should -BeLike "*$SUBSCRIPTION*"
        }
    }
}
