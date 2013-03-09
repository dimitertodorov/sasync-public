@ECHO OFF
set PATH=%PATH%;%CD%\vendor\remedy-windows;c:\Users\WiebeDo\arapi.net
set REMEDY_71_API=%CD%\vendor\remedy-windows

FOR /R %CD%\vendor\remedy-windows %%a in (*.jar) DO CALL :AddToPath %%a
FOR /R %CD%\vendor\jars %%a in (*.jar) DO CALL :AddToPath %%a
ECHO %CLASSPATH%
GOTO :EOF

:AddToPath
SET CLASSPATH=%1;%CLASSPATH%
GOTO :EOF