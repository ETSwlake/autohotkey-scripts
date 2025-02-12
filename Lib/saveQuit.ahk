#Requires AutoHotkey v2.0

>^!s::{ ; Right Ctrl + Alt + S

; List of programs to manage
programs := ["acadlt.exe", "excel.exe", "winword.exe", "notepad++.exe"]

for program in programs
{
    ; Check if the program is running
    if (ProcessExist(program))
    {
        ; Initialize id variable
        id := []
        
        ; Loop through all windows of the program
        WinGet id, 'List', 'ahk_exe ' program
        if (id.Length > 0) ; Check if any windows were found
        {
            for windowId in id
            {
                WinActivate('ahk_id ' windowId)
                Sleep 500 ; Adjust as needed
                Send '^s' ; Save work (Ctrl + S)
                Sleep 500 ; Adjust as needed
                WinClose('ahk_id ' windowId)
            }
        }
    }
}
return
}

ProcessExist(name) {
    return !!DllCall("GetProcessIdByName", "Str", name, "UInt")
}