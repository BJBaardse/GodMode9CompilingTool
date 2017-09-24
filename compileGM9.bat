@echo off
echo GM9 Compiling Tool by @justaMew and @retrobug 
CHOICE /C "GS" /N /M "[G]odmode or [S]afemode? "
IF %ERRORLEVEL% == 1 GOTO GODMODE
IF %ERRORLEVEL% == 2 GOTO SAFEMODE

:GODMODE
echo Compiling GodMode9
@echo on
make
@echo off
for /f %%i in ('filename.exe G') do set VAR=%%i
mkdir %VAR%
xcopy ".\output\GodMode9.firm" ".\%VAR%\"
xcopy ".\output\GodMode9_ntr.firm" ".\%VAR%\ntrboot\"
xcopy ".\output\GodMode9_ntr.firm.sha" ".\%VAR%\ntrboot\"
xcopy ".\output\GodMode9_ntr_dev.firm" ".\%VAR%\ntrboot\"
xcopy ".\output\GodMode9_ntr_dev.firm.sha" ".\%VAR%\ntrboot\"
xcopy "HelloScript.gm9" ".\%VAR%\"
xcopy "README.md" ".\%VAR%\"
mkdir %VAR%\gm9
xcopy ".\resources\gm9\*.*" ".\%VAR%\gm9\" /e
echo Compiled GodMode9

GOTO MAKEZIP

:SAFEMODE
echo Compiling SafeMode9
@echo on
make SAFEMODE=1
@echo off
for /f %%i in ('filename.exe S') do set VAR=%%i
mkdir %VAR%
xcopy ".\output\SafeMode9.firm" ".\%VAR%\"
xcopy ".\output\SafeMode9_ntr.firm" ".\%VAR%\ntrboot\"
xcopy ".\output\SafeMode9_ntr.firm.sha" ".\%VAR%\ntrboot\"
xcopy ".\output\SafeMode9_ntr_dev.firm" ".\%VAR%\ntrboot\"
xcopy ".\output\SafeMode9_ntr_dev.firm.sha" ".\%VAR%\ntrboot\"
xcopy "HelloScript.gm9" ".\%VAR%\"
xcopy "README.md" ".\%VAR%\"
mkdir %VAR%\gm9
xcopy ".\resources\gm9\*.*" ".\%VAR%\gm9\" /e
echo Compiled SafeMode9! Now Zipping it!

GOTO MAKEZIP

:MAKEZIP
.\7-Zip\7z a -tZip %VAR%.zip .\%VAR%\*

rmdir  ".\%VAR%\" /S /Q

echo Zipping was succesful!

CHOICE /C YN /N /M "Delete Sourcecode (YN)? "
IF %ERRORLEVEL% == 1 GOTO DELSRC
IF %ERRORLEVEL% == 2 GOTO KEEPSRC

:DELSRC
echo Deleting Sourcecode
rmdir ".\build\" /S /Q
rmdir ".\common\" /S /Q
rmdir ".\data\" /S /Q
rmdir ".\output\" /S /Q
rmdir ".\resources\" /S /Q
rmdir ".\screeninit\" /S /Q
rmdir ".\source\" /S /Q
del ".gitignore"
del ".travis.yml"
del "HelloScript.gm9"
del "license.txt"
del "link.ld"
del "Makefile"
del "README.md"
echo Sourcecode has been deleted

GOTO DELTOOL

:KEEPSRC
echo Sourcecode has not been deleted
goto TOOLSELECT

:TOOLSELECT
CHOICE /C YN /N /M "Delete this tool (YN)? "
IF %ERRORLEVEL% == 1 GOTO DELTOOL
IF %ERRORLEVEL% == 2 GOTO KEEPTOOL

:DELTOOL
echo Deleting Tool
rmdir ".\7-Zip\" /S /Q
del "filename.exe"
echo Tool has been deleted
GOTO ENDTOOLDEL
:KEEPTOOL
echo Tool has not been deleted
GOTO END

:END
echo Done!

:ENDTOOLDEL
del "compileGM9.bat"
echo Done!