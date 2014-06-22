# Winchey [version 0.1.0]
#
# Based off of Melik Manukyan's Archey
#
# Distributed under the terms of the GNU General Public License v3.
# See http://www.gnu.org/licenses/gpl.txt for the full license text.

clear
$uptime = ((gwmi Win32_OperatingSystem).ConvertToDateTime((gwmi Win32_OperatingSystem).LocalDateTime) - (gwmi Win32_OperatingSystem).ConvertToDateTime((gwmi Win32_OperatingSystem).LastBootUpTime));
$totalDisk = ((Get-WmiObject Win32_LogicalDisk).Size | Measure-Object -sum).Sum
$freeDisk = $totalDisk - ((Get-WmiObject Win32_LogicalDisk).FreeSpace | Measure-Object -sum).Sum


Write-Host "         ,.=:!!t3Z3z.,                 " -f red -nonewline;										Write-Host (gwmi Win32_OperatingSystem).RegisteredUser -nonewline; Write-Host "@" -f white -nonewline; (gwmi Win32_OperatingSystem).CSName
Write-Host "        :tt:::tt333EE3                 " -f red -nonewline;										Write-Host "Distro: " -f gray -nonewline; Write-Host (gwmi Win32_OperatingSystem).Caption (gwmi Win32_OperatingSystem).OSArchitecture
Write-Host "        Et:::ztt33EEE  " -f red -nonewline; Write-Host "@Ee.,      ..,  " -f green -nonewline;	Write-Host "Kernel: " -f gray -nonewline; Write-Host (gwmi Win32_OperatingSystem).Version
Write-Host "       ;tt:::tt333EE7  " -f red -nonewline; Write-Host ";EEEEEEttttt33# " -f green -nonewline;	Write-Host "Uptime: " -f gray  -nonewline; Write-Host $uptime.Days"d " $uptime.Hours"h " $uptime.Minutes"m " $uptime.Seconds"s " -separator ""
Write-Host "      :Et:::zt333EEQ. " -f red -nonewline; Write-Host "SEEEEEttttt33QL  " -f green -nonewline;	Write-Host "Window Manager: " -f gray -nonewline; Write-Host "DWM"
Write-Host "      it::::tt333EEF " -f red -nonewline; Write-Host "@EEEEEEttttt33F   " -f green -nonewline;	Write-Host "Desktop Environment: "-f gray -nonewline; Write-Host "explorer.exe"
Write-Host "     ;3=*^```'*4EEV " -f red -nonewline; Write-Host ":EEEEEEttttt33@.     " -f green -nonewline;	Write-Host "Shell: " -f gray -nonewline; Write-Host "cmd.exe"
Write-Host "     ,.=::::!t=., ` " -f blue -nonewline; Write-Host "@EEEEEEtttz33QF     " -f green -nonewline;	Write-Host "Terminal: " -f gray -nonewline; Write-Host $Host.Name $Host.Version
Write-Host "    ;::::::::zt33)   " -f blue -nonewline; Write-Host "'4EEEtttji3P*     " -f green -nonewline;	Write-Host "Packages: " -f gray -nonewline; Write-Host (gwmi Win32_Product).Count
Write-Host "   :t::::::::tt33 " -f blue -nonewline; Write-Host ":Z3z..  " -f yellow -nonewline; Write-Host "''" -f green -nonewline; Write-Host ",..g.      " -f yellow -nonewline;	Write-Host "CPU: " -f gray -nonewline; Write-Host (((gwmi Win32_Processor).Name) -replace '\s+', ' ')
Write-Host "   i::::::::zt33F " -f blue -nonewline; Write-Host "AEEEtttt::::ztF      " -f yellow -nonewline;	Write-Host "GPU: " -f gray -nonewline; Write-Host (gwmi Win32_DisplayConfiguration).DeviceName
Write-Host "  ;:::::::::t33V " -f blue -nonewline; Write-Host ";EEEttttt::::t3       " -f yellow -nonewline;	Write-Host "RAM: " -f gray -nonewline; Write-Host ([math]::Truncate((gwmi Win32_OperatingSystem).FreePhysicalMemory / 1KB)).ToString() "MB /" ([math]::Truncate((gwmi Win32_ComputerSystem).TotalPhysicalMemory / 1MB)).ToString() "MB"
Write-Host "  E::::::::zt3/ " -f blue -nonewline; Write-Host "/@EEEtttt::::z3F       " -f yellow -nonewline;	Write-Host "Disk: " -f gray -nonewline; Write-Host ([math]::Truncate($freeDisk / 1MB)).ToString() "MB /" ([math]::Truncate($totalDisk / 1MB)).ToString() "MB"
Write-Host " {3=*^```'*4E3)  " -f blue -nonewline; Write-Host "EEEtttt:::::tZ`       " -f yellow;
Write-Host "             ` " -f blue -nonewline; Write-Host ":EEEEtttt::::z7         " -f yellow;
Write-Host "                 'VEzjt:;;z>*`        " -f yellow;
