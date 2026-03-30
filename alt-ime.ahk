#Requires AutoHotkey v2.0
#SingleInstance Force

; Alt空打ちでIME切り替え
; 左Alt空打ち → IME OFF（英数）
; 右Alt空打ち → IME ON（かな）
; Alt + 他キー → 通常のAlt動作

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
