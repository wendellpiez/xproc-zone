# This script attempts to download MorganaXProcIII

# Create the 'lib' directory if it doesn't exist
if (-not (Test-Path -Path "../lib")) {
    New-Item -ItemType Directory -Path "../lib" | Out-Null
}

# Navigate into the 'lib' directory
Push-Location -Path "../lib"

# Morgana version and download URL
$morgana = "MorganaXProc-IIIse-1.8.9"
$morgana_download = "https://sourceforge.net/projects/morganaxproc-iiise/files/$morgana/$morgana.zip"

# https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.8.9/MorganaXProc-IIIse-1.8.9.zip/download


# Check if folder is already there, balk if so
if (Test-Path -Path "MorganaXProc-IIIse") {
    Write-Host "You have a MorganaXProc-IIIse folder in your ../lib - please remove or rename it to proceed ..."
    Pop-Location
    Return
}

# Check if Morgana zip file exists
elseif (-not (Test-Path -Path "$morgana.zip")) {
    Write-Host "Looking for {$morgana} from releases page $RELEASES ..."
    Invoke-WebRequest -UserAgent "Wget" -Uri "$morgana_download" -OutFile "$morgana.zip" -ErrorAction:Stop
    Write-Host "Downloaded $morgana.zip ..."

} else {
    Write-Host "You have $morgana in directory lib"
    # pausing to wait for a keystroke -
    [void]$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Unzip the downloaded file
Expand-Archive -Path "$morgana.zip" -DestinationPath "MorganaXProc-IIIse" -Force
# Remove-Item __MACOSX -Recurse

# Make the Morgana.sh script executable
# (This is not necessary for Windows, but included for parity)
# Set-ItemProperty -Path "$morgana\Morgana.sh" -Name IsReadOnly -Value $false

Write-Host "Morgana is available - next, try executing a bare pipeline such as smoketest/TEST-XPROC3.xpl ..."
Write-Host "Hint: ./xz.sh smoketest/TEST-XPROC3.xpl (Linux/WSL) or xz.bat smoketest\TEST-XPROC3.xpl (Windows CMD)"
Write-Host "Then run the pipeline lib/GRAB-SAXON.xpl to download, unzip and install the Saxon-HE processor, enabling XSLT and XQuery in your XProc pipelines"

# Return to the previous location
Pop-Location
