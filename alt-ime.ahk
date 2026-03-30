#Requires AutoHotkey v2.0
#SingleInstance Force

; Alt空打ちでIME切り替え
; 左Alt空打ち → IME OFF（英数）
; 右Alt空打ち → IME ON（かな）
; Alt + 他キー → 通常のAlt動作

; --- スタートアップ登録トレイメニュー ---
startupLink := A_Startup "\alt-ime.lnk"
tray := A_TrayMenu
tray.Insert("1&", "スタートアップに登録", ToggleStartup)
tray.Insert("2&")  ; セパレータ
if FileExist(startupLink)
    tray.Check("スタートアップに登録")

ToggleStartup(itemName, itemPos, menu) {
    global startupLink
    if FileExist(startupLink) {
        FileDelete(startupLink)
        menu.Uncheck(itemName)
    } else {
        FileCreateShortcut(A_ScriptFullPath, startupLink)
        menu.Check(itemName)
    }
}

*~LAlt Up:: {
    if (A_PriorKey = "LAlt")
        IME_SET(0)
}

*~RAlt Up:: {
    if (A_PriorKey = "RAlt")
        IME_SET(1)
}

IME_SET(setState) {
    hwnd := WinGetID("A")
    if (hwnd) {
        imeWnd := DllCall("imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
        if (imeWnd)
            DllCall("SendMessage", "Ptr", imeWnd, "UInt", 0x0283, "Ptr", 0x006, "Ptr", setState)
    }
}
