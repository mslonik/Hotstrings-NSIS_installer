!include "FileFunc.nsh"
!include "LogicLib.nsh"

; Script Header
Outfile "HotstringsInstaller.exe"
RequestExecutionLevel user ; Install only for the current user

!define APP_NAME "Hotstrings"
!define SILENT_PARAMETER "/s"

; Silent installation section
Function SilentInstall
    
    CreateDirectory "$INSTDIR"				; Create Libraries and Log folders
    ; Copy files to the installation directory
		File "Hotstrings.exe"
		File "Config.ini"
		File "LICENSE_EULA.md"

	CreateDirectory "$INSTDIR\Libraries"		; Create Libraries folder
	; Copy files to the installation directory
		File ".\Libraries\AbbreviationsEnglish.csv"	;relative path, subfolder: "."
		File ".\Libraries\AcademicDegrees.csv"
		File ".\Libraries\AutocompleteBrackets.csv"
		File ".\Libraries\BoxDrawing.csv"
		File ".\Libraries\BrandAndProperNames.csv"
		File ".\Libraries\CapitalLetters.csv"
		File ".\Libraries\CircledNumbers.csv"
		File ".\Libraries\ComputerKeysSymbols.csv"
		File ".\Libraries\CurrencySymbols.csv"
		File ".\Libraries\DiacriticsHotstrings.csv"
		File ".\Libraries\EmojiHotstrings.csv"
		File ".\Libraries\EnglishInternetSlang.csv"
		File ".\Libraries\Examples_TestLib.csv"
		File ".\Libraries\Fileformats.csv"
		File ".\Libraries\Finance.csv"
		File ".\Libraries\FirstNameCapitalizer.csv"
		File ".\Libraries\Forms&Frameworks.csv"
		File ".\Libraries\GreekAlphabet.csv"
		File ".\Libraries\HotstringsHotstrings.csv"
		File ".\Libraries\Incoterms.csv"
		File ".\Libraries\KeyboardKeys.csv"
		File ".\Libraries\Markdown.csv"
		File ".\Libraries\PersonalHotstringsTemplate.csv"
		File ".\Libraries\PhysicsHotstrings.csv"
		File ".\Libraries\Punctuation.csv"
		File ".\Libraries\TechnicalHotstrings.csv"
		File ".\Libraries\TimeHotstrings.csv"
		File ".\Libraries\WindowsShortcuts.csv"

	CreateDirectory "$INSTDIR\Log"		; Create Log folder
    ; Copy files to the installation directory

    CreateDirectory "$INSTDIR\Languages"		; Create Languages folder
        ; Copy files to the installation directory
    File ".\Languages\English.txt"

    ; Add uninstall information to the registry
    WriteRegStr 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
    WriteRegStr 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\uninstaller.exe"
    WriteRegDWORD 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoModify" 1
    WriteRegDWORD 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoRepair" 1

    ; Create a shortcut on the desktop
    CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$APPDATA\${APP_NAME}\${APP_NAME}.exe"
FunctionEnd

; Default section
Section
	StrCpy $INSTDIR "$APPDATA\${APP_NAME}"
	SetOutPath "$INSTDIR" ; Set the installation directory to the user's Roaming AppData

	; Write uninstaller
	WriteUninstaller "$INSTDIR\uninstaller.exe"

	Call SilentInstall
SectionEnd

; Uninstaller section
Section "Uninstall"
    ; Remove files and directories
	Delete 	"$INSTDIR\AbbreviationsEnglish.csv"	;relative path, subfolder: "."
	Delete 	"$INSTDIR\AcademicDegrees.csv"
	Delete 	"$INSTDIR\AutocompleteBrackets.csv"
	Delete 	"$INSTDIR\BoxDrawing.csv"
	Delete 	"$INSTDIR\BrandAndProperNames.csv"
	Delete 	"$INSTDIR\CapitalLetters.csv"
	Delete 	"$INSTDIR\CircledNumbers.csv"
	Delete 	"$INSTDIR\ComputerKeysSymbols.csv"
	Delete 	"$INSTDIR\CurrencySymbols.csv"
	Delete 	"$INSTDIR\DiacriticsHotstrings.csv"
	Delete 	"$INSTDIR\EmojiHotstrings.csv"
	Delete 	"$INSTDIR\EnglishInternetSlang.csv"
	Delete 	"$INSTDIR\Examples_TestLib.csv"
	Delete 	"$INSTDIR\Fileformats.csv"
	Delete 	"$INSTDIR\Finance.csv"
	Delete 	"$INSTDIR\FirstNameCapitalizer.csv"
	Delete 	"$INSTDIR\Forms&Frameworks.csv"
	Delete 	"$INSTDIR\GreekAlphabet.csv"
	Delete 	"$INSTDIR\HotstringsHotstrings.csv"
	Delete 	"$INSTDIR\Incoterms.csv"
	Delete 	"$INSTDIR\KeyboardKeys.csv"
	Delete 	"$INSTDIR\Markdown.csv"
	Delete 	"$INSTDIR\PersonalHotstringsTemplate.csv"
	Delete 	"$INSTDIR\PhysicsHotstrings.csv"
	Delete 	"$INSTDIR\Punctuation.csv"
	Delete 	"$INSTDIR\TechnicalHotstrings.csv"
	Delete 	"$INSTDIR\TimeHotstrings.csv"
	Delete 	"$INSTDIR\WindowsShortcuts.csv"

	Delete 	"$INSTDIR\Hotstrings.exe"
	Delete 	"$INSTDIR\Config.ini"
	Delete 	"$INSTDIR\LICENSE_EULA.md"
	Delete 	"$INSTDIR\Languages\English.txt"
	RMDir 	"$INSTDIR\Languages"
	RMDir 	"$INSTDIR\Libraries"
	RMDir 	"$INSTDIR"

    ; Remove uninstall information from the registry
    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

    ; Remove desktop shortcut
    Delete "$DESKTOP\${APP_NAME}.lnk"
SectionEnd

; Define the silent installation parameter
Function .onInit
    ClearErrors
    ${GetParameters} $0
    ${If} ${Errors}
        StrCpy $0 0
    ${EndIf}

    ${If} $0 == ${SILENT_PARAMETER}
        Call SilentInstall
        Quit ; Quit the installer after silent installation
    ${EndIf}
FunctionEnd
