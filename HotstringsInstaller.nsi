; Script Header
Outfile "HotstringsInstaller.exe"
RequestExecutionLevel user ; Install only for the current user

!define APP_NAME "Hotstrings"
!define SILENT_PARAMETER "/s"

; Default section
Section
    SetOutPath $INSTDIR ; Set the installation directory

    ; Copy files to the installation directory
    File "Hotstrings.exe"
    File "Config.ini"

    ; Create directory in AppData
    SetShellVarContext current
    CreateDirectory "$APPDATA\${APP_NAME}"

    ; Add uninstall information to the registry
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\uninstaller.exe"
    WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoModify" 1
    WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoRepair" 1

    ; Create a shortcut on the desktop
    CreateShortCut "$DESKTOP\Hotstrings.lnk" "$INSTDIR\Hotstrings.exe"

    ; Copy English.txt to Languages folder
    SetOutPath "$APPDATA\${APP_NAME}\Languages"
    File "Languages\English.txt"
SectionEnd

; Uninstaller section
Section "Uninstall"
    ; Remove files and directory
    Delete "$INSTDIR\Hotstrings.exe"
    Delete "$INSTDIR\Config.ini"
    Delete "$INSTDIR\Languages\English.txt"
    RMDir "$INSTDIR\Languages"
    RMDir "$INSTDIR"

    ; Remove Languages folder in AppData
    SetShellVarContext current
    RMDir /r "$APPDATA\${APP_NAME}\Languages"

    ; Remove uninstall information from the registry
    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

    ; Remove desktop shortcut
    Delete "$DESKTOP\Hotstrings.lnk"
SectionEnd

; Silent installation section
Section "SilentInstall" SEC_SILENT
    SetOutPath $INSTDIR ; Set the installation directory

    ; Copy files to the installation directory
    File "Hotstrings.exe"
    File "Config.ini"

    ; Create directory in AppData
    SetShellVarContext current
    CreateDirectory "$APPDATA\${APP_NAME}"

    ; Add uninstall information to the registry
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\uninstaller.exe"
    WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoModify" 1
    WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "NoRepair" 1

    ; Create a shortcut on the desktop
    CreateShortCut "$DESKTOP\Hotstrings.lnk" "$INSTDIR\Hotstrings.exe"

    ; Copy English.txt to Languages folder
    SetOutPath "$APPDATA\${APP_NAME}\Languages"
    File "Languages\English.txt"
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
