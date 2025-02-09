#SingleInstance, force
SetKeyDelay, -1
SetBatchLines, -1
SetMouseDelay, -1


if (A_ScreenDPI * 100 // 96 != 100) {
	Run, ms-settings:display
	msgbox, 0x1030, WARNING!!, % "Your Display Scale seems to be a value other than 100`%. This means the macro will NOT work correctly!`n`nTo change this, right-click on your Desktop -> Click 'Display Settings' -> Under 'Scale & Layout', set Scale to 100`% -> Close and Restart Roblox before starting the macro.", 60
	ExitApp
}

rWidth := 1920
rHeight := 1080
PixelX := 1263
PixelY := 527
tealColor := "00F9F9"
tolerance := 10
SysGet, cWidth, 0
SysGet, cHieght, 1
normalX := PixelX / rWidth
normalY := PixelY / rHeight
ScaledX := Round(normalX * cWidth)
ScaledY := Round(normalY * cHieght)
;       MsgBox, scaled coords: X=%ScaledX%, Y=%ScaledY%



message= 
(
Quick Tutorial: To use this macro, make sure you're in full-screen mode on Roblox.

Go into your settings and press Edit Meter Customization. After that just make the meter color Teal.

Done! Just go into training area and try it out! Just hold E as normally and the macro will do the rest!
)

; Display the message in a message box with a timeout of 60 seconds
msgbox, , Jahhsm's Basketball Legends Macpro, % message, 60

IniRead, sub_confirmation, Setting.ini, jahhsm, sub_confirmation, 0

; If "sub_confirmation" is not set (0), prompt user to subscribe to the channel
If (!sub_confirmation) {
    Run, % "https://discord.gg/CGgJtn5hAn"
    Sleep 3000  ; Wait for 3 seconds before showing the next message box
    ; Open the subscription URL for the user to subscribe
    Run, % "https://www.youtube.com/@jahhsm?sub_confirmation=1"
    Sleep 5000
    ; Display a message box asking the user to subscribe
    MsgBox, 4, Jahhsm's Basketball Legends Macpro, subcribe, 60
    ; If user presses "No", exit the macro
    IfMsgBox, No 
    {
        ExitApp
    }
    Sleep 1000
}
IniWrite, 1, Setting.ini, jahhsm, sub_confirmation
Loop
{
    PixelGetColor, currentColor, %ScaledX%, %ScaledY%
    if (dColorTo(currentColor, tealColor, tolerance))
    {
        ToolTip, Teal color has been detected
        Send, {e up}
        Sleep, 1000
        ToolTip
    }
    Sleep, 1
}
F5::ExitApp
dColorTo(color1, color2, tolerance)
{
    r1 := "0x" . SubStr(color1, 1, 2)
    g1 := "0x" . SubStr(color1, 3, 2)
    b1 := "0x" . SubStr(color1, 5, 2)

    r2 := "0x" . SubStr(color2, 1, 2)
    g2 := "0x" . SubStr(color2, 3, 2)
    b2 := "0x" . SubStr(color2, 5, 2)
    diffR := Abs(r1 - r2)
    diffG := Abs(g1 - g2)
    diffB := Abs(b1 - b2)
    return (diffR <= tolerance && diffG <= tolerance && diffB <= tolerance)
}
