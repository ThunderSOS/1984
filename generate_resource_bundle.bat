echo off
setlocal ENABLEDELAYEDEXPANSION
set cp=.
for %%i in (lib\*.jar) do set cp=!cp!;%%i
java -classpath %cp% org.happysoft.games.ResourceBundleService
