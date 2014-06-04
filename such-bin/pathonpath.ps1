# Você sai do linux mas o linux não sai de você

 param (
    [Parameter(Mandatory=$true,
        Position=0,
        HelpMessage='--dir must be set')]
    [ValidateScript({Test-Path $_})] 
    [string]
    $dir = ""
 )

$oldPath = [Environment]::GetEnvironmentVariable('path', 'machine').ToString();
if($oldPath -like "*$dir" -or $oldPath -like "*$dir;*") {
    echo "That path is already on the %PATH%";
    pause;
}else {
    $newPath = "$($oldPath);$($dir)";
    [Environment]::SetEnvironmentVariable('path', $newPath,'Machine');
}