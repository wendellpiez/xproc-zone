# This script attempts to download MorganaXProcIII

# Create the 'lib' directory if it doesn't exist
if (-not (Test-Path -Path "../lib")) {
    New-Item -ItemType Directory -Path "../lib" | Out-Null
}

# Navigate into the 'lib' directory
Push-Location -Path "../lib"

# Morgana version and download URL
$morgana = "MorganaXProc-IIIse-1.6.4"
$morgana_download = "https://sourceforge.net/projects/morganaxproc-iiise/files/$morgana/$morgana.zip"

# https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.6.4/MorganaXProc-IIIse-1.6.4.zip/download

Write-Host "Looking for Morgana at $morgana_download"

# Check if Morgana zip file exists
if (-not (Test-Path -Path "$morgana.xzip")) {
    Write-Host "Downloading Morgana XProc III SE ..."
    Invoke-WebRequest -UserAgent "Wget" -Uri "$morgana_download" -OutFile "$morgana.zip" -ErrorAction:Stop

    # Unzip the downloaded file
    Expand-Archive -Path "$morgana.zip" -DestinationPath "." -Force
    Remove-Item __MACOSX -Recurse
    
    # Make the Morgana.sh script executable
    # (This is not necessary for Windows, but included for parity)
    # Set-ItemProperty -Path "$morgana\Morgana.sh" -Name IsReadOnly -Value $false
} else {
    Write-Host "You have $morgana in directory lib"
}

Write-Host "Morgana is available - next, try executing a bare pipeline such as smoketest/TEST-XPROC3.xpl ..."
Write-Host "Hint: ./xp3.sh smoketest/TEST-XPROC3.xpl (Linux/WSL) or xp3 smoketest\TEST-XPROC3.xpl (Windows CMD)"
Write-Host "Then run the pipeline lib/GRAB-SAXON.xpl to download, unzip and install the Saxon-HE processor, enabling XSLT and XQuery in your XProc pipelines"

# Return to the previous location
Pop-Location
