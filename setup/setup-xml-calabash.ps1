 # This script attempts to download MorganaXProcIII

# Create the 'lib' directory if it doesn't exist
if (-not (Test-Path -Path "../lib")) {
    New-Item -ItemType Directory -Path "../lib" | Out-Null
}

# Navigate into the 'lib' directory
Push-Location -Path "../lib"

# XML Calabash version
# https://codeberg.org/xmlcalabash/xmlcalabash3/releases/download/3.0.45/xmlcalabash-3.0.45.zip

$VERSION = "3.0.47"
$RELEASES = "https://codeberg.org/xmlcalabash/xmlcalabash3/releases/download"
$ZIPFILE = "xmlcalabash-$VERSION.zip"

# Check if folder is already there, balk if so
if (Test-Path -Path "XMLCalabash") {
    Write-Host "You have an XMLCalabash folder in your ../lib - please remove or rename it to proceed ..."
    Pop-Location
    Return
}

# Check if we already got one
elseif (-not (Test-Path -Path "$ZIPFILE")) {
    Write-Host "Looking for XML Calabash version $VERSION from releases page $RELEASES ..."
    Invoke-WebRequest -UserAgent "Wget" -Uri "$RELEASES/$VERSION/$ZIPFILE" -OutFile "$ZIPFILE" -ErrorAction:Stop
    Write-Host "Downloaded $ZIPFILE ..."
    
} else {
    Write-Host "You have $ZIPFILE in directory lib -- proceeding to rebuild XMLCalabash in ..\lib directory"
    # pausing to wait for a keystroke -
    [void]$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Unzip the file
Expand-Archive -Path "$ZIPFILE" -DestinationPath "." -Force
Rename-Item -Path "xmlcalabash-$VERSION" -NewName "XMLCalabash"
Write-Host "XML Calabash is available - next, try executing a pipeline ..."
# Remove-Item __MACOSX -Recurse

Write-Host "Hint: ./xc.sh smoketest/TEST-XPROC3.xpl (Linux/WSL) or xc.ps1 smoketest\TEST-XPROC3.xpl (Windows CMD)"
# Return to the previous location
Pop-Location
