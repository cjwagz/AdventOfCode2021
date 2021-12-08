$H = 0
$D = 0
$A = 0
Get-Content -Path .\input | ForEach-Object {
    $Direction,$Distance = $_.split(' ')
    switch ($Direction) {
        forward {
            $D = $D + ($A * [int]$Distance)
            $H = $H + [int]$Distance
        }
        down { $A = $A + [int]$Distance }
        up { $A = $A - [int]$Distance }
        Default {}
    }
}
$H * $D