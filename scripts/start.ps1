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
    Write-Host "===========================================" -Foregroundcolor Red
    Write-Host "-- Scripts must be run as Administrator ---" -Foregroundcolor Red
    Write-Host "-- Right-Click Start -> Terminal(Admin) ---" -Foregroundcolor Red
    Write-Host "===========================================" -Foregroundcolor Red
    # Try to restart script as admin
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c start $PSCommandPath" -Verb RunAs
    break
}

# Set PowerShell window title
$Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Admin)"
clear-host
