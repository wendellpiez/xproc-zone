@echo off

echo Invoking XML Calabash 3 for XProc 3 pipeline execution . . .
rem All arguments are passed to the script in the distribution.

set VERSION=3.0.45

call java -Dfile.encoding=COMPAT -jar %~P0\lib\xmlcalabash-%VERSION%\xmlcalabash-app-%VERSION%.jar -c:%~P0\lib\xml-calabash3-config.xml %*

