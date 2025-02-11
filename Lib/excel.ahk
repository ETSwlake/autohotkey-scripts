#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_class XLMAIN")

; shift + scroll wheel to scroll left/right
+WheelDown::ComObjActive("Excel.Application").ActiveWindow.SmallScroll(0,0,3,0)
+WheelUp::ComObjActive("Excel.Application").ActiveWindow.SmallScroll(0,0,0,3)