# This script attempts to download MorganaXProcIII

# Create the 'lib' directory if it doesn't exist
if (-not (Test-Path -Path "../lib")) {
    New-Item -ItemType Directory -Path "../lib" | Out-Null
}

# Navigate into the 'lib' directory
Push-Location -Path "../lib"

# XML Calabash version

# https://codeberg.org/xmlcalabash/xmlcalabash3/releases/download/3.0.45/xmlcalabash-3.0.45.zip

$VERSION = "3.0.45"
$RELEASES = "https://codeberg.org/xmlcalabash/xmlcalabash3/releases/download"
$ZIPFILE = "xmlcalabash-$VERSION.zip"


# Check if we already got one
if (-not (Test-Path -Path "$ZIPFILE")) {
    Write-Host "Looking for XML Calabash version $VERSION from releases page $RELEASES ..."
    Invoke-WebRequest -UserAgent "Wget" -Uri "$RELEASES/$VERSION/$ZIPFILE" -OutFile "$ZIPFILE" -ErrorAction:Stop
    Write-Host "Downloaded $ZIPFILE ..."
    
    # Unzip the downloaded file
    Expand-Archive -Path "$ZIPFILE" -DestinationPath "." -Force
    Write-Host "XML Calabash is available - next, try executing a pipeline ..."
    # Remove-Item __MACOSX -Recurse
} else {
    Write-Host "You have $ZIPFILE in directory lib -- please remove or rename, or unzip in place"
}

Write-Host "Hint: ./xc.sh smoketest/TEST-XPROC3.xpl (Linux/WSL) or xc.ps1 smoketest\TEST-XPROC3.xpl (Windows CMD)"
# Return to the previous location
Pop-Location
