function PingSS {
    param ([string]$Target)
    Test-NetConnection -ComputerName $Target
}

function Scan {
    param ([string]$Subnet)
    1..254 | ForEach-Object { Test-Connection -Target "$Subnet.$_" }
}

function Set-IP {
    param ([string]$InterfaceAlias, [string]$IPAddress, [string]$Gateway)
    New-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $Gateway
}


function scanNmap {
    param ([string]$rangeip)
    nmap -sn $rangeip
}

function Resolve-DNS {
    param (
        [string]$Hostname
    )

    try {
        $dnsResult = Resolve-DnsName -Name $Hostname -ErrorAction Stop
        $dnsResult | Select-Object Name, IPAddress | Format-Table -AutoSize
    } catch {
        Write-Host "⚠ Falha ao resolver $Hostname!" -ForegroundColor Red
    }
}
