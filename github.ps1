param([switch]$Verbose = $false)

if (-not $env:SnippetsInitialized) { 
	$fileInfo = New-Object System.IO.FileInfo (Get-Item $PSScriptRoot).FullName
	$path = $fileInfo.Directory.FullName;
	. $path/Snippets/common.ps1; 
	Initialize-Snippets -Verbose:$Verbose 
}

try {
	if (-not $env:GITHUB) {
		$env:GITHUB = (Get-ChildItem -Filter GitHub -Path C:\ -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1).FullName
	}

	function Set-LocationGitHub {
		param(
			[string]$Repository = '',
			[switch]$V = $false
		)

		Write-Verbose "`$env:GITHUB:  [$($env:GITHUB)]" -Verbose:$V
		Write-Verbose "`$Repository:  [$Repository]" -Verbose:$V
		Set-Location (Join-Path $env:GITHUB -Child $Repository)
	}

	Set-Alias -Name hub -Value Set-LocationGitHub
}
catch {
	Write-Host $Error    
}
finally {
	Write-Verbose 'Leaving github.ps1' -Verbose:$Verbose
}
