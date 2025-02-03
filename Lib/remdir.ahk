#Requires AutoHotkey v2.0

^!+F10::
{
    if hwnd := WinExist("A") {
        for window in ComObject("Shell.Application").Windows {
            try {
                if (window.HWND = hwnd) {
                    currentDir := window.Document.Folder.Self.Path
                    Run "cmd /c `"" A_ScriptDir "\..\scripts\remdir.bat`"", currentDir
                    break
                }
            }
        }
    }
    return
}