>^!s:: ; Right Ctrl + Alt + S

; List of programs to manage
programs := ["acadlt.exe", "excel.exe", "winword.exe", "notepad++.exe"

Loop, % programs.MaxIndex()
{
    program := programs[A_Index]

    ; Check if the program is running
    Process, Exist, %program%
    if (ErrorLevel)
    {
        ; Loop through all windows of the program
        WinGet, id, List, ahk_exe %program%
        Loop, %id%
        {
            WinActivate, ahk_id %id%A_Index%
            Sleep, 500 ; Adjust as needed
            Send, ^s ; Save work (Ctrl + S)
            Sleep, 500 ; Adjust as needed
            WinClose, ahk_id %id%A_Index%
        }
    }
}
return
