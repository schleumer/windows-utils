 param (
    [string]$dir = $pwd
 )

$oldPath = [Environment]::GetEnvironmentVariable('path', 'machine').ToString();
if($oldPath -like "*$dir" -or $oldPath -like "*$dir;*") {
    echo "That path is already on the %PATH%";
    pause
}else {
    $newPath = "$($oldPath);$($dir)"
    [Environment]::SetEnvironmentVariable('path', $newPath,'Machine');
}
# $oldPath = [Environment]::GetEnvironmentVariable('path', 'machine');
# [Environment]::SetEnvironmentVariable('path2', "$($newPath);$($oldPath)",'Machine');
# $oldPath = [Environment]::GetEnvironmentVariable('path', 'machine');
# [Environment]::SetEnvironmentVariable('path2', "$($newPath);$($oldPath)",'Machine');