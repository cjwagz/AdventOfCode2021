$VerbosePreference = 'SilentlyContinue'
$PuzzleInput = Get-Content .\input
$Rows = $PuzzleInput.Length
$Columns = ($PuzzleInput[0] | Measure-Object -Character).Characters
$LowPoints = [System.Collections.ArrayList]::new()
for ($r = 0; $r -lt $Rows; $r++) {
    for ($c = 0; $c -lt $Columns; $c++) {
        $Adjacent = [System.Collections.ArrayList]::new()
        if ($r -eq 0 -and $c -eq 0) {
            #TopLeft
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c+1], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r+1].ToCharArray())[$c], 10))
        }
        elseif ($r -eq 0 -and $c -notin @(0,($Columns-1))) {
            #Top
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c+1], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r+1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c-1], 10))
        }
        elseif ($r -eq 0 -and $c -eq $Columns-1) {
            #TopRight
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r+1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c-1], 10))
        }
        elseif ($c -eq 0 -and $r -notin @(0,($Rows-1))) {
            #Left
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r-1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c+1], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r+1].ToCharArray())[$c], 10))
        }
        elseif ($c -eq $Columns-1 -and $r -notin @(0,($Rows-1))) {
            #Right
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r-1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c-1], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r+1].ToCharArray())[$c], 10))
        }
        elseif ($r -eq $Rows-1 -and $c -eq 0) {
            #BottomLeft
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r-1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c+1], 10))
        }
        elseif ($r -eq $Rows-1 -and $c -notin @(0,($Columns-1))) {
            #Bottom
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r-1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c+1], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c-1], 10))
        }
        elseif ($r -eq $Rows-1 -and $c -eq $Columns-1) {
            #BottomRight
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r-1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c-1], 10))
        }
        else {
            #Middle
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c+1], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r+1].ToCharArray())[$c], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c-1], 10))
            [void]$Adjacent.Add([System.Convert]::ToInt32(($PuzzleInput[$r-1].ToCharArray())[$c], 10))
        }
        
        $Height = [System.Convert]::ToInt32(($PuzzleInput[$r].ToCharArray())[$c], 10)
        $Higher = 0
        $Adjacent | ForEach-Object {
            if ($_ -gt $Height) {
                $Higher++
            }
        }

        if ($Adjacent.Count -eq $Higher) {
            Write-Verbose "Store Coordinates"
            [void]$LowPoints.Add([PSCustomObject]@{
                X = $c
                Y = $r
            })
        }
    }
}