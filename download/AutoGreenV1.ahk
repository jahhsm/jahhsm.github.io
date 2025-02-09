#SingleInstance, force
G::
    holdTime := 328.8833
    Tooltip, Holding "E for" %holdTime%ms...
    Send, {e down}
    Sleep, holdTime
    Send, {e up}
    Tooltip, Released "E was held for" %holdTime%ms
    Sleep, 2000
    Tooltip
return
F5::ExitApp
