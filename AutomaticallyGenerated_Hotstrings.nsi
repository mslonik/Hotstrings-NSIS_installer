############################################################################################
#      NSIS Installation Script created by NSIS Quick Setup Script Generator v1.09.18
#               Entirely Edited with NullSoft Scriptable Installation System                
#              by Vlasis K. Barkas aka Red Wine red_wine@freemail.gr Sep 2006               
############################################################################################

!define APP_NAME "Hotstrings"
!define COMP_NAME "Damian Damaszke DamIT"
!define WEB_SITE "https://hotstrings.technology"
!define VERSION "3.6.19.0"
!define COPYRIGHT "Maciej Slojewski & DamIT"
!define DESCRIPTION "Application"
!define LICENSE_TXT "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\LICENSE_EULA.txt"
!define INSTALLER_NAME "C:\Program Files (x86)\NSIS\Bin\Output\Hotstrings\setup.exe"
!define MAIN_APP_EXE "Hotstrings.exe"
!define INSTALL_TYPE "SetShellVarContext current"
!define REG_ROOT "HKCU"
!define REG_APP_PATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${MAIN_APP_EXE}"
!define UNINSTALL_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

######################################################################

VIProductVersion  "${VERSION}"
VIAddVersionKey "ProductName"  "${APP_NAME}"
VIAddVersionKey "CompanyName"  "${COMP_NAME}"
VIAddVersionKey "LegalCopyright"  "${COPYRIGHT}"
VIAddVersionKey "FileDescription"  "${DESCRIPTION}"
VIAddVersionKey "FileVersion"  "${VERSION}"

######################################################################

SetCompressor /SOLID Lzma
Name "${APP_NAME}"
Caption "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
BrandingText "${APP_NAME}"
XPStyle on
InstallDirRegKey "${REG_ROOT}" "${REG_APP_PATH}" ""
InstallDir "$PROGRAMFILES\Hotstrings"

######################################################################

!include "MUI.nsh"

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING

!insertmacro MUI_PAGE_WELCOME

!ifdef LICENSE_TXT
!insertmacro MUI_PAGE_LICENSE "${LICENSE_TXT}"
!endif

!ifdef REG_START_MENU
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "Hotstrings"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${REG_ROOT}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${UNINSTALL_PATH}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${REG_START_MENU}"
!insertmacro MUI_PAGE_STARTMENU Application $SM_Folder
!endif

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN "$INSTDIR\${MAIN_APP_EXE}"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM

!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

######################################################################

Section -MainProgram
${INSTALL_TYPE}
SetOverwrite ifnewer
SetOutPath "$INSTDIR"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Config.ini"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Hotstrings.exe"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\LICENSE_EULA.md"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\LICENSE_EULA.txt"
SetOutPath "$INSTDIR\Libraries"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\AbbreviationsEnglish.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\AcademicDegrees.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\AutocompleteBrackets.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\BoxDrawing.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\BrandAndProperNames.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\CapitalLetters.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\CircledNumbers.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\ComputerKeysSymbols.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\CurrencySymbols.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\DiacriticsHotstrings.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\EmojiHotstrings.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\EnglishInternetSlang.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\Examples_TestLib.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\Fileformats.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\Finance.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\FirstNameCapitalizer.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\Forms&Frameworks.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\GreekAlphabet.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\HotstringsHotstrings.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\Incoterms.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\KeyboardKeys.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\Markdown.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\PersonalHotstringsTemplate.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\PhysicsHotstrings.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\Punctuation.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\TechnicalHotstrings.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\TimeHotstrings.csv"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Libraries\WindowsShortcuts.csv"
SetOutPath "$INSTDIR\Languages"
File "C:\Users\macie\Documents\GitHub\Hotstrings-NSIS_installer\Languages\English.txt"
SectionEnd

######################################################################

Section -Icons_Reg
SetOutPath "$INSTDIR"
WriteUninstaller "$INSTDIR\uninstall.exe"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
CreateDirectory "$SMPROGRAMS\$SM_Folder"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!insertmacro MUI_STARTMENU_WRITE_END
!endif

!ifndef REG_START_MENU
CreateDirectory "$SMPROGRAMS\Hotstrings"
CreateShortCut "$SMPROGRAMS\Hotstrings\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\Hotstrings\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!endif

WriteRegStr ${REG_ROOT} "${REG_APP_PATH}" "" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayName" "${APP_NAME}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "UninstallString" "$INSTDIR\uninstall.exe"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayIcon" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayVersion" "${VERSION}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "Publisher" "${COMP_NAME}"

!ifdef WEB_SITE
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "URLInfoAbout" "${WEB_SITE}"
!endif
SectionEnd

######################################################################

Section Uninstall
${INSTALL_TYPE}
Delete "$INSTDIR\Config.ini"
Delete "$INSTDIR\Hotstrings.exe"
Delete "$INSTDIR\LICENSE_EULA.md"
Delete "$INSTDIR\LICENSE_EULA.txt"
Delete "$INSTDIR\Libraries\AbbreviationsEnglish.csv"
Delete "$INSTDIR\Libraries\AcademicDegrees.csv"
Delete "$INSTDIR\Libraries\AutocompleteBrackets.csv"
Delete "$INSTDIR\Libraries\BoxDrawing.csv"
Delete "$INSTDIR\Libraries\BrandAndProperNames.csv"
Delete "$INSTDIR\Libraries\CapitalLetters.csv"
Delete "$INSTDIR\Libraries\CircledNumbers.csv"
Delete "$INSTDIR\Libraries\ComputerKeysSymbols.csv"
Delete "$INSTDIR\Libraries\CurrencySymbols.csv"
Delete "$INSTDIR\Libraries\DiacriticsHotstrings.csv"
Delete "$INSTDIR\Libraries\EmojiHotstrings.csv"
Delete "$INSTDIR\Libraries\EnglishInternetSlang.csv"
Delete "$INSTDIR\Libraries\Examples_TestLib.csv"
Delete "$INSTDIR\Libraries\Fileformats.csv"
Delete "$INSTDIR\Libraries\Finance.csv"
Delete "$INSTDIR\Libraries\FirstNameCapitalizer.csv"
Delete "$INSTDIR\Libraries\Forms&Frameworks.csv"
Delete "$INSTDIR\Libraries\GreekAlphabet.csv"
Delete "$INSTDIR\Libraries\HotstringsHotstrings.csv"
Delete "$INSTDIR\Libraries\Incoterms.csv"
Delete "$INSTDIR\Libraries\KeyboardKeys.csv"
Delete "$INSTDIR\Libraries\Markdown.csv"
Delete "$INSTDIR\Libraries\PersonalHotstringsTemplate.csv"
Delete "$INSTDIR\Libraries\PhysicsHotstrings.csv"
Delete "$INSTDIR\Libraries\Punctuation.csv"
Delete "$INSTDIR\Libraries\TechnicalHotstrings.csv"
Delete "$INSTDIR\Libraries\TimeHotstrings.csv"
Delete "$INSTDIR\Libraries\WindowsShortcuts.csv"
Delete "$INSTDIR\Languages\English.txt"
 
RmDir "$INSTDIR\Languages"
RmDir "$INSTDIR\Libraries"
 
Delete "$INSTDIR\uninstall.exe"
!ifdef WEB_SITE
Delete "$INSTDIR\${APP_NAME} website.url"
!endif

RmDir "$INSTDIR"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_GETFOLDER "Application" $SM_Folder
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk"
!endif
Delete "$DESKTOP\${APP_NAME}.lnk"

RmDir "$SMPROGRAMS\$SM_Folder"
!endif

!ifndef REG_START_MENU
Delete "$SMPROGRAMS\Hotstrings\${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\Hotstrings\${APP_NAME} Website.lnk"
!endif
Delete "$DESKTOP\${APP_NAME}.lnk"

RmDir "$SMPROGRAMS\Hotstrings"
!endif

DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}"
DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}"
SectionEnd

######################################################################

