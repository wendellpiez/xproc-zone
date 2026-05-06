# To run this script you need to open up permissions in your Powershell session.

# To see the current (script) execution policy:
# Get-ExecutionPolicy -List

# To set permissions for the local machine to run Powershell scripts:
# Set-ExecutionPolicy -ExecutionPolicy Unrestricted

# WARNING: Xproc scripts can and do write files into your system
# Do not run any XProc unless you know what it is doing and have taken appropriate precautions

# Diagnostic one-liner for Saxon
# java -cp c:\saxon\saxon-he-10.0.jar net.sf.saxon.Query -t -qs:"current-date()"

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# XML Calabash version
$XML_CALABASH_VERSION = "3.0.45"

# XML Calabash file paths
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# The main jar file finds the others
# According to https://docs.xmlcalabash.com/userguide/current/running.html

$XML_CALABASH_JAR = Join-Path $scriptPath "lib\xmlcalabash-$XML_CALABASH_VERSION\xmlcalabash-app-$XML_CALABASH_VERSION.jar"
$XML_CALABASH_CONFIG = Join-Path $scriptPath "lib\xml-calabash3-config.xml"

# To set the console encoding
$JavaProp = "-Dfile.encoding=COMPAT"

# Runtime notice
Write-Output "Invoking XML Calabash $XML_CALABASH_VERSION for XProc 3 pipeline execution..."

# Record the start time
$startTime = Get-Date
# Write-Output "Start time: $startTime"

# Invoke XML Calabash
& java $JavaProp -jar $XML_CALABASH_JAR -c:$XML_CALABASH_CONFIG $args

# Record the end time
$endTime = Get-Date
# Write-Output "End time: $endTime"

# Calculate the elapsed time
$elapsedTime = $endTime - $startTime
Write-Output "Elapsed time: $elapsedTime"

# Pause the script execution
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
