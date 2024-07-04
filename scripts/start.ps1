<#
.NOTES
    Author         : Chris Titus @christitustech
    Runspace Author: @DeveloperDurp
    GitHub         : https://github.com/ChrisTitusTech
    Version        : #{replaceme}
#>
param (
    [switch]$Debug,
    [string]$Config,
    [switch]$Run
)

# Set DebugPreference based on the -Debug switch
if ($Debug) {
    $DebugPreference = "Continue"
}

if ($Config) {
    $PARAM_CONFIG = $Config
}

$PARAM_RUN = $false
# Handle the -Run switch
if ($Run) {
    Write-Host "Running config file tasks..."
    $PARAM_RUN = $true
}

if (!(Test-Path -Path $ENV:TEMP)) {
    New-Item -ItemType Directory -Force -Path $ENV:TEMP
}

Start-Transcript $ENV:TEMP\Winutil.log -Append

# Load DLLs
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# Variable to sync between runspaces
$sync = [Hashtable]::Synchronized(@{})
$sync.PSScriptRoot = $PSScriptRoot
$sync.version = "#{replaceme}"
$sync.configs = @{}
$sync.ProcessRunning = $false

# If script isn't running as admin, show error message and quit
If (([Security.Principal.WindowsIdentity]::GetCurrent()).Owner.Value -ne "S-1-5-32-544") {
    Write-Host "==================================" -Foregroundcolor Red
    Write-Host "--   脚本需要以管理员权限运行   --" -Foregroundcolor Red
    Write-Host "-- 右键开始按钮 -> 终端(管理员) --" -Foregroundcolor Red
    Write-Host "==================================" -Foregroundcolor Red
    # Try to restart script as admin
    $Console = "powershell"
    if (Test-Path "C:\Users\$env:username\AppData\Local\Microsoft\WindowsApps\wt.exe") {
        $Console = "wt powershell"
    }
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c start $Console $PSCommandPath" -Verb RunAs
    break
}

# Set PowerShell window title
$Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(管理员)"
clear-host
