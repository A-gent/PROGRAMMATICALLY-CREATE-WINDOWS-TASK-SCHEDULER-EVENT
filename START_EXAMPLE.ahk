#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

IniRead, bElevate, config.cfg, DEBUG, RunAsAdministrator, 1
GLOBAL ElevateUAC := bElevate

                            If(ElevateUAC="1")
                            {
;                         {[
;;           ELEVATE TO ADMIN UAC PROMPT BELOW
; If the script is not elevated, relaunch as administrator and kill current instance:
 
full_command_line := DllCall("GetCommandLine", "str")
 
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}
;
;                          ]}
                            }



FormatTime, TimeString, T12, Time
FormatTime, DateString,, ShortDate




;;; DEFINE TASK INFORMATION
IniRead, bTaskName, config.cfg, CONFIG, TaskName, Z_TEST_ADD_1
GLOBAL TaskName := bTaskName
IniRead, bTaskDir, config.cfg, CONFIG, TargetDirectory, D:\#Manifest\#DigitalSea\AutoHotkey\_____PROJECTS______\TOOLS\PROGRAMMATICALLY_CREATE_WINDOWS_TASK_SCHEDULER_EVENT
GLOBAL TargetDir := bTaskDir
IniRead, bTargetName, config.cfg, CONFIG, TargetName, test_msgbox.exe
GLOBAL TargetName := bTargetName



;;; COMBINE TARGET DIRECTORY AND NAME
GLOBAL Target := TargetDir . "\" . TargetName
;;; USE CURRENT USER
GLOBAL UserName := A_ComputerName . "\" . A_UserName



IniRead, bCreateAdminTask, config.cfg, SWITCHES, CreateElevatedAdminTask, 1
GLOBAL CreateAdministratorTask := bCreateAdminTask
IniRead, bCreateShortcutFile, config.cfg, SWITCHES, CreateShortcutFile, 1
GLOBAL CreateShortcutFile := bCreateShortcutFile
IniRead, bCreateTask, config.cfg, SWITCHES, CreateTaskSwitch, 1
GLOBAL CreateTask := bCreateTask

IniRead, bDebug_TimeAndDateMSG, config.cfg, DEBUG, Debug_TimeAndDateMSG, 1
GLOBAL Debug_TimeAndDateMSG := bDebug_TimeAndDateMSG
IniRead, bDebug_CreateTaskMSG, config.cfg, DEBUG, Debug_CreateTaskMSG, 1
GLOBAL Debug_CreateTaskMSG := bDebug_CreateTaskMSG
IniRead, bDebug_CreateTaskMSGInfo, config.cfg, DEBUG, Debug_CreateTaskMSGInfo, 1
GLOBAL Debug_CreateTaskMSGInfo := bDebug_CreateTaskMSGInfo




If(CreateTask="1")
{
  If(Debug_CreateTaskMSG="1")
  {
    MsgBox,, [DEBUG]: TASK CREATOR, %Debug_CreateTaskMSGInfo%, 15
  }
    If(CreateAdministratorTask="1")
    {
        Run, schtasks.exe /create /tn "%TaskName%" /tr "%Target%" /sc once /sd 01/01/1901 /st 00:00 /RU "%UserName%" /RL HIGHEST
    }
        If(CreateAdministratorTask="0")
        {
            Run, schtasks.exe /create /tn "%TaskName%" /tr "%Target%" /sc once /sd 01/01/1901 /st 00:00 /RU "%UserName%" /RL LIMITED
        }
}


If(Debug_TimeAndDateMSG="1")
{
    MsgBox,, [DEBUG]: Time and Date, %TimeString% `n %DateString%., 15
}


If(CreateShortcutFile="1")
{
FileCreateShortcut, schtasks.exe, %A_ScriptDir%\RUN_%TASKNAME%.lnk, C:\Windows\System32, /run /tn "%TaskName%", taskname Description,,,
}














































;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMMENTED REFERENCES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; ThisDir = "C:\Windows\System32"

; GLOBAL UserName := "OBELISKOFLIGHT\Jake"




; Run, schtasks.exe /create /tn "DIRECTOR_ProcessLassoNag2" /tr "%ThisDir%\HandleProcessLassoNag.exe" /sc once /sd 01/01/1901 /st 00:00 /RU AGENT\Agent /RL HIGHEST
; Run, schtasks.exe /create /tn "Z_TEST_ADD" /tr "%ThisDir%\calc.exe" /sc once /sd 01/01/1901 /st 00:00 /RU OBELISKOFLIGHT\Administrators /RL HIGHEST
; Run, schtasks.exe /create /tn "Z_TEST_ADD" /tr "%ThisDir%\this_just_runs_asAdmin_thenExits.exe" /sc once /sd 01/01/1901 /st 00:00 /RU "System" /RL HIGHEST


; Run, schtasks.exe /create /tn "Z_TEST_ADD" /tr "%ThisDir%\this_just_runs_asAdmin_thenExits.exe" /sc once /sd 01/01/2024 /st 00:00 /RU "System" /RL HIGHEST

;;;; https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/schtasks-create

; Run, schtasks.exe /create /tn "Z_TEST_ADD" /tr "%ThisDir%\this_just_runs_asAdmin_thenExits.exe" /sc monthly /mo lastday /m * /RU "System" /RL HIGHEST

; sLEEP, 1500

; Run, %A_ScriptDir%\RUN_TEST_SHORTCUT.lnk
; MsgBox, , Title, %A_ComputerName%\%A_UserName%