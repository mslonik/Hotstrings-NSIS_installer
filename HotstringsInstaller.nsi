!include "FileFunc.nsh"				;for function GetTime
!include "LogicLib.nsh"
!include "MUI2.nsh"					;for graphical installer

; Script Header
Outfile "HotstringsInstaller.exe"		;Name of the installer file
RequestExecutionLevel user 			; Install only for the current user

!define APP_NAME "Hotstrings"
!define APP_VERSION "1.0"
!define SILENT_PARAMETER "/s"

!macro LogMessage Message
    ${GetTime} "" "L" $1 $2 $3 $4 $5 $6 $7
	; $1="01"      day
	; $2="04"      month
	; $3="2005"    year
	; $4="Friday"  day of week name
	; $5="16"      hour
	; $6="05"      minute
	; $7="50"      seconds
    FileWrite $0 "$3-$2-$1 $5:$6:$7 "
    FileWrite $0 "${Message}$\r$\n"
!macroend

; gui installer
; !insertmacro MUI_PAGE_WELCOME
; !insertmacro MUI_PAGE_LICENSE "LICENSE_EULA.md"
; !insertmacro MUI_PAGE_DIRECTORY
; !insertmacro MUI_PAGE_INSTFILES
; !insertmacro MUI_UNPAGE_CONFIRM
; !insertmacro MUI_UNPAGE_INSTFILES
; !insertmacro MUI_LANGUAGE "English"

; Silent installation section
Function SilentInstall
    
    CreateDirectory "$INSTDIR"				; Create Libraries and Log folders
    SetOutPath "$INSTDIR" ; Set the installation directory to the user's Roaming AppData
    ; Copy files to the installation directory
		File "Hotstrings.exe"
		!insertmacro LogMessage "  - Created: $INSTDIR\Hotstrings.exe"
		File "Config.ini"
		!insertmacro LogMessage "  - Created: $INSTDIR\Config.ini"
		File "LICENSE_EULA.md"
		!insertmacro LogMessage "  - Created: $INSTDIR\LICENSE_EULA.md"

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
	SetShellVarContext current	;If set to 'current' (the default), the current user's shell folders are used. Note that, if used in installer code, this will only affect the installer, and if used in uninstaller code, this will only affect the uninstaller. To affect both, it needs to be used in both.
	StrCpy $INSTDIR "C:\Users\macie\Documents\temp2\"
	; StrCpy $INSTDIR "$LOCALAPPDATA\${APP_NAME}"


	; Write uninstaller
	WriteUninstaller "$INSTDIR\HotstringsUninstaller.exe"
	; Log file creation
	FileOpen $0 "$INSTDIR\HotstringsInstaller.log" a		;"a" = append, meaning opened for both read and write
    	!insertmacro LogMessage "Hotstrings Installer Version: ${APP_VERSION}"
    	!insertmacro LogMessage "Installation started."
    	!insertmacro LogMessage "Files created during installation:"
	
	Call SilentInstall
	FileClose $0
SectionEnd

; Uninstaller section
Section "Uninstall"
	SetShellVarContext current	;If set to 'current' (the default), the current user's shell folders are used. Note that, if used in installer code, this will only affect the installer, and if used in uninstaller code, this will only affect the uninstaller. To affect both, it needs to be used in both.
	SetOutPath "$APPDATA"		;This trick enables deletion of all the files from installation folder.
	RMDir /r	"$INSTDIR"		;remove directory along with its contents

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
