@ECHO OFF
emacs "C:\Program Files (x86)\Acrylic DNS Proxy\AcrylicHosts.txt"
net stop AcrylicController
net start AcrylicController
echo "Okok"