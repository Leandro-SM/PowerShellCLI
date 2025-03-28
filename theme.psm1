$global:Theme = @{
    "Header"   = "Cyan"
    "Menu"     = "Yellow"
    "Warning"  = "Red"
    "Success"  = "Green"
    "Error"    = "DarkRed"
    "Info"     = "Blue"
}

function Set-Theme {
    param (
        [string]$Section,
        [string]$Color
    )
    if ($global:Theme.ContainsKey($Section)) {
        $global:Theme[$Section] = $Color
    } else {
        Write-Host "Seção inválida!" -ForegroundColor Red
    }
}
Export-ModuleMember -Function Set-Theme
