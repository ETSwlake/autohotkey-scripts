#Requires AutoHotkey v2.0

#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
#Requires AutoHotkey >=2.0
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetKeyDelay 40 ; not actually used except when using SendRaw/Event
SetMouseDelay 40
SetTitleMatchMode "RegEx"

#Include Hotstrings.ahk ; Replaces what you type with something else.

; ~~~~~ NEWB CUTOFF ~~~~~
; If you copy just the above stuff and the hotstrings.ahk file, you'll have enough to get started with AHK.

#Include <HotStringAdder> ; Easily add new hotstrings to HotStrings.ahk
#Include <remdir> ; Remove nested directories in Windows Explorer
#Include <EasyWindowDrag> ; Move and resize windows by holding alt and dragging anywhere
#Include <secret> ; Any scripts that contain sensitive information. Not included in the repo.
#Include <excel> ; Excel hotkeys

/*
Some notes on hotkey modifier symbols
# = Winkey
+ = shift
  (hotkeys are otherwise lowercase, c:: = C:: ≠ +c::
^ = ctrl
! = alt
> = RIGHT modifier. >^c is "right ctrl + c"
  good for not accidentally overriding builtin chords
*/

; MAIN.AHK HOTKEYS BELOW HERE

; I like to put impromptu hotkeys in main, and then if they start coalescing around a theme
; (like firefox hotkeys), I create a separate imported file for them.

; !!! IMPORTANT !!!
; These let you update and reload your config on the fly
; They are super, SUPER USEFUL
; (They also only work if you're running an .ahk file, not a compiled .exe)
#!.::Reload
#!,::Edit

; Makes a tooltip with the current time.
; >^>+d --> right-ctrl + right-shift + d 
>^>+d::
{
  ; FormatTime takes (time to format, format string)
  ; If you leave the first item off, it's the current time
  ; READ MORE: https://www.autohotkey.com/docs/v2/lib/FormatTime.htm
  Tooltip(FormatTime(,"yyy-MM-dd hh:mm tt"))

  ; Tooltip() closes any existing tooltip
  ; READ MORE: https://www.autohotkey.com/docs/v2/lib/ToolTip.htm
  SetTimer(() => ToolTip(), -2000) ;-2000 = in 2000 ms, run ONCE
}

