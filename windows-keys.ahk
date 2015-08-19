; Initialize variables
X := 0
Y := 0
W := A_ScreenWidth
H := A_ScreenHeight
 return

;#w::
;    WinGet, window, ID, A    ; Use the ID of the active window.
;   Toggle_Window(window)
; return

#/::
	MouseGetPos,,, window    ; Use the ID of the window under the Mouse.
    Toggle_Window(window)
 return

^+w::return
^+q::return

; Abre powershell a la ubuntu hotkey
^!t::
	SetWorkingDir, %USERPROFILE%
	Run powershell
	return

Toggle_Window(window)
{
	 global X, Y, W, H    ; Since Toggle_Window() is a function, set Up X, Y, W, and H as globals
	 WinGet, S, Style, % "ahk_id " window    ; Get the style of the window
	If (S & +0xC00000)       ; if not borderless
	{
		 WinGetPos, X, Y, W, H, % "ahk_id " window    ; Store window size/location
		XMed := (2* X + W) / 2	 ; Find the middle of the window
		YMed := (2* Y + H) / 2	 ; Find the middle of the window
		 ; We check to see if the current window is outside of the default monitor.
		 ; If it is, we increment our multiplier and try the next window (in all 4 directions).
		 ; NOTE: This won't work for multi-monitor setups with different resolutions.
		 Loop
		{
			 if(XMed > A_ScreenWidth * A_Index || XMed < A_ScreenWidth * (-1 * A_Index))
				 continue
			 if(XMed > A_ScreenWidth * (A_Index - 1))
				XPos := (A_Index - 1) * A_ScreenWidth
			 else
				XPos := (-1 * A_Index) * A_ScreenWidth
			 break
		}
		 Loop
		{
			 if(YMed > A_ScreenHeight * A_Index || YMed < A_ScreenHeight * (-1 * A_Index))
				 continue
			 if(YMed > A_ScreenWidth * (A_Index - 1))
				YPos := (A_Index - 1) * A_ScreenHeight
			 else
				YPos := (-1 * A_Index) * A_ScreenHeight
			 break
		}
		 WinSet, Style, -0xC00000, % "ahk_id " window    ; Remove borders
		 ; WinMove, % "ahk_id " window,, %XPos%, %YPos%, %A_ScreenWidth%, %A_ScreenHeight%   ; Stretch to Screen-size
		 return
	}
	If (S & -0xC00000)       ; if borderless
	{
		 WinSet, Style, +0xC00000, % "ahk_id " window    ; Reapply borders
		 ; WinMove, % "ahk_id " window,, X, Y, W, H       ; return to original position
		 return
	}
	Return    ; return if the other if's don't fire (shouldn't be possible in most cases)
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                      ;;
;; KDE-Style Alt-Grab Window Move Convenience Script    ;;
;;                                                      ;;
;; version 0.1 - 07/24/04                               ;;
;; ck <use www.autohotkey.com forum to contact me>      ;;
;;                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Usage Instructions:
;; -------------------
;; Load Script into AutoHotKey (only verified to work properly with 1.0.16 and Windows XP)
;; - Hold down the Alt key and lef-click anywhere in a window to move the window

LAlt & LButton::
; If this command isn't used, all commands except those documented otherwise (e.g. WinMove and InputBox) 
; use coordinates that are relative to the active window
CoordMode, Mouse, Screen

; speed things up
SetWinDelay, 0

; get current mouse position
MouseGetPos, OLDmouseX, OLDmouseY, WindowID

; get the postition and ID of the window under the mouse cursor
WinGetPos, winX, winY, winW, winH ,ahk_id %WindowID%

; Turn off Window Animation
;RegRead, BoolMinAni, HKEY_CURRENT_USER,Control Panel\Desktop\WindowMetrics, MinAnimate
;if BoolMinAni = 1
;{
;	; this has no effect until it's reloaded / re-logon... (-> disabled code)
;	RegWrite, REG_SZ, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, MinAnimate, 0
;}

; this restore (= undo max or min) call tells the OS that originally 
; maximized windows are now restored/normal and can be moved even after this script takes off
; this is absolutely mandatory for windows which remember their last location like IE windows
; otherwise you cannot properly maximize them anymore

;WinHide, ahk_id %WindowID%
WinRestore, ahk_id %WindowID%
WinMove, ahk_id %WindowID%,,%winX%,%winY%,%winW%,%winH%
;WinShow, ahk_id %WindowID%

Loop
{
	; is the User still keeping that Alt key down?
	GetKeyState, AltKeyState, Alt, P
	if AltKeyState = U ; key has been released
	{
		break
	}
		
	; get new mouse position
	MouseGetPos, newMouseX, newMouseY

	; get relative mouse X movement
	if newMouseX < %OLDmouseX% 
	{
		; mouse was moved to the left
		Xdistance = %OLDmouseX%
		EnvSub, Xdistance, %newMouseX%	
		EnvSub, winX, %Xdistance%
	}
	else if newMouseX > %OLDmouseX% 
	{
		; mouse was moved to the right
		Xdistance = %newMouseX%
		EnvSub, Xdistance, %OLDmouseX%	
		EnvAdd, winX, %Xdistance%
	}
	else 
	{
		; mouse X coordinate wasn't changed
	}
	
	; set OLDmouseX
	OLDmouseX = %newMouseX%

	; repeat the same stuff for the Y-axis
	if newMouseY < %OLDmouseY% 
	{
		Ydistance = %OLDmouseY%
		EnvSub, Ydistance, %newMouseY%	
		EnvSub, winY, %Ydistance%
	}
	else if newMouseY > %OLDmouseY% 
	{
		Ydistance = %newMouseY%
		EnvSub, Ydistance, %OLDmouseY%	
		EnvAdd, winY, %Ydistance%
	}
	else 
	{
	}
	OLDmouseY = %newMouseY%

	; move Window accordingly
	WinMove, ahk_id %WindowID%,,%winX%,%winY%
}
return

