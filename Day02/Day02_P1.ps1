$H = 0
$D = 0
Get-Content -Path .\input | ForEach-Object {
    $Direction,$Distance = $_.split(' ')
    switch ($Direction) {
        forward { $H = $H + [int]$Distance }
        down { $D = $D + [int]$Distance }
        up { $D = $D - [int]$Distance }
        Default {}
    }
}
$H * $D