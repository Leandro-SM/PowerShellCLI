Import-Module "$PSScriptRoot\Modules\Files.psm1"
Import-Module "$PSScriptRoot\Modules\Services.psm1" -force
Import-Module "$PSScriptRoot\Modules\Tasks.psm1"
Import-Module "$PSScriptRoot\Modules\Network.psm1"
Import-Module "$PSScriptRoot\Modules\SO.psm1"
Import-Module "$PSScriptRoot\Modules\theme.psm1"


if (-not $global:Theme) {
    $global:Theme = @{
        "Header" = "Cyan"
        "Menu" = "Yellow"
        "Warning" = "Red"
    }
}



if (-not $global:Theme.ContainsKey("Header")) {
    $global:Theme["Header"] = "Cyan"
}


if (-not $global:Theme) {
    $global:Theme = @{"Header" = "Cyan"; "Menu" = "yellow"; "Warning" = "red"}


}

Start-Transcript -Path "C:\log.txt" -Append

function Get_Choice {
    param (
        [string]$message
    )
    return Read-Host $message
}

function Show_Header {
Write-Host @"
=======================================================================
 
__________                           _________.__           .__  .__   
\______   \______  _  __ ___________/   _____/|  |__   ____ |  | |  |  
 |     ___/  _ \ \/ \/ // __ \_  __ \_____  \ |  |  \_/ __ \|  | |  |  
 |    |  (  <_> )     /\  ___/|  | \/        \|   Y  \  ___/|  |_|  |__
 |____|   \____/ \/\_/  \___  >__| /_______  /|___|  /\___  >____/____/
                            \/             \/      \/     \/           
=======================================================================
"@
}





function Show_Menu {
    Show_Header
    Write-Host "Digite . para ver o que esse CLI faz" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "[1] Gerenciar Arquivos e Pastas" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Gerenciar Serviços" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Remote Desktop Services" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Gerenciar Tarefas" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[5] Configurações de Rede" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[6] Aplicativos e Configurações" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[7] Servidores" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[8] Active Directory" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[9] Acesso Remoto" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[10] Automação" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[0] Sair" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
}


#------------------------------------------------------

#Acesso remoto

function Gestao_Remota {
While ($true) {
        Show_Header
        Write-Host "🖲️ Gerenciamento Remoto" -ForegroundColor Red
        Write-Host ""
        Write-Host "[1] Reiniciar Computador" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[2] Listar Usuários" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[3] Desligar Computador" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[4] Acessar c$ SMB do Equipamento" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[5] Invoke-Command" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        $choice = Get_Choice "Escolha uma opção"

        switch ($choice) {
            1 { Write-Host "Função não implementada" }
            2 { Write-Host "Função não implementada" }
            3 { Write-Host "Função não implementada" } 
            4 { Write-Host "Função não implementada" } 
            5 { Write-Host "Função não implementada" }
            0 { return }
            default { Write-Host "⚠ Opção inválida!" } 
        }
    }
}




#------------------------------------------------------


#Automação






#------------------------------------------------------


# RDS



# Menu RDS

function Gestao_RDS {
    While ($true) {
        Show_Header
        Write-Host "Gerenciamento dos Servidores de Acesso Remoto" -ForegroundColor Red
        Write-Host ""
        Write-Host "[1] Listar Usuários RDS" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[2] Derrubar Usuário" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[3] Enviar Mensagem para o SRV" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[4] Derrubar Todos" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[5] Status Servidores" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        $choice = Get_Choice "Escolha uma opção"

        switch ($choice) {
            1 { UsuariosRDS
                Start-Sleep -Seconds 12
            }
            2 { DerrubarUserRDS }
            3 { EnviarMSGS_RDS } 
            4 { Write-Host "Função não implementada" } 
            5 { servidoresrds }
            0 { return }
            default { Write-Host "⚠ Opção inválida!" } 
        }
    }
}

# [1] Está em Services.psm1

Function UsuariosRDS {
    echo "--------------------"
    echo "Usuarios no Servidor01"
    echo ""
    qwinsta /server ip
    echo "--------------------"
    echo ""
    echo "Usuarios no Servidor02"
    echo ""
    qwinsta /server ip
    echo "--------------------"
    echo ""
    echo "Usuarios no Servidor03"
    echo ""
    qwinsta /server ip
    echo "---------------------"
}




# [2] Derrubar Usuarios

function DerrubarUserRDS {
    While ($true) {
        Show_Header
        Write-Host "😎 Qual usuário você quer derrubar?" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o ID e o SRV" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 10 192.168.24" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Ou digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Header"]
        Write-Host ""

        $input = Read-Host "..."
        if ($input -eq "sair") {
            break
        }

        $parts = $input -split " "
        if ($parts.Count -eq 2) {
            $id = $parts[0]
            $srv = $parts[1]
            logoutUser -id $id -srv $srv
        } else {
            Write-Host "⚠ Entrada inválida! Use o formato: ID SRV (ex: 5 e 192.168.1.52)" -ForegroundColor $global:Theme["Warning"]
        }
        
        Start-Sleep -Seconds 2
    }
}



function logoutUser {
    param (
           [string]$id,
           [string]$srv
           )
    rwinsta /server:$srv $id

}



# [3] Enviar MSG para o Servidor

function EnviarMSGS_RDS {
    While ($true) {
        Show_Header
        Write-Host "😄 Que mensagem você quer enviar?" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o Servidor e em seguida o texto a ser exibido no SRV" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: '192.168.1.52 Estamos realizando uma manutenção no servidor, salve seu trabalho!'"
        Write-Host ""
        Write-Host "(Ou digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Header"]
        
        $input = Read-Host "Insira o SRV e Mensagem"
        if ($input -eq "sair") {
            break
        }

        $parts = $input -split " ", 2  
        if ($parts.Count -eq 2) {
            $server = $parts[0]
            $mensagem = $parts[1]
            msgRDS -servidor $server -mensagem $mensagem
        } else {
            Write-Host "⚠ Entrada inválida! Use o formato: <servidor> <mensagem>" -ForegroundColor Yellow
        }
    }
}

function msgRDS {
    param ([string]$servidor, [string]$mensagem)
    msg * /server:$servidor $mensagem
    Start-Sleep -Seconds 5
}



# 3 Ping
function servidoresrds {
    echo "------------------------"
    echo "SRV01"
    ping IP_SRV_01
    echo ""
    echo "------------------------"
    echo "SRV02"
    ping IP_SRV_02
    echo ""
    echo "------------------------"
    echo "SRV03"
    ping IP_SRV_01
    echo "------------------------"
}

 







#------------------------------------------------------


#AD

function Show_ActiveDirectoryMenu {
    while ($true){
    Show_Header
    Write-Host "📰 Gerenciamento do Active Directory" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "[1] Criar Usuário" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Copiar Usuário" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Alterar Senha de Usuário" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Desabilitar Usuário" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[5] Deletar Usuário" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[6] Listar Usuários" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[7] Pesquisar Usuário" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[8] Criar Computador" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[9] Pesquisar Computador" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[10] Deletar Computador" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice){
    1  { Show_ActiveDirectoryCreateUser     }
    2  { Show_ActiveDirectoryCopyUser       }
    3  { Show_ActiveDirectoryPasswordUser   }
    4  { Show_ActiveDirectoryDisableUser    }
    5  { Show_ActiveDirectoryDeleteUser     }
    6  { Show_ActiveDirectoryListUsers      }
    7  { Show_ActiveDirectorySearchUser     }
    8  { Show_ActiveDirectoryCreateComputer }
    9  { Show_ActiveDirectorySearchComputer }
    10 { Show_ActiveDirectoryDeleteComputer }
    0  { return }
                    }
                }
}

    
    
function Show_ActiveDirectoryCreateUser {
    while ($true) {
    Show_Header
    Write-Host "🥲 Criação de Usuário Active Directory" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Em andamento!" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar"
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    0 { return }
    }

    }
}      


function Show_ActiveDirectoryCopyUser {
    while ($true) {
    Show_Header
    Write-Host "🥲 Copiar Usuário Active Directory" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Em andamento!" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar"
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    0 { return }
    }

    }
}      


function Show_ActiveDirectoryPasswordUser {
    while ($true) {
        Show_Header
        Write-Host "🥲 Alterar a Senha de um Usuário Active Directory" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o usuário e a nova senha para alteração." -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: leandro.medeiros" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"] 
        Write-Host ""

        $UserName = Read-Host "Digite o nome do usuário"

        if ($UserName -eq "sair") {
            break
        }

        $NewPassword = Read-Host "Digite a nova senha" -AsSecureString

        $ConfirmPassword = Read-Host "Confirme a nova senha" -AsSecureString

        
        $pwd1 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($NewPassword))
        $pwd2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ConfirmPassword))

        if ($pwd1 -ne $pwd2) {ss
            Write-Host "❌ As senhas não coincidem. Tente novamente!" -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }

        changePassword -UserName $UserName -NewPassword $NewPassword
    }
}

function changePassword {
    param (
        [string]$UserName,
        [SecureString]$NewPassword
    )

    try {
        Set-ADAccountPassword -Identity $UserName -NewPassword $NewPassword


        Write-Host "✅ Senha do usuário '$UserName' alterada com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Erro ao alterar a senha: $_" -ForegroundColor Red
        Start-Sleep -Seconds 5
    }
}





function Show_ActiveDirectoryDisableUser {
    while ($true) {
    Show_Header
    Write-Host "🥲 Desabilitar Usuário Active Directory" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Em andamento!" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar"
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    0 { return }
    }

    }
}


function Show_ActiveDirectoryDeleteUser {
    while ($true) {
    Show_Header
    Write-Host "🥲 Deletar Usuário Active Directory" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Em andamento!" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar"
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    0 { return }
    }

    }
}

Show_ActiveDirectoryListUsers


function Listar-Usuarios {
    param (
        [string]$OU
    )
    Get-ADUser -Filter * -SearchBase $OU
}



function Show_ActiveDirectoryCreateComputer {
    while ($true) {
    Show_Header
    Write-Host "🥲 Criar Computador Active Directory" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Em andamento!" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar"
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    0 { return }
    }

    }
}




function Show_ActiveDirectoryDeleteComputer {
    while ($true) {
    Show_Header
    Write-Host "🥲 Deletar Computador Active Directory" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Em andamento!" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar"
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    0 { return }
    }

    }
}








function Show_ActiveDirectorySearchUser {
    while ($true) {
        Show_Header
        Write-Host "🔍 Pesquisar Usuários no Active Directory" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o nome ou parte do nome do usuário para buscar." -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: joao.silva" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"] 
        Write-Host ""

        $searchQuery = Read-Host "Digite o nome do usuário"
        if ($searchQuery -eq "sair") { return }

        try {
            $users = Get-ADUser -Filter {Name -like "*$searchQuery*"} -Properties Name, SamAccountName, Enabled
            
            if ($users.Count -eq 0) {
                Write-Host "⚠ Nenhum usuário encontrado." -ForegroundColor Yellow
            } else {
                Write-Host "Usuários encontrados:" -ForegroundColor Cyan
                $users | Format-Table Name, SamAccountName, Enabled -AutoSize
            }
        } catch {
            Write-Host "❌ Erro ao buscar usuários: $_" -ForegroundColor Red
        }

        Write-Host ""
        Pause
    }
}

function Show_ActiveDirectorySearchComputer {
    while ($true) {
        Show_Header
        Write-Host "🔍 Pesquisar Computadores no Active Directory" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o nome ou parte do nome do computador para buscar." -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: PC-001" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"] 
        Write-Host ""

        $searchQuery = Read-Host "Digite o nome do computador"
        if ($searchQuery -eq "sair") { return }

        try {
            $computers = Get-ADComputer -Filter {Name -like "*$searchQuery*"} -Properties Name, Enabled
            
            if ($computers.Count -eq 0) {
                Write-Host "⚠ Nenhum computador encontrado." -ForegroundColor Yellow
            } else {
                Write-Host "Computadores encontrados:" -ForegroundColor Cyan
                $computers | Format-Table Name, Enabled -AutoSize
            }
        } catch {
            Write-Host "❌ Erro ao buscar computadores: $_" -ForegroundColor Red
        }

        Write-Host ""
        Pause
    }
}










#------------------------------------------------------

# Funções para Pastas

function Show_FileManagement {
   While ($true) {
    Show_Header
    Write-Host "📂 Gerenciamento de Arquivos e Pastas" -ForegroundColor Red
    Write-Host ""
    Write-Host "[1] Criar pasta" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Criar arquivo" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[3] Listar arquivos" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Deletar arquivo" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[5] Editar arquivo" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[6] Copiar arquivo/pasta" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[7] Mover arquivo/pasta" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[8] Renomear arquivo/pasta" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[9] Obter propriedades" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
        1 { FileManagement_Create }
        2 { FileManagement_CreateFile }
        3 { FileManagement_LS }
        4 { FileManagement_RM }
        5 { FileManagement_EditFile }
        6 { FileManagement_Copy }
        7 { FileManagement_Move }
        8 { FileManagement_Rename }
        9 { FileManagement_Properties }
        0 { return }
        default { Write-Host "⚠ Opção inválida!" -ForegroundColor Yellow }
    }
    
   }
}




# Criar Pasta

function FileManagement_Create {
    While ($true) {
        Show_Header
        Write-Host "📂 Criar Pastas" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho onde deseja criar a pasta" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: C:\Users\Public\NovaPasta"
        Write-Host ""
        Write-Host "(Ou digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $folderPath = Read-Host "Caminho da pasta"

        if ($folderPath -eq "sair") { break }

        if (Test-Path $folderPath) {
            Write-Host "⚠ A pasta já existe!" -ForegroundColor Yellow
        } else {
            try {
                New-Item -Path $folderPath -ItemType Directory -Force
                Write-Host "✅ Pasta criada com sucesso!" -ForegroundColor Green
            } catch {
                Write-Host "❌ Erro ao criar a pasta: $_" -ForegroundColor Red
            }
        }
        Start-Sleep -Seconds 2
    }
}


# Criar Arquivos

function FileManagement_CreateFile {
    While ($true) {
        Show_Header
        Write-Host "📄 Criar Arquivo" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho completo do arquivo a ser criado" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: C:\Users\Public\meuarquivo.txt"
        Write-Host ""
        Write-Host "(Ou digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $filePath = Read-Host "Caminho do arquivo"

        if ($filePath -eq "sair") { break }

        $directory = [System.IO.Path]::GetDirectoryName($filePath)


        if (-not (Test-Path $directory)) {
            Write-Host "❌ O diretório '$directory' não existe!" -ForegroundColor Red
            $createDir = Read-Host "Deseja criar o diretório? (S/N)"
            if ($createDir -match "^[sS]$") {
                try {
                    New-Item -Path $directory -ItemType Directory -Force | Out-Null
                    Write-Host "✅ Diretório criado com sucesso!" -ForegroundColor Green
                } catch {
                    Write-Host "❌ Erro ao criar o diretório: $_" -ForegroundColor Red
                    continue
                }
            } else {
                Write-Host "⚠ Operação cancelada!" -ForegroundColor Yellow
                continue
            }
        }

        if (Test-Path $filePath) {
            Write-Host "⚠ O arquivo '$filePath' já existe!" -ForegroundColor Yellow
            $overwrite = Read-Host "Deseja sobrescrevê-lo? (S/N)"
            if ($overwrite -notmatch "^[sS]$") {
                Write-Host "⚠ Operação cancelada!" -ForegroundColor Yellow
                continue
            }
        }

        
        try {
            New-Item -Path $filePath -ItemType File -Force | Out-Null
            Write-Host "✅ Arquivo criado com sucesso!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Erro ao criar o arquivo: $_" -ForegroundColor Red
        }

        Start-Sleep -Seconds 2
    }
}








# Listar Arquivos

function FileManagement_LS {
    While ($true) {
        Show_Header
        Write-Host "📂 Listar Arquivos" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho da pasta que deseja listar os arquivos" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: C:\Users\Public"
        Write-Host ""
        Write-Host "(Ou digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $folderPath = Read-Host "Caminho da pasta"

        if ($folderPath -eq "sair") { break }

        if (Test-Path $folderPath) {
            Get-ChildItem -Path $folderPath -Force | Select-Object Name, Length, LastWriteTime | Format-Table -AutoSize
        } else {
            Write-Host "❌ Caminho inválido ou pasta não encontrada!" -ForegroundColor Red
        }
        Start-Sleep -Seconds 10
    }
}

# Deletar

function FileManagement_RM {
    While ($true) {
        Show_Header
        Write-Host "🗑 Deletar Arquivo" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho completo do arquivo a ser deletado" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: C:\Users\Public\documento.txt"
        Write-Host ""
        Write-Host "(Ou digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $filePath = Read-Host "Caminho do arquivo"

        if ($filePath -eq "sair") { break }

        if (Test-Path $filePath) {
            $confirm = Read-Host "Tem certeza que deseja deletar '$filePath'? (S/N)"
            if ($confirm -match "^[sS]$") {
                try {
                    Remove-Item -Path $filePath -Force
                    Write-Host "✅ Arquivo removido com sucesso!" -ForegroundColor Green
                } catch {
                    Write-Host "❌ Erro ao deletar o arquivo: $_" -ForegroundColor Red
                }
            } else {
                Write-Host "⚠ Operação cancelada!" -ForegroundColor Yellow
            }
        } else {
            Write-Host "❌ Arquivo não encontrado!" -ForegroundColor Red
        }
        Start-Sleep -Seconds 2
    }
}



# Editar Arquivos

function FileManagement_EditFile {
    While ($true) {
        Show_Header
        Write-Host "📝 Gerenciamento de Arquivos" -ForegroundColor Red
        Write-Host ""
        Write-Host "[1] Visualizar Arquivo" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[2] Editar Arquivo" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        
        $choice = Read-Host "Escolha uma opção"

        switch ($choice) {
            1 { FileManagement_ViewFile }
            2 { FileManagement_EditFileAction }
            0 { return }
            default { Write-Host "⚠ Opção inválida!" -ForegroundColor Yellow }
        }
    }
}

function FileManagement_ViewFile {
    While ($true) {
        Show_Header
        Write-Host "📜 Visualizar Arquivo" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Digite o caminho completo do arquivo para visualizar" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $filePath = Read-Host "Caminho do arquivo"

        if ($filePath -eq "sair") { break }

        if (-not (Test-Path $filePath)) {
            Write-Host "❌ O arquivo '$filePath' não existe!" -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }

        Write-Host "`n📄 Conteúdo do Arquivo:" -ForegroundColor Green
        Get-Content $filePath | ForEach-Object { Write-Host $_ }
        
        Write-Host "`nPressione ENTER para voltar..."
        Read-Host
    }
}


# Editar

function FileManagement_EditFileAction {
    While ($true) {
        Show_Header
        Write-Host "✏ Editar Arquivo" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Digite o caminho completo do arquivo que deseja editar" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Ou digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $filePath = Read-Host "Caminho do arquivo"

        if ($filePath -eq "sair") { break }

        if (-not (Test-Path $filePath)) {
            Write-Host "❌ O arquivo '$filePath' não existe!" -ForegroundColor Red
            $createFile = Read-Host "Deseja criar o arquivo? (S/N)"
            if ($createFile -match "^[sS]$") {
                try {
                    New-Item -Path $filePath -ItemType File -Force | Out-Null
                    Write-Host "✅ Arquivo criado com sucesso!" -ForegroundColor Green
                } catch {
                    Write-Host "❌ Erro ao criar o arquivo: $_" -ForegroundColor Red
                    continue
                }
            } else {
                Write-Host "⚠ Operação cancelada!" -ForegroundColor Yellow
                continue
            }
        }

        Write-Host "`n📜 Conteúdo Atual do Arquivo:" -ForegroundColor Cyan
        Get-Content $filePath | ForEach-Object { Write-Host $_ }

        Write-Host "`n✏ Digite o novo conteúdo abaixo (pressione ENTER para salvar ou deixe em branco para cancelar):" -ForegroundColor Yellow
        $newContent = Read-Host "Novo conteúdo"

        if ($newContent -ne "") {
            try {
                $newContent | Set-Content -Path $filePath -Force
                Write-Host "✅ Arquivo atualizado com sucesso!" -ForegroundColor Green
            } catch {
                Write-Host "❌ Erro ao salvar o arquivo: $_" -ForegroundColor Red
            }
        } else {
            Write-Host "⚠ Nenhuma alteração feita!" -ForegroundColor Yellow
        }

        Start-Sleep -Seconds 2
    }
}


#Copiar

function FileManagement_Copy {
    While ($true) {
        Show_Header
        Write-Host "📂 Copiar Arquivo/Pasta" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho do arquivo/pasta de origem:" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para voltar)" -ForegroundColor red
        Write-Host ""
        $source = Read-Host "Origem"
        if ($source -eq "sair") { return }
        
        Write-Host "Digite o caminho de destino:" -ForegroundColor $global:Theme["Menu"]
        $destination = Read-Host "Destino"
        if ($destination -eq "sair") { return }

        if (Test-Path $source) {
            Copy-Item -Path $source -Destination $destination -Recurse -Force
            Write-Host "✅ Arquivo/Pasta copiado com sucesso!" -ForegroundColor Green
        } else {
            Write-Host "❌ O caminho de origem não existe!" -ForegroundColor Red
        }
        Start-Sleep -Seconds 2
    }
}


#Mover

function FileManagement_Move {
    While ($true) {
        Show_Header
        Write-Host "📂 Mover Arquivo/Pasta" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho do arquivo/pasta de origem:" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para voltar)" -ForegroundColor Red
        Write-Host ""
        $source = Read-Host "Origem"
        if ($source -eq "sair") { return }
        
        Write-Host "Digite o caminho de destino:" -ForegroundColor $global:Theme["Menu"]
        $destination = Read-Host "Destino"
        if ($destination -eq "sair") { return }

        if (Test-Path $source) {
            Move-Item -Path $source -Destination $destination -Force
            Write-Host "✅ Arquivo/Pasta movido com sucesso!" -ForegroundColor Green
        } else {
            Write-Host "❌ O caminho de origem não existe!" -ForegroundColor Red
        }
        Start-Sleep -Seconds 2
    }
}


# Renomear

function FileManagement_Rename {
    While ($true) {
        Show_Header
        Write-Host "📂 Renomear Arquivo/Pasta" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho do arquivo/pasta atual:" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para voltar)" -ForegroundColor Red
        Write-Host ""
        $source = Read-Host "Caminho Atual"
        if ($source -eq "sair") { return }
        Write-Host "Digite o novo nome (sem caminho):" -ForegroundColor $global:Theme["Menu"]
        $newName = Read-Host "Novo Nome"
        if ($newName -eq "sair") { return }

        if (Test-Path $source) {
            $path = Split-Path -Path $source
            $newPath = Join-Path -Path $path -ChildPath $newName
            Rename-Item -Path $source -NewName $newPath -Force
            Write-Host "✅ Arquivo/Pasta renomeado com sucesso!" -ForegroundColor Green
        } else {
            Write-Host "❌ O caminho não existe!" -ForegroundColor Red
        }
        Start-Sleep -Seconds 2
    }
}


function FileManagement_Properties {
    While ($true) {
        Show_Header
        Write-Host "📂 Obter Propriedades do Arquivo/Pasta" -ForegroundColor Red
        Write-Host ""
        Write-Host "Digite o caminho do arquivo/pasta:" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para voltar)" -ForegroundColor Red
        Write-Host
        $path = Read-Host "Caminho"
        if ($path -eq "sair") { return }

        if (Test-Path $path) {
            $info = Get-Item $path
            Write-Host "📄 Nome: $($info.Name)" -ForegroundColor Cyan
            Write-Host "📂 Caminho: $($info.FullName)" -ForegroundColor Cyan
            Write-Host "📏 Tamanho: $([math]::Round($info.Length / 1MB, 2)) MB" -ForegroundColor Cyan
            Write-Host "📅 Criado em: $($info.CreationTime)" -ForegroundColor Cyan
            Write-Host "🕒 Última modificação: $($info.LastWriteTime)" -ForegroundColor Cyan
        } else {
            Write-Host "❌ O caminho não existe!" -ForegroundColor Red
        }
        Start-Sleep -Seconds 2
    }
}












#------------------------------------------------------

# Serviços

function Show_ServiceManagement {
    While ($true) {
        Show_Header
        Write-Host "🔧 Gerenciamento de Serviços" -ForegroundColor Red
        Write-Host ""
        Write-Host "[1] Iniciar serviço" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[2] Parar serviço" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[3] Listar serviços" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        $choice = Get_Choice "Escolha uma opção"

        switch ($choice) {
            1 { StartServiceMenu }
            2 { StopServiceMenu }
            3 { Get-Service  
                Start-Sleep -Seconds 10 }
            0 { return }
            default { Write-Host "⚠ Opção inválida!" -ForegroundColor Yellow }
        }
    }
}

function StartServiceMenu {
    While ($true) {
        Show_Header
        Write-Host "🔧 Iniciar Serviços" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o nome do serviço que deseja iniciar (Exemplo: spooler)" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        
        $serviceName = Read-Host "Nome do serviço"

        
        if ($serviceName -eq "sair") {
            break
        }

        
        $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

        if ($service -eq $null) {
            Write-Host "❌ Serviço '$serviceName' não encontrado!" -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }

        
        if ($service.Status -eq "Running") {
            Write-Host "⚠ O serviço '$serviceName' já está em execução!" -ForegroundColor Yellow
            Start-Sleep -Seconds 2
            continue
        }

        
        try {
            Start-Service -Name $serviceName
            Write-Host "✅ Serviço '$serviceName' iniciado com sucesso!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Erro ao iniciar o serviço: $_" -ForegroundColor Red
        }

        Start-Sleep -Seconds 2
    }
}


function StopServiceMenu {
    While ($true) {
        Show_Header
        Write-Host "⛔ Parar Serviços" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o nome do serviço que deseja parar (Exemplo: spooler)" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $serviceName = Read-Host "Nome do serviço"

        if ($serviceName -eq "sair") {
            break
        }

        $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

        if ($service -eq $null) {
            Write-Host "❌ Serviço '$serviceName' não encontrado!" -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }

        if ($service.Status -eq "Stopped") {
            Write-Host "⚠ O serviço '$serviceName' já está parado!" -ForegroundColor Yellow
            Start-Sleep -Seconds 2
            continue
        }

        try {
            Stop-Service -Name $serviceName -Force
            Write-Host "✅ Serviço '$serviceName' parado com sucesso!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Erro ao parar o serviço: $_" -ForegroundColor Red
        }

        Start-Sleep -Seconds 2
    }
}




#------------------------------------------------------

# Tasks


function Show_TaskManagement {
    Show_Header
    Write-Host "⏳ Gerenciamento de Tarefas" -ForegroundColor Red
    Write-Host ""
    Write-Host "[1] Criar tarefa agendada" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Remover tarefa" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Listar tarefas" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"
    
    switch ($choice) {
     1 { taskmanager_create }
     2 { taskmanager_remove }
     3 { taskmanager_list   }   
    }   
}

function taskmanager_create {
    Write-Host "`n📌 Criar nova tarefa agendada" -ForegroundColor Cyan
    Write-Host ""

    $taskName = Read-Host "Digite o nome da tarefa"

    $taskProgram = Read-Host "Digite o caminho do programa ou script a ser executado"

    $taskArguments = Read-Host "Digite argumentos (opcional, pressione Enter para ignorar)"

   
    Write-Host "`nEscolha a frequência de execução:" -ForegroundColor Yellow
    Write-Host "[1] Diariamente"
    Write-Host "[2] No logon do usuário"
    Write-Host "[3] No boot do sistema"
    Write-Host "[4] Uma única vez"
    
    $scheduleType = Read-Host "Digite a opção desejada"

    switch ($scheduleType) {
        1 { $trigger = "Daily" }
        2 { $trigger = "AtLogon" }
        3 { $trigger = "AtStartup" }
        4 { $trigger = "Once" }
        default { 
            Write-Host "Opção inválida. Usando 'Diariamente' como padrão." -ForegroundColor Red
            $trigger = "Daily"
        }
    }

    
    if ($trigger -eq "Daily" -or $trigger -eq "Once") {
        $taskTime = Read-Host "Digite o horário de execução (HH:MM, formato 24h)"
    } else {
        $taskTime = $null
    }

    $command = @("schtasks /create /tn `"$taskName`" /tr `"$taskProgram`"")
    
    if ($taskArguments) { $command += "/arg `"$taskArguments`"" }
    if ($trigger) { $command += "/sc $trigger" }
    if ($taskTime) { $command += "/st $taskTime" }

    try {
        Invoke-Expression ($command -join " ")
        Write-Host "✅ Tarefa '$taskName' criada com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Erro ao criar a tarefa: $_" -ForegroundColor Red
    }

    Start-Sleep -Seconds 2
}

function taskmanager_remove {
    Write-Host "`n❌ Remover tarefa agendada" -ForegroundColor Yellow
    Write-Host ""
    $taskName = Read-Host "Digite o nome da tarefa que deseja remover"

    try {
        schtasks /delete /tn $taskName /f
        Write-Host "✅ Tarefa '$taskName' removida com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Erro ao remover a tarefa: $_" -ForegroundColor Red
    }

    Start-Sleep -Seconds 2
}

function taskmanager_list {
    Write-Host "`n📋 Listando tarefas agendadas..." -ForegroundColor Blue
    Write-Host ""
    try {
        schtasks /query /fo table
    } catch {
        Write-Host "❌ Erro ao listar as tarefas: $_" -ForegroundColor Red
    }

    Start-Sleep -Seconds 15
}





#------------------------------------------------------

# Rede

function Show_NetworkScanner {
    While ($true) {
    Show_Header
    Write-Host "🌐 Scanner de Rede" -ForegroundColor Red
    Write-Host ""
    Write-Host "[1] Scan IPs ativos (-sn Nmap)" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Testar conexão" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Limpar Cache DNS" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Informações de Adaptadores de Rede" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[5] Ipconfig" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[6] Varredura" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"
    switch ($choice) {
    1 { Show_ScanRede }
    2 { TestedeConexao }
    3 { Resolve-DNS 
    Start-Sleep -Seconds 3
    }
    4 { Get-NetAdapter | format-table 
    Start-Sleep -Seconds 10}
    5 { ipconfig /all 
    Start-Sleep -Seconds 10}
    6 { fullscan }
    0 { return }
     }
    }
}



function fullscan {
    While ($true){
    Show_Header
    Write-Host "😵‍💫 Opções de Scan" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "[1] Script" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Detecção de Vunerabilidades" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Scan Agressivo" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Portas TCP e UDP abertas" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[5] Informações do Sistema Operacional" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[6] Analisar todas as Portas" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[7] Verificar Portas Abertas" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""

    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    1 { fullscan_script }
    2 { fullscan_vuln }
    3 { fullscan_agressivo }
    4 { fullscan_tcpudp }
    5 { fullscan_so }
    6 { fullscan_ports }
    7 { fullscan_opendoor }
    0 { return }
    }
    }
}





# 6 fullscan

function fullscan_script {
    while ($true) {
        Show_Header
        Write-Host "🔍 Varredura de Dispositivos na Rede (Com Script)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs ou Hostname" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255 ou DESKTOP001" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
        
        if ($iprange -eq "sair") {
            break
        }

        fullscanNmap_script -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}

function fullscanNmap_script {
    param ([string]$rangeip)
    nmap -sC $rangeip
}



function fullscan_vuln {
    while ($true) {
        Show_Header
        Write-Host "🔍 Varredura de Dispositivos na Rede (Vulnerabilidades)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs ou Hostname" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255 ou DESKTOP001" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
        
        if ($iprange -eq "sair") {
            break
        }

        fullscanNmap_vuln -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}

function fullscanNmap_vuln {
    param ([string]$rangeip)
    nmap --script=vuln $rangeip
}



function fullscan_agressivo {
    while ($true) {
        Show_Header
        Write-Host "🔍 Varredura de Dispositivos na Rede (Agressivo)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs ou Hostname" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255 ou DESKTOP001" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
        
        if ($iprange -eq "sair") {
            break
        }

        fullscanNmap_agressivo -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}

function fullscanNmap_agressivo {
    param ([string]$rangeip)
    nmap -A $rangeip
}



function fullscan_tcpudp {
    while ($true) {
        Show_Header
        Write-Host "🔍 Varredura de Dispositivos na Rede (Agressivo)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs ou Hostname" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255 ou computer001" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
        
        if ($iprange -eq "sair") {
            break
        }

        fullscanNmap_tcpudp -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}

function fullscanNmap_tcpudp {
    param ([string]$rangeip)
    nmap -sS -sU $rangeip
}



function fullscan_so {
    while ($true) {
        Show_Header
        Write-Host "🔍 Varredura de Dispositivos na Rede (Agressivo)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs ou Hostname" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255 ou DESKTOP001" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
        
        if ($iprange -eq "sair") {
            break
        }

        fullscanNmap_so -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}

function fullscanNmap_so {
    param ([string]$rangeip)
    nmap -O $rangeip
}



function fullscan_ports {
    while ($true) {
        Show_Header
        Write-Host "🔍 Varredura de Dispositivos na Rede (Agressivo)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs ou Hostname" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255 ou COMPUTER001" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
       
        if ($iprange -eq "sair") {
            break
        }

        fullscanNmap_ports -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}



function fullscanNmap_ports {
    param ([string]$rangeip)
    nmap -p- $rangeip
}



function fullscan_opendoor {
    while ($true) {
        Show_Header
        Write-Host "🔍 Varredura de Dispositivos na Rede (Agressivo)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs ou Hostname" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255 ou COMPUTER001" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
        
        if ($iprange -eq "sair") {
            break
        }

        fullscanNmap_opendoor -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}

function fullscanNmap_opendoor {
    param ([string]$rangeip)
    nmap -sV $rangeip
}









# 3 DNS

function Resolve-DNS {
  ipconfig /flushdns
  Write-Host "Efetuada limpeza no cache DNS😄" -ForegroundColor Cyan
}


# 1 scan rede

function Show_ScanRede {
    while ($true) {
        Show_Header
        Write-Host "🔍 Scan de Dispositivos na Rede" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o range de IPs" -ForegroundColor $global:Theme["Menu"]
        Write-Host "Exemplo: 192.168.0.1-255" -ForegroundColor $global:Theme["Menu"]
        Write-Host "(Ou digite 'sair' para encerrar)"
        Write-Host ""
        
        $iprange = Read-Host "Range de IPs"
        
        if ($iprange -eq "sair") {
            break
        }

        scanNmap -rangeip $iprange
        Start-Sleep -Seconds 10
    }
}

function scanNmap {
    param ([string]$rangeip)
    nmap -sn $rangeip
}



# 2 testar conexão

function TestedeConexao {
    While ($true){
    Show_Header
        Write-Host "😛 Teste de Conexão com Dispositivos na Rede" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "[1] Testar Conexão com o IP" -ForegroundColor $global:Theme["Menu"]
        Write-Host "[2] \\ no IP " -ForegroundColor $global:Theme["Menu"]
        Write-Host "[3] Informações sobre o Dispositivo (Nmap)" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "[0] Para Voltar" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
    
        $choice = Get_Choice "Escolha uma opção"

        switch ($choice){
        1 { Main_pingSS }
        2 { cdComputer  }
        3 { scan_nmapSO }
        0 { return      }
                        }
                }
}

function Main_PingSS {
    While ($true){
    Show_Header
        Write-Host "😐 Teste de Conexão" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o IP do Equipamento" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        
        $target = Read-Host ".."
        pingSS -Target $target
    }
}

function pingSS {
    param ([string]$target)
    Test-NetConnection -ComputerName $target
}


function cdComputer {
    While ($true){
    Show_Header
        Write-Host "🥸 Acessar Equipamento via \\" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o IP do Equipamento ou HostName do Equipamento" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $targetnote = Read-Host "Equipamento"

        if ($targetnote -eq "sair") {
            break
        }

        & Acessar_Cdolar -targetnote $targetnote
        Start-Sleep -Seconds 10
    }
}

function Acessar_Cdolar {
    param ([string]$targetnote)
    
    if (Test-Connection -ComputerName $targetnote -Count 1 -Quiet) {
        Get-ChildItem "\\$targetnote\c$"
    } else {
        Write-Host "⚠ O equipamento $targetnote não está acessível na rede!" -ForegroundColor Red
    }
}



function scan_nmapSO {
    while ($true) {
        Show_Header
        Write-Host "😗 Informações do SO" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o IP do Equipamento" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Ou digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $iphost = Read-Host "IP"
        if ($iphost -eq "sair") {
            return
        }

        & nmapSO -iphost $iphost

        Start-Sleep -Seconds 10
    }
}

function nmapSO { 
    param([string]$iphost)
    nmap -O $iphost
}









#-------------------------------------------------------

# Servidores

function Show_ServerMenu {
    Show_Header
    Write-Host "💽 Gerenciamento dos Servidores" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "[1] Listar usuários conectados" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Lista de Servidores" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Servidores Ativos (Ping)" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Reiniciar Servidor" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "Por segurança, não há opção para Desligar os servidores por aqui! Haha" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"

    switch ($choice) {
    1 { UsuariosAtivos 
    Start-Sleep -Seconds 10
    }
    2 { listaServers }
    3 { pingRDS 
    Start-Sleep -Seconds 5 }
    4 { resetServer }
    0 { return }
    }
}



# 1 Users
function UsuariosAtivos {

    echo "--------------------"
    echo "Usuarios no Servidor1"
    echo ""
    qwinsta /server IP_servidor1
    echo ""

    
    echo "--------------------"
    echo "Usuarios no AD"
    echo ""
    qwinsta /server IP_servidor2
    echo ""
    }

# 4 Reiniciar

function resetServer {
    While ($true){
    Show_Header
    Write-Host "👉🔁 Reiniciar Servidor" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Digite o IP Servidor que deseja reiniciar" -ForegroundColor $global:Theme["Menu"]
    Write-Host "Exemplo: '192.168.1.10'"   
    Write-Host ""
    Write-Host "Digite 'sair' para Voltar" -ForegroundColor $global:Theme["Warning"]
    
    $serv = Read-Host "Digite o IP"
        if ($serv -eq "sair") {
            break
        }
        reiniciarSRV -ip $serv
        Start-Sleep -Seconds 2
                 }
}

function reiniciarSRV {
    param ([string]$serv)
    restart-computer -computername $serv -force
}













#--------------------------------------------------------



# Sistema

function Show_SystemInteraction {
    While ($true){
    Show_Header
    Write-Host "💻 Interação com o Sistema" -ForegroundColor Red
    Write-Host ""
    Write-Host "[1] Informações do sistema" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Limpar cache" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Reiniciar computador" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Desligar Computador" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[5] Programas" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[6] Certificados" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[7] Consultar Service Tag" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    $choice = Get_Choice "Escolha uma Opção"
    
    switch ($choice){
        1 { Info
            Start-Sleep -Seconds 10
         }
        2 { Clear-TempFolder }
        3 { Restart }
        4 { Shutdown }
        5 { ProgramasMain }
        6 { Show_Certificados 
            Start-Sleep -Seconds 10
        }
        7 { ConsultarST }
        0 { return }
    }
    }
}


function ProgramasMain {
    While ($true) {
    Show_Header
    Write-Host "💻 Programas e Recursos" -ForegroundColor Red
    Write-Host ""
    Write-Host "[1] Listar Aplicativos Instalados" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Instalar Aplicativo" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[3] Desinstalar Aplicativo" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[4] Atualizar Aplicativos" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"
    
    switch ($choice) {
    1 { ListApps 
    Start-Sleep -Seconds 12
    }
    2 { InstallApp }
    3 { UninstallApp }
    4 { UpdateApp 
    Start-Sleep -Seconds 5
    }
    0 { return }
    }
    
    }
}


function ListApps {
    Winget List
}



function UpdateApp {
    Winget upgrade --all --silent
}


function InstallApp {
    While ($true) {
    Show_Header
    Write-Host "💻 Instalar Programa ou Recurso" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Digite o nome do Programa que deseja Instalar" -ForegroundColor $global:Theme["Menu"]
    Write-Host "Exemplo 'VirtualBox'" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "(Digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""

    $nomeapp = Read-Host "Digite o nome do app"
        if ($nomeapp -eq "sair") {
            break
        }
        installwinget -nomeapp $nomeapp
    }
}


function installwinget {
    param ([string]$nomeapp)
    winget install $nomeapp
}



function UninstallApp {
    While ($true) {
    Show_Header
    Write-Host "💻 Desinstalar Programa ou Recursos" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "Digite o nome do Programa que deseja Desinstalar" -ForegroundColor $global:Theme["Menu"]
    Write-Host "Exemplo 'WinRAR'" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    Write-Host "(Digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""

    $nomeapp = Read-Host "Digite o nome do app"
        if ($nomeapp -eq "sair") {
            break
        }
        uninstallwinget -nomeapp $nomeapp
    }
}


function uninstallwinget {
    param ([string]$nomeapp)
    winget uninstall $nomeapp
}



function Show_Certificados {
    Write-Host "🔍 Listando Certificados do Usuário Atual..." -ForegroundColor Yellow
    
    # Obtém os certificados do usuário no repositório Pessoal (CurrentUser\My)
    $certs = Get-ChildItem -Path Cert:\CurrentUser\My

    if ($certs.Count -eq 0) {
        Write-Host "⚠ Nenhum certificado encontrado!" -ForegroundColor Red
    } else {
        $certs | Select-Object Subject, Issuer, NotBefore, NotAfter, Thumbprint | Format-Table -AutoSize
    }
}








function Info {
    Get-ComputerInfo
}

function Clear-TempFolder {
    param (
        [string]$Path = "$env:TEMP"
    )

    if (Test-Path $Path) {
        Write-Host "🗑 Limpando arquivos temporários em: $Path" -ForegroundColor Yellow
        
        
        Get-ChildItem -Path $Path -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

        Write-Host "✅ Arquivos temporários excluídos!" -ForegroundColor Green
    } else {
        Write-Host "⚠ A pasta $Path não foi encontrada!" -ForegroundColor Red
    }
}


function Restart {
    Restart-Computer -Force
}

function Shutdown {
    Stop-Computer -Force
}



function ConsultarST {
    While ($true) {
    Show_Header 
    Write-Host "👥 Consultar ServiceTAG Dell" -ForegroundColor $global:Theme["Warning"]
    Write-Host ""
    Write-Host "[1] Consultar ST do meu Host" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[2] Consultar ST de outro Host" -ForegroundColor $global:Theme["Menu"]
    Write-Host "[0] Voltar" -ForegroundColor $global:Theme["Menu"]
    Write-Host ""
    $choice = Get_Choice "Escolha uma opção"
    
    switch ($choice){
       1 { ValidarST          
        Start-Sleep -Seconds 15
       }
       2 { ValidarSToutroHost_Main}
       0 { return }
    }

    }

}


function ValidarST {
Get-WmiObject -Class Win32_BIOS | Select-Object SerialNumber
}


function ValidarSToutroHost {
    param ([string]$computerhost)
    Get-WmiObject -Class Win32_BIOS -ComputerName $computerhost | Select-Object SerialNumber
}

function ValidarSToutroHost_Main {
    while ($true) {
        Show_Header 
        Write-Host "👥 Consultar ServiceTAG Dell de outro Host" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""
        Write-Host "Digite o nome (Exemplo: COMPUTER091) do equipamento que deseja consultar" -ForegroundColor $global:Theme["Menu"]
        Write-Host ""
        Write-Host "(Ou digite 'sair' para Voltar)" -ForegroundColor $global:Theme["Warning"]
        Write-Host ""

        $computerhost = Read-Host "..."

        if ($computerhost -eq "sair") {
            Write-Host "Saindo..." -ForegroundColor Yellow
            break
        }

        ValidarSToutroHost -computerhost $computerhost
        Start-Sleep -Seconds 10
    }
}







#------------------------------------------------------

# Menu Inicial

while ($true) {
    Show_Menu
    $choice = Read-Host "Escolha uma opção"

    switch ($choice) {
        1 { Show_FileManagement }
        2 { Show_ServiceManagement }
        3 { Gestao_RDS }
        4 { Show_TaskManagement }
        5 { Show_NetworkScanner }
        6 { Show_SystemInteraction }
        7 { Show_ServerMenu }
        8 { Show_ActiveDirectoryMenu }
        9 { Gestao_Remota }

        "." {
            Show_Header
            Write-Host "ℹ️ Powershell CLI automatiza tarefas de suporte e infraestrutura." -ForegroundColor Red
            Write-Host ""
            Read-Host "Pressione Enter para voltar ao Menu"
        }
        0 {
            Write-Host "Saindo..." -ForegroundColor $global:Theme["Warning"]
            Start-Sleep -Seconds 2
            exit
        }
        default {
            Write-Host "⚠ Opção inválida!"
        }
    }
}

Stop-Transcript
