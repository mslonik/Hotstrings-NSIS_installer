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
    SetOutPath "$INSTDIR" ; Set the installation directory to the user's Roaming AppData
    ; Copy files to the installation directory
		File "Hotstrings.exe"
		File "Config.ini"
		File "LICENSE_EULA.md"

	CreateDirectory "$INSTDIR\Libraries"		; Create Libraries folder
	SetOutPath "$INSTDIR\Libraries" ; Set the installation directory to the user's Roaming AppData
	; Copy files to the installation directory
		File ".\Libraries\*.csv"	;relative path, subfolder: "."

	CreateDirectory "$INSTDIR\Log"		; Create Log folder
	SetOutPath "$INSTDIR\Log" ; Set the installation directory to the user's Roaming AppData
    ; Copy files to the installation directory

    CreateDirectory "$INSTDIR\Languages"		; Create Languages folder
    SetOutPath "$INSTDIR\Languages" ; Set the installation directory to the user's Roaming AppData
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
	StrCpy $INSTDIR "C:\Users\macie\Documents\temp2\"
	; StrCpy $INSTDIR "$APPDATA\${APP_NAME}"

	; Write uninstaller
	WriteUninstaller "$INSTDIR\HotstringsUninstaller.exe"

	Call SilentInstall
SectionEnd

; Uninstaller section
Section "Uninstall"
    ; Remove files and directories
	Delete 	"$INSTDIR\Libraries\*"	;relative path, subfolder: "."
	Delete 	"$INSTDIR\Hotstrings.exe"
	Delete 	"$INSTDIR\Config.ini"
	Delete 	"$INSTDIR\LICENSE_EULA.md"
	Delete 	"$INSTDIR\Languages\English.txt"
	Delete	"$INSTDIR\Log\*"
	RMDir 	"$INSTDIR\Languages"
	RMDir 	"$INSTDIR\Libraries"
	RMDir 	"$INSTDIR\Log"
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
