function Test-WinUtilPackageManager {
    <#

    .SYNOPSIS
        Checks if Winget and/or Choco are installed

    .PARAMETER winget
        Check if Winget is installed

    .PARAMETER choco
        Check if Chocolatey is installed

    #>

    Param(
        [System.Management.Automation.SwitchParameter]$winget,
        [System.Management.Automation.SwitchParameter]$choco
    )

    $status = "not-installed"

    if ($winget) {
        # Check if Winget is available while getting it's Version if it's available
        $wingetExists = $true
        try {
            $wingetVersionFull = winget --version
        }
        catch [System.Management.Automation.CommandNotFoundException], [System.Management.Automation.ApplicationFailedException] {
            Write-Warning "Winget 未找到，其命令不可用"
            $wingetExists = $false
        }
        catch {
            Write-Warning "Winget 未找到，原因未知，栈跟踪如下:`n$($psitem.Exception.StackTrace)"
            $wingetExists = $false
        }

        # If Winget is available, Parse it's Version and give proper information to Terminal Output.
        # If it isn't available, the return of this funtion will be "not-installed", indicating that
        # Winget isn't installed/available on The System.
        if ($wingetExists) {
            # Check if Preview Version
            if ($wingetVersionFull.Contains("-preview")) {
                $wingetVersion = $wingetVersionFull.Trim("-preview")
                $wingetPreview = $true
            }
            else {
                $wingetVersion = $wingetVersionFull
                $wingetPreview = $false
            }

            # Check if Winget's Version is too old.
            $wingetCurrentVersion = [System.Version]::Parse($wingetVersion.Trim('v'))
            # Grabs the latest release of Winget from the Github API for version check process.
            $response = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/Winget-cli/releases/latest" -Method Get -ErrorAction Stop
            $wingetLatestVersion = [System.Version]::Parse(($response.tag_name).Trim('v')) #Stores version number of latest release.
            $wingetOutdated = $wingetCurrentVersion -lt $wingetLatestVersion
            Write-Host "===========================================" -ForegroundColor Green
            Write-Host "---            Winget 已安装            ---" -ForegroundColor Green
            Write-Host "===========================================" -ForegroundColor Green
            Write-Host "版本: $wingetVersionFull" -ForegroundColor White

            if (!$wingetPreview) {
                Write-Host "    - Winget 是发布版本" -ForegroundColor Green
            }
            else {
                Write-Host "    - Winget 是预览版本，可能会出现意外的问题" -ForegroundColor Yellow
            }

            if (!$wingetOutdated) {
                Write-Host "    - Winget 是最新版本" -ForegroundColor Green
                $status = "installed"
            }
            else {
                Write-Host "    - Winget 版本过旧" -ForegroundColor Red
                $status = "outdated"
            }
        }
        else {
            Write-Host "===========================================" -ForegroundColor Red
            Write-Host "---           Winget 未安装             ---" -ForegroundColor Red
            Write-Host "===========================================" -ForegroundColor Red
            $status = "not-installed"
        }
    }

    if ($choco) {
        if ((Get-Command -Name choco -ErrorAction Ignore) -and ($chocoVersion = (Get-Item "$env:ChocolateyInstall\choco.exe" -ErrorAction Ignore).VersionInfo.ProductVersion)) {
            Write-Host "===========================================" -ForegroundColor Green
            Write-Host "---         Chocolatey 已安装           ---" -ForegroundColor Green
            Write-Host "===========================================" -ForegroundColor Green
            Write-Host "Version: v$chocoVersion" -ForegroundColor White
            $status = "installed"
        }
        else {
            Write-Host "===========================================" -ForegroundColor Red
            Write-Host "---         Chocolatey 未安装           ---" -ForegroundColor Red
            Write-Host "===========================================" -ForegroundColor Red
            $status = "not-installed"
        }
    }

    return $status
}
