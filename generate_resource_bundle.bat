@echo off
setlocal ENABLEDELAYEDEXPANSION

set cp=.

for %%i in (lib\*.jar) do set cp=!cp!;%%i
java -classpath %cp% org.happysoft.games.ResourceBundleService %1 %2

rem if not exist "%1\" echo Can't find directory "%1"	
rem if not "%2" == "" echo Up Here

for /f "tokens=1,* delims== " %%i in (build.properties) do (
    if "%%i" == "release.dir" (		
		if not "%2" == "" (
			if exist "%1\" (
				echo Copying resources to %%j\%1
				if not exist %%j\%1 mkdir %%j\%1
				del "%%j\%1\*.xml"		
				copy "%1" %%j\"%1"\*.xml		
				copy "%1"\*.properties %%j
				copy "%1"\*.properties .
			)			
			if not exist "%1\" echo I can't find directory '%1' so no resources will be copied to the release directory. 	
		)
		
		if exist "%2" (
			echo Copying '%2' to the release directory. 
			copy .\%2 %%j			
		)
		
		if not "%1" == "" (
			if exist "%1" ( 
				if not exist %1\ (
					echo Copying '%1' to the release directory. 
					copy .\%1 %%j
				)
			)
		)
		
		if "%1" == "" (
			echo Copying default files to the release directory. 
			copy .\gamedata.dat %%j
			copy dev\*.properties .
		)
    )
)
