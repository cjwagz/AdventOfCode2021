$EasyDigits = 0
Get-Content .\input | ForEach-Object {
    $SignalPattern,$OutputValue = $_.split('|')
    $OutputValue.Trim().split(' ') | ForEach-Object {
        if (($_ | Measure-Object -Character).Characters -in $(2,3,4,7)) {
            $EasyDigits++
        }
    }
}
$EasyDigits