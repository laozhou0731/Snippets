# Sharp Ninja's Powershell Snippets

A collection of PowerShell tools you can add to your profile.

## Windows: 

1. Clone this repository to `$env:OneDrive/Documents/Snippets`
2. In an Administrator elevated editor, edit `$PROFILE.AllUsersAllHosts`.  
3. Add `$env:Snippets="$env:OneDrive/Documents/PowerShell/Snippets"` to the end and save it.

## Linux, WSL, MacOS: 

1. Clone this repository to `/opt/microsoft/powershell/7/Snippets`
2. In an Administrator elevated editor, edit `$PROFILE.AllUsersAllHosts`.  
3. Add `$env:Snippets="/opt/microsoft/powershell/7/Snippets"` to the end and save it.

| Win | *nix | Script           | Description                                                                                                                  |
|-----|------|------------------|------------------------------------------------------------------------------------------------------------------------------|
| [x] | [x]  | bing.ps1         | Search Bing from Powershell.                                                                                                 |
| [x] | [x]  | clean-folder.ps1 | Remove all `bin` and `obj` folders in current path.                                                                          |
| [x] | [x]  | github.ps1       | set $env:GITHUB first to the root of your github repositories.  Then use `hub` or `hub <repository>` to go to those folders. |
| [x] | [ ]  | chocolatey.ps1   | Setup Chocolatey profile in PowerShell.                                                                                      |
| [x] | [x]  | oh-my-posh.ps1   | Initializes Oh-My-Posh for the current PowerShell 
| [x] | [ ]  | devmode.ps1      | Startup VS 2022 Dev Mode Tools.                                                                                              |
Session.                                                                   |
| [x] | [ ]  | repos.ps1        | Commands for **winget**, **scoop**, and **choco**                                                                            |

Place calls to these files in your `$PROFILE`

All scripts work in both PowerShell Core and Windows PowerShell 5.1!

## Example Windows `$PROFILE`

```powershell
$env:Snippets="/opt/microsoft/powershell/7/Snippets"

if ($env:VerboseStartup -eq 'true') {
    [switch]$Verbose = $true
}
else {
    [switch]$Verbose = $false
}

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

try {
    Import-Module Microsoft.PowerShell.Utility

    if (Test-Path $env:Snippets) {
        Push-Location
        Set-Location $env:Snippets
        $snippets = Get-ChildItem *.ps1
        Pop-Location

        $snippets.FullName | ForEach-Object -Process {
            $snippet = $_

            . $snippet -Verbose:$Verbose
        }
    }
    else {
        Write-Verbose "No directory found at [$env:Snippets]" -Verbose:$Verbose
    }

    Write-Verbose 'PowerShell Ready.' -Verbose:$Verbose
}
catch {
    Write-Host $Error    
}
finally {
    Write-Verbose "Leaving $Profile" -Verbose:$Verbose
}
```

## Example Linux, Wsl, MacOS `$PROFILE`

```powershell
$env:Snippets = "$env:OneDrive/Documents/PowerShell/Snippets"

if ($env:VerboseStartup -eq 'true') {
    [switch]$Verbose = $true
}
else {
    [switch]$Verbose = $false
}

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

try {
    Import-Module Microsoft.PowerShell.Utility

    if (Test-Path $env:Snippets) {
        Push-Location
        Set-Location $env:Snippets
        $snippets = Get-ChildItem *.ps1
        Pop-Location

        $snippets.FullName | ForEach-Object -Process {
            $snippet = $_

            . $snippet -Verbose:$Verbose
        }
    }
    else {
        Write-Verbose "No directory found at [$env:Snippets]" -Verbose:$Verbose
    }

    Write-Verbose 'PowerShell Ready.' -Verbose:$Verbose
}
catch {
    Write-Host $Error    
}
finally {
    Write-Verbose "Leaving $Profile" -Verbose:$Verbose
}
```