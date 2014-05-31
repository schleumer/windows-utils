; #@$@#@#$ como eu odeio CTRL+SHIFT+W do Google Chrome
SetTitleMatchMode, Regex
#IfWinActive, (- Google Chrome)$
    ^+w::return
#IfWinActive

; Abre powershell a la ubuntu hotkey
^!t::
	SetWorkingDir, %USERPROFILE%
	Run powershell
	return