$Gamma = [System.Collections.ArrayList]::new()
$Epsilon = [System.Collections.ArrayList]::new()
$Working = [System.Collections.ArrayList]::new()
$PuzzleInput = Get-Content .\input
for ($i = 0; $i -lt $PuzzleInput[0].ToCharArray().Count; $i++) {
    $PuzzleInput | ForEach-Object {
        [void]$Working.Add($_[$i])
    }
    $Grouping = $Working | Group-Object | Sort-Object -Descending -Property Count
    [void]$Gamma.Add($Grouping[0].Name)
    [void]$Epsilon.Add($Grouping[1].Name)
    $Working.Clear()
}
$Gamma = $Gamma -join ''
$Epsilon  = $Epsilon -join ''
[System.Convert]::ToInt32($Gamma, 2) * [System.Convert]::ToInt32($Epsilon, 2)