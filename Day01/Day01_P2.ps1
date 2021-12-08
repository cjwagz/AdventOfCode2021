$DepthIncreaseCount = 0
$PuzzleInput = Get-Content -Path .\input
for ($i = 0; $i -lt ($PuzzleInput.Count-2); $i++) {
    $ThreeMeasurementSum = ($PuzzleInput[$i..($i+2)] | Measure-Object -Sum).Sum
    if ($ThreeMeasurementSum -gt $Prev) { $DepthIncreaseCount++ }
    $Prev = $ThreeMeasurementSum
}
$DepthIncreaseCount