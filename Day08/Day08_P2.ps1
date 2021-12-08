$Sum = 0
Get-Content .\input | ForEach-Object {
    $Decode = @{}
    $Fives = [System.Collections.ArrayList]::new()
    $Sixes = [System.Collections.ArrayList]::new()
    $SignalPattern,$OutputValue = $_.split('|').Trim()
    $Patterns = $SignalPattern -split '\W+' | ForEach-Object { [string]::Join('', ($_.ToCharArray() | Sort-Object)) }

    $Patterns | ForEach-Object {
        $CountOfCharacters = ($_ | Measure-Object -Character).Characters
        if ($CountOfCharacters -eq 2) { $Decode.$_ = 1; $1 = $_ }
        elseif ($CountOfCharacters -eq 3) { $Decode.$_ = 7; $7 = $_ }
        elseif ($CountOfCharacters -eq 4) { $Decode.$_ = 4; $4 = $_ }
        elseif ($CountOfCharacters -eq 5) { [void]$Fives.Add($_) }
        elseif ($CountOfCharacters -eq 6) { [void]$Sixes.Add($_) }
        elseif ($CountOfCharacters -eq 7) { $Decode.$_ = 8; $8 = $_ }
    }

    $3 = $Fives | Where-Object { $_ -match $1[0] -and $_ -match $1[1] }
    $Decode.$3 = 3
    $Fives.Remove($3)

    $6 = $Sixes | Where-Object { $_ -notmatch $1[0] -or $_ -notmatch $1[1] }
    $Decode.$6 = 6
    $Sixes.Remove($6)

    $Fives | ForEach-Object {
        $DifferenceCount = (Compare-Object -ReferenceObject $6.ToCharArray() -DifferenceObject $_.ToCharArray() | Measure-Object).Count
        if ($DifferenceCount -eq 1) {
            $5 = $_
            $Decode.$_ = 5
        }
        elseif ($DifferenceCount -eq 3) {
            $2 = $_
            $Decode.$_ = 2
        }
    }

    $Sixes | ForEach-Object {
        $DifferenceCount = (Compare-Object -ReferenceObject $5.ToCharArray() -DifferenceObject $_.ToCharArray() | Measure-Object).Count
        if ($DifferenceCount -eq 1) {
            $9 = $_
            $Decode.$_ = 9
        }
        elseif ($DifferenceCount -eq 3) {
            $0 = $_
            $Decode.$_ = 0
        }
    }

    $Values = $OutputValue -split '\W+' | ForEach-Object { [string]::Join('', ($_.ToCharArray() | Sort-Object)) }
    $Sum = $Sum + [int]([string]$Decode[$Values[0]] + [string]$Decode[$Values[1]] + [string]$Decode[$Values[2]] + [string]$Decode[$Values[3]])
}
$Sum