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

GetFileExtension(filePath) {
    if RegExMatch(filePath, "\.[^.]+$", &match)
        return LTrim(match[0], ".")
    return ""
}

IsImageFile(ext) {
    return (ext ~= "i)^(jpg|jpeg|png|gif|bmp|tiff|webp|svg)$")
}

ProcessFiles(filePaths, methodFile) {
    tempFile := A_Temp "\selected_files_" . A_TickCount . ".txt"

    for filePath in filePaths {
        if (SubStr(filePath, 2, 1) = ":") {
            driveLetterPath := SubStr(filePath, 1, 2)
            networkPath := DriveGetNetworkRoot(driveLetterPath)
            if networkPath {
                filePath := StrReplace(filePath, driveLetterPath, networkPath)
            }
        }
        FileAppend(filePath "`n", tempFile)
    }

    arencPath := A_ProgramFiles '\Advanced Renamer\arenc.exe'
    Run(Format('"{1}" -e "{2}" -i "{3}" -t files -l "{4}\aren.log"', arencPath, methodFile, tempFile, EnvGet("LOCALAPPDATA")))
}

; Add window context for the hotkey
#HotIf WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass")
^!r:: { ; Ctrl + Alt + R
    try {
        if (selected := GetExplorerSelection()) {
            pdfFiles := []
            imageFiles := []

            for item in selected {
                path := item.Path
                ext := GetFileExtension(path)

                if (ext ~= "i)^pdf$") {
                    pdfFiles.Push(path)
                } else if IsImageFile(ext) {
                    imageFiles.Push(path)
                }
            }

            ; Check if we have any valid files
            if (pdfFiles.Length = 0 and imageFiles.Length = 0) {
                ToolTip("Selected files must be PDFs or images")
                SetTimer () => ToolTip(), -3000
                return
            }

            ; Process PDFs
            if (pdfFiles.Length > 0) {
                methodFile := A_scriptDir '\Lib\signed.aren'
                ProcessFiles(pdfFiles, methodFile)
            }

            ; Process images
            if (imageFiles.Length > 0) {
                methodFile := A_scriptDir '\Lib\photo.aren'
                ProcessFiles(imageFiles, methodFile)
            }
        } else {
            ToolTip("No files selected")
            SetTimer () => ToolTip(), -3000
        }
    } catch Error as err {
        ToolTip("Error: " err.Message)
        SetTimer () => ToolTip(), -3000
    }
}
#HotIf  ; Clear the context
return
