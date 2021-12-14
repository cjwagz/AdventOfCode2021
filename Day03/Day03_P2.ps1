$PuzzleInput = Get-Content .\input
$Oxygen = [System.Collections.ArrayList]::new()
$CO2 = [System.Collections.ArrayList]::new()
$OxygenList = $PuzzleInput
$CO2List = $PuzzleInput
for ($i = 0; $i -lt $PuzzleInput[0].ToCharArray().Count; $i++) {
    if ($i -eq 0) {
        $PuzzleInput | ForEach-Object {
            [void]$Working.Add($_[$i])
        }
        $Grouping = $Working | Group-Object | Sort-Object -Descending -Property Count
        [void]$Oxygen.Add($Grouping[0].Name)
        [void]$CO2.Add($Grouping[1].Name)
        $OxygenList = $OxygenList | Where-Object { $_ -like ("$($Oxygen -join '')" + "*") }
        $CO2List = $CO2List | Where-Object { $_ -like ("$($CO2 -join '')" + "*") }
    }
    else {
        if ($OxygenList.Count -ne 1) {
            $OxygenList | ForEach-Object {
                [void]$Working.Add($_[$i])
            }
            $Grouping = $Working | Group-Object | Sort-Object -Descending -Property Count
            [void]$Oxygen.Add($Grouping[0].Name)
            $OxygenList = $OxygenList | Where-Object { $_ -like ("$($Oxygen -join '')" + "*") }
        }
        if ($CO2List.Count -ne 1) {
            $CO2List | ForEach-Object {
                [void]$Working.Add($_[$i])
            }
            $Grouping = $Working | Group-Object | Sort-Object -Descending -Property Count
            [void]$CO2.Add($Grouping[1].Name)
            $CO2List = $CO2List | Where-Object { $_ -like ("$($CO2 -join '')" + "*") }
        }
    }
    $Working.Clear()
}
[System.Convert]::ToInt32($OxygenList, 2) * [System.Convert]::ToInt32($CO2List, 2)