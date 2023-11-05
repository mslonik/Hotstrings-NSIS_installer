!include "FileFunc.nsh"				;for function GetTime and GetParameters
!include "LogicLib.nsh"				;The LogicLib provides some very simple macros that allow easy construction of complex logical structures. 
; !include "MUI2.nsh"				;for graphical installer

!define APP_NAME 		"Hotstrings"
!define APP_VERSION 	"1.0"
!define COMPANY_NAME 	"Damian Damaszke Dam IT"			;for VIAddVersionKey
!define COPYRIGHT 		"Maciej Slojewski & DamIT"		;for VIAddVersionKey
!define DESCRIPTION 	"Installer of Hotstrings application: advanced text replacement tool."	;for VIAddVersionKey
!define VERSION 		"3.6.19.0"													;for Registry input
!define WEB_SITE 		"https://hotstrings.technology"									;for Registry input

; Script Header
SetCompressor /SOLID Lzma					;LZMA is a new compression method that gives very good compression ratios. If /SOLID is used, all of the installer data is compressed in one block. This results in greater compression ratios.
BrandingText ""							;Sets the text that is shown at the bottom of the install window at the bottom of the install window. Setting this to an empty string ("") uses the default (by default it is 'Nullsoft Install System vX.XX'); 
Caption 	"${APP_NAME} application installation"	;Sets the text for the titlebar of the installer.
CRCCheck 	on								;Specifies whether or not the installer will perform a CRC on itself before allowing an install.
Name		"${APP_NAME}"						;Sets the name displayed in installer GUI.
Outfile 	"${APP_NAME}Installer.exe"			;Name of the .exe  installer file
RequestExecutionLevel 	user					; Install only for the current user
SilentInstall			normal				;if this is set to 'normal' and the user runs the installer with /S (case sensitive) on the command line, it will behave as if SilentInstall 'silent' was used.

;These can be viewed in the File Properties Version or Details tab.
VIProductVersion "${VERSION}"
VIAddVersionKey "ProductName"  	"${APP_NAME}"		;
VIAddVersionKey "CompanyName"  	"${COMPANY_NAME}"
VIAddVersionKey "LegalCopyright"  	"${COPYRIGHT}"
VIAddVersionKey "FileDescription"  "${DESCRIPTION}"
VIAddVersionKey "FileVersion"  	"${VERSION}"
VIAddVersionKey "ProductVersion"  	"${VERSION}"

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

; gui installer (future)
; !insertmacro MUI_PAGE_WELCOME
; !insertmacro MUI_PAGE_LICENSE "LICENSE_EULA.md"
; !insertmacro MUI_PAGE_DIRECTORY
; !insertmacro MUI_PAGE_INSTFILES
; !insertmacro MUI_UNPAGE_CONFIRM
; !insertmacro MUI_UNPAGE_INSTFILES
; !insertmacro MUI_LANGUAGE "English"

; Default section
Section
	SetShellVarContext current	;If set to 'current' (the default), the current user's shell folders are used. Note that, if used in installer code, this will only affect the installer, and if used in uninstaller code, this will only affect the uninstaller. To affect both, it needs to be used in both.
	StrCpy $INSTDIR "$LOCALAPPDATA\${APP_NAME}"	;for testing purposes only: StrCpy $INSTDIR "C:\Users\macie\Documents\temp2\"
	; LogSet on					;Sets whether install logging to $INSTDIR\install.log will happen. Not available in my version. Future.

	; Write uninstaller
	WriteUninstaller "$INSTDIR\${APP_NAME}Uninstaller.exe"
	; Log file creation
	FileOpen $0 "$INSTDIR\HotstringsInstaller.log" a		;"a" = append, meaning opened for both read and write
    	!insertmacro LogMessage "Hotstrings Installer Version: ${APP_VERSION}"
    	!insertmacro LogMessage "Installation started."
    	!insertmacro LogMessage "Files created during installation:"
	
	CreateDirectory "$INSTDIR"				; Create Libraries and Log folders
	SetOutPath "$INSTDIR" ; Set the installation directory to the user's LOCALAPPDATA
			; Copy files to the installation directory
		File "${APP_NAME}.exe"
		!insertmacro LogMessage "  - Created: $INSTDIR\${APP_NAME}.exe"
		File "Config.ini"
		!insertmacro LogMessage "  - Created: $INSTDIR\Config.ini"
		File "LICENSE_EULA.md"
		!insertmacro LogMessage "  - Created: $INSTDIR\LICENSE_EULA.md"
		File "${APP_NAME}Webpage.url" 
		!insertmacro LogMessage "  - Created: $INSTDIR\${APP_NAME}Webpage.url"
	CreateDirectory "$INSTDIR\Libraries"		; Create Libraries folder
	SetOutPath "$INSTDIR\Libraries" ; Set the installation directory to the user's LOCALAPPDATA
		; Copy files to the installation directory
		File ".\Libraries\*.csv"	;relative path, subfolder: "."	
	CreateDirectory "$INSTDIR\Log"		; Create Log folder
	SetOutPath "$INSTDIR\Log" ; Set the installation directory to the user's LOCALAPPDATA
			; Copy files to the installation directory	
	CreateDirectory "$INSTDIR\Languages"		; Create Languages folder
	SetOutPath "$INSTDIR\Languages" ; Set the installation directory to the user's LOCALAPPDATA
	    	; Copy files to the installation directory
	File ".\Languages\English.txt"	
	
	; Add uninstall information to the registry
	WriteRegStr 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
	WriteRegStr 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\${APP_NAME}Uninstaller.exe"
	WriteRegStr 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayVersion" "${VERSION}"
	WriteRegStr 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Publisher" "${COMPANY_NAME}"
	WriteRegStr 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "URLInfoAbout" "${WEB_SITE}"
	WriteRegDWORD 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoModify" 1
	WriteRegDWORD 	HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoRepair" 1	
	
	CreateDirectory "$SMPROGRAMS\${APP_NAME}"

	; Create a shortcut on the desktop. 0 comes from application "Icon Explorer". Comments for long commands in nsis are not allowed.
	CreateShortCut "$DESKTOP\${APP_NAME}.lnk" \
				"$INSTDIR\${APP_NAME}.exe" \
				0 \
				SW_SHOWNORMAL \
				"" \
				"Text replacement tool"	
	; Create a shortcut in Start Menu Programs. 0 comes from application "Icon Explorer". Comments for long commands in nsis are not allowed.
	CreateShortCut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" \	
				"$INSTDIR\${APP_NAME}.exe" \
				"" \
				"$INSTDIR\${APP_NAME}.exe" \
				0 \
				SW_SHOWNORMAL \
				"" \
				"Text replacement tool"	
	; Create a shortcut in Start Menu Programs. 0 comes from application "Icon Explorer". Comments for long commands in nsis are not allowed.
	CreateShortCut "$SMPROGRAMS\${APP_NAME}\${APP_NAME} webpage.lnk" \
				"$INSTDIR\${APP_NAME}Webpage.url" \
				"" \
				"$INSTDIR\${APP_NAME}.exe" \
				0 \
				SW_SHOWNORMAL \
				"" \
				"${APP_NAME} webpage"
	
	FileClose $0				;Close log file
SectionEnd

; Uninstaller section
Section "Uninstall"
	SetShellVarContext current	;If set to 'current' (the default), the current user's shell folders are used. Note that, if used in installer code, this will only affect the installer, and if used in uninstaller code, this will only affect the uninstaller. To affect both, it needs to be used in both.
	SetOutPath "$LOCALAPPDATA"	;This trick enables deletion of all the files from installation folder.
	RMDir /r	"$INSTDIR"		;remove directory along with its contents

    ; Remove uninstall information from the registry
    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

    ; Remove shortcuts
    Delete 	"$DESKTOP\${APP_NAME}.lnk"
    Delete 	"$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk"
    Delete	"$SMPROGRAMS\${APP_NAME}\${APP_NAME}Webpage.lnk"
    RMDir		"$SMPROGRAMS\${APP_NAME}"
SectionEnd