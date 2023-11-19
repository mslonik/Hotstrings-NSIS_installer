; 
; 	Author:      	Maciej Słojewski (mslonik, http://mslonik.pl)
; 	Purpose:     	Simple NSIS installer of Hotstrings application.
; 	Description: 	---
; 	License:     	MIT License
;	Year:		2023
;
;	To do: 		- extended logging (in general),
;				- logging of registry entries,
;				- GUI installer,
;				- choice of AppData folder,
;				- choice of UserData folder,
;				- option to change AppData and UserData after installation
;
!include "FileFunc.nsh"				;for function GetTime and GetParameters
!include "LogicLib.nsh"				;The LogicLib provides some very simple macros that allow easy construction of complex logical structures. 
; !include "MUI2.nsh"				;for graphical installer


!define VERSION 		"3.6.19"		;for Registry input
!define MAJORVERSION	"3"
!define MINORVERSION	"6"
!define AUXILIARY		"Hotstrings"
!define COMMERCIAL	 				;or FREE
; !define	FREE						;or COMMERCIAL

!verbose push						;Passing push will cause !verbose to push the current verbosity level on a special stack.
!ifdef COMMERCIAL					;conditional compilation
	!define APPNAME 	"HotstringsPro"
	!verbose 4					;only level=4 will show result in Visual Studio Code
	!echo "COMMERCIAL installer of the application displayed under the name: ${APPNAME}$\nVersion: ${VERSION}$\n$\n"
!endif

!ifdef FREE						;conditional compilation
	!define APPNAME 	"Hotstrings"
	!verbose 4
	!echo "FREE installer of the application displayed under the name: ${APPNAME}$\nVersion: ${VERSION}$\n$\n"
!endif	
!verbose pop						;Passing push will cause !verbose to push the current verbosity level on a special stack.

!define ARP 			"Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
!define INST_VERSION 	"1.0.3"						;Version of this installer script
!define COMPANY_NAME 	"Damian Damaszke Dam IT"			;for VIAddVersionKey
!define COPYRIGHT 		"Damian Damaszke Dam IT"			;for VIAddVersionKey
!define DESCRIPTION 	"Installer of Hotstrings application: advanced text replacement tool."	;for VIAddVersionKey
!define WEB_SITE 		"https://hotstrings.technology"									;for Registry input

; Script Header
SetCompressor /SOLID Lzma					;LZMA is a new compression method that gives very good compression ratios. If /SOLID is used, all of the installer data is compressed in one block. This results in greater compression ratios.
BrandingText ""							;Sets the text that is shown at the bottom of the install window at the bottom of the install window. Setting this to an empty string ("") uses the default (by default it is 'Nullsoft Install System vX.XX'); 
Caption 	"${APPNAME} application installation"	;Sets the text for the titlebar of the installer.
CRCCheck 	on								;Specifies whether or not the installer will perform a CRC on itself before allowing an install.
Name		"${APPNAME}"						;Sets the name displayed in installer GUI.
Outfile 	"${APPNAME}Installer.exe"			;Name of the .exe  installer file
RequestExecutionLevel 	user					; Install only for the current user
SilentInstall			normal				;if this is set to 'normal' and the user runs the installer with /S (case sensitive) on the command line, it will behave as if SilentInstall 'silent' was used.

;These can be viewed in the File Properties Version or Details tab.
VIProductVersion "${VERSION}.0"
VIAddVersionKey "ProductName"  	"${APPNAME}"
; VIAddVersionKey "Comments"
VIAddVersionKey "CompanyName"  	"${COMPANY_NAME}"
VIAddVersionKey "LegalCopyright"  	"${COPYRIGHT}"
VIAddVersionKey "FileDescription"  "${DESCRIPTION}"
VIAddVersionKey "FileVersion"  	"${VERSION}"
VIAddVersionKey "ProductVersion"  	"${APPNAME}"
; VIAddVersionKey "InternalName"
; VIAddVersionKey "Legal Trademarks"
; VIAddVersionKey "OriginalFilename"
; VIAddVersionKey "PrivateBuild"
; VIAddVersionKey "SpecialBuild"

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
	StrCpy $INSTDIR "$LOCALAPPDATA\${APPNAME}"	;for testing purposes only: StrCpy $INSTDIR "C:\Users\macie\Documents\temp2\"
	; LogSet on					;Sets whether install logging to $INSTDIR\install.log will happen. Not available in my version. Future.

	; Log file creation
	FileOpen $0 "$INSTDIR\HotstringsInstaller.log" a		;"a" = append, meaning opened for both read and write
    	!insertmacro LogMessage "Hotstrings Installer Version: ${INST_VERSION}"
    	!insertmacro LogMessage "Installation started."
    	!insertmacro LogMessage "Files created during installation:"
	
	CreateDirectory "$INSTDIR"				; Create Libraries and Log folders
	SetOutPath "$INSTDIR" ; Set the installation directory to the user's LOCALAPPDATA and copy files to the installation directory
		File "${APPNAME}.exe"
		!insertmacro LogMessage "  - Created: $INSTDIR\${APPNAME}.exe"
		File "Config.ini"
		!insertmacro LogMessage "  - Created: $INSTDIR\Config.ini"
		!ifdef COMMERCIAL
		File "LICENSE_EULA.md"
		!insertmacro LogMessage "  - Created: $INSTDIR\LICENSE_EULA.md"
		!endif
		!ifdef FREE
		File LICENSE_MIT 
		!insertmacro LogMessage "  - Created: $INSTDIR\LICENSE_MIT"	
		!endif
		File "${AUXILIARY}Webpage.url" 
		!insertmacro LogMessage "  - Created: $INSTDIR\${AUXILIARY}Webpage.url"
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
	
	; Computing "EstimatedSize"
	${GetSize} "$INSTDIR" "/S=0K" $R0 $R1 $R2
 	IntFmt $R0 "0x%08X" $R0					;Formats the number in "numberstring" using the format "format", and sets the output to user variable $x.

	${GetTime} "" "L" $1 $2 $3 $4 $5 $6 $7
	; Add uninstall information to the Add/Remove Programs registry https://nsis.sourceforge.io/Add_uninstall_information_to_Add/Remove_Programs	
	WriteRegStr 	HKCU "${ARP}" "DisplayName" 			"${APPNAME}"
	WriteRegStr 	HKCU "${ARP}" "DisplayVersion" 		"${VERSION}"
	WriteRegDWORD 	HKCU "${ARP}" "EstimatedSize" 		"$R0"
	WriteRegStr 	HKCU "${ARP}" "InstallDate"			"$3$2$1"
	WriteRegStr 	HKCU "${ARP}" "InstallLocation" 		"$INSTDIR"
	WriteRegDWORD 	HKCU "${ARP}" "MajorVersion" 			"${MAJORVERSION}"
	WriteRegDWORD 	HKCU "${ARP}" "MinorVersion" 			"${MINORVERSION}"
	WriteRegDWORD 	HKCU "${ARP}" "NoModify" 			1
	WriteRegDWORD 	HKCU "${ARP}" "NoRepair" 			1	
	WriteRegStr 	HKCU "${ARP}" "Publisher" 			"${COMPANY_NAME}"
	WriteRegStr	HKCU "${ARP}" "QuietUninstallString" 	"$\"$INSTDIR\${APPNAME}Uninstaller.exe$\" /S"
	WriteRegStr 	HKCU "${ARP}" "UninstallString" 		"$\"$INSTDIR\${APPNAME}Uninstaller.exe$\""
	WriteRegStr 	HKCU "${ARP}" "URLInfoAbout" 			"${WEB_SITE}"
	WriteRegDWORD 	HKCU "${ARP}" "VersionMajor" 			"${MAJORVERSION}"
	WriteRegDWORD 	HKCU "${ARP}" "VersionMinor" 			"${MINORVERSION}"

	CreateDirectory "$SMPROGRAMS\${APPNAME}"

	; Create a shortcut on the desktop. 0 comes from application "Icon Explorer". Comments for long commands in nsis are not allowed.
	CreateShortCut "$DESKTOP\${APPNAME}.lnk" \
				"$INSTDIR\${APPNAME}.exe" \
				"" \
				"$INSTDIR\${APPNAME}.exe" \
				0 \
				SW_SHOWNORMAL \
				"" \
				"Text replacement tool"	
	; Create a shortcut in Start Menu Programs. 0 comes from application "Icon Explorer". Comments for long commands in nsis are not allowed.
	CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk" \	
				"$INSTDIR\${APPNAME}.exe" \
				"" \
				"$INSTDIR\${APPNAME}.exe" \
				0 \
				SW_SHOWNORMAL \
				"" \
				"Text replacement tool"	
	; Create a shortcut in Start Menu Programs. 0 comes from application "Icon Explorer". Comments for long commands in nsis are not allowed.
	CreateShortCut "$SMPROGRAMS\${APPNAME}\${APPNAME} webpage.lnk" \
				"$INSTDIR\${APPNAME}Webpage.url" \
				"" \
				"$INSTDIR\${APPNAME}.exe" \
				0 \
				SW_SHOWNORMAL \
				"" \
				"${APPNAME} webpage"
	
	FileClose $0				;Close log file
	; Write uninstaller
	WriteUninstaller "$INSTDIR\${APPNAME}Uninstaller.exe"		;This must be the last line in default section.
SectionEnd

; Uninstaller section
Section "Uninstall"
	ClearErrors				;idk
	SetShellVarContext current	;If set to 'current' (the default), the current user's shell folders are used. Note that, if used in installer code, this will only affect the installer, and if used in uninstaller code, this will only affect the uninstaller. To affect both, it needs to be used in both.
	SetOutPath "$LOCALAPPDATA"	;This trick enables deletion of all the files from installation folder.
	RMDir /r	"$INSTDIR"		;remove directory along with its contents

    ; Remove uninstall information from the registry
    DeleteRegKey HKCU "${ARP}"

    ; Remove shortcuts
    Delete 	"$DESKTOP\${APPNAME}.lnk"
    Delete 	"$SMPROGRAMS\${APPNAME}\${APPNAME}.lnk"
    Delete	"$SMPROGRAMS\${APPNAME}\${APPNAME}Webpage.lnk"
    RMDir		"$SMPROGRAMS\${APPNAME}"
SectionEnd