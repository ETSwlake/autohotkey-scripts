#Requires AutoHotkey v2.0

GetExplorerSelection(hwnd := WinExist("A")) {
    activeTab := 0
    try activeTab := ControlGetHwnd("ShellTabWindowClass1", hwnd)
    for window in ComObject("Shell.Application").Windows {
        if (window.hwnd != hwnd)
            continue
        if activeTab {
            static IID_IShellBrowser := "{000214E2-0000-0000-C000-000000000046}"
            shellBrowser := ComObjQuery(window, IID_IShellBrowser, IID_IShellBrowser)
            ComCall(3, shellBrowser, "uint*", &thisTab:=0)
            if (thisTab != activeTab)
                continue
        }
        return window.Document.SelectedItems
    }
    return false
}

DriveGetNetworkRoot(driveLetter) {
    try {
        cmd := ComObject("WScript.Shell").Exec('cmd.exe /c net use ' driveLetter)
        output := cmd.StdOut.ReadAll()
        
        ; Extract UNC path from the output using RegExMatch
        if RegExMatch(output, "\\\\[^\s]+", &match)
            return match[0]
    }
    return ""
}

; Add window context for the hotkey
#HotIf WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass")
^!r:: { ; Ctrl + Alt + R
    tempFile := A_Temp "\selected_files.txt"
    if FileExist(tempFile) { 
        FileDelete(tempFile)
    } ; reset file list

    try {
        if (selected := GetExplorerSelection()) {
            for item in selected {
                path := item.Path
                if (SubStr(path, 2, 1) = ":") {
                    driveLetterPath := SubStr(path, 1, 2)
                    networkPath := DriveGetNetworkRoot(driveLetterPath)
                    if networkPath {
                        path := StrReplace(path, driveLetterPath, networkPath)
                    }
                } ; convert local drive to network path if applicable
                FileAppend(path "`n", tempFile)
            }
        } ; generate file list

        if !FileExist(tempFile) {
            ToolTip("No files selected or error accessing network path")
            SetTimer () => ToolTip(), -3000
            return
        }

        methodFile := A_scriptDir "\Lib\signed.aren"
        arencPath := Format('{1}\Advanced Renamer\arenc.exe', A_ProgramFiles)
        Run(Format('"{1}" -e "{2}" -i "{3}" -t files -l "{4}\aren.log"', arencPath, methodFile, tempFile, EnvGet("LOCALAPPDATA")))
    } catch Error as err {
        ToolTip("Error: " err.Message)
        SetTimer () => ToolTip(), -3000
    }
}
#HotIf  ; Clear the context
return
