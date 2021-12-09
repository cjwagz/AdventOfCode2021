$VerbosePreference = 'Continue'
$PuzzleInput = Get-Content .\input
$Rows = $PuzzleInput.Length
$Columns = ($PuzzleInput[0] | Measure-Object -Character).Characters
for ($r = 0; $r -lt $Rows; $r++) {
    $Row = $PuzzleInput[$r]
    for ($c = 0; $c -lt $Columns; $c++) {
        $Row
        if ($r -eq 0 -and $c -eq 0) {
            #TopLeft
            Write-Verbose "TopLeft"
        }
        elseif ($r -eq 0 -and $c -notin @(0,($Columns-1))) {
            #Top
            Write-Verbose "Top"
        }
        elseif ($r -eq 0 -and $c -eq $Columns-1) {
            #TopRight
            Write-Verbose "TopRight"
        }
        elseif ($c -eq 0 -and $r -notin @(0,($Rows-1))) {
            #Left
            Write-Verbose "Left"
        }
        elseif ($c -eq $Columns-1 -and $r -notin @(0,($Rows-1))) {
            #Right
            Write-Verbose "Right"
        }
        elseif ($r -eq $Rows-1 -and $c -eq 0) {
            #BottomLeft
            Write-Verbose "BottomLeft"
        }
        elseif ($r -eq $Rows-1 -and $c -notin @(0,($Columns-1))) {
            #Bottom
            Write-Verbose "Bottom"
        }
        elseif ($r -eq $Rows-1 -and $c -eq $Columns-1) {
            #BottomRight
            Write-Verbose "BottomRight"
        }
        else {
            #Middle
            Write-Verbose "Middle"
        }
    }
}