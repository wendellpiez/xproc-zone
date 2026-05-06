@echo off

echo Invoking XML Calabash 3 for XProc 3 pipeline execution . . .
rem All arguments are passed to the script in the distribution.

rem NB - may need to update path and Saxon setting to your installed versions
rem TODO: port fallback logic / --help and other features from xproc3.sh


set VERSION=3.0.45

call java -Dfile.encoding=COMPAT -jar %~P0\lib\xmlcalabash-%VERSION%\xmlcalabash-app-%VERSION%.jar -c:%~P0\lib\xml-calabash3-config.xml %*

