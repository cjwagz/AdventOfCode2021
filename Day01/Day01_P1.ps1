$DepthIncreaseCount = 0
Get-Content -Path .\input | ForEach-Object {
    if ($_ -gt $Prev) { $DepthIncreaseCount++ }
    $Prev = $_
}
$DepthIncreaseCount