$VerbosePreference = 'Continue'
$Scores = [System.Collections.ArrayList]::new()
$Openers = @('(','[','{','<')
$Closers = @(')',']','}','>')
$ValidChunk = @{
    ')' = '('
    ']' = '['
    '}' = '{'
    '>' = '<'
}
$ScoreLookup = @{
    '(' = 1
    '[' = 2
    '{' = 3
    '<' = 4
}
Get-Content .\input | ForEach-Object {
    $Stack = [System.Collections.Generic.Stack[string]]::new()
    $Corruption = $false
    foreach ($Item in $_.ToCharArray()) {
        if ($Stack.Count -gt 0) { $LastChar = $Stack.Peek() }
        else { $LastChar = $null }  
        
        if ($Item -in $Openers) {
            $Stack.Push($Item)
        }
        elseif ($Item -in $Closers -and $ValidChunk[[string]$Item] -eq $LastChar) {
            [void]$Stack.Pop()
        }
        else {
            $Corruption = $true
            break
        }
    }
    if (!$Corruption) {
        $Score = 0
        $Stack | ForEach-Object {
            $Score = ($Score * 5) + $ScoreLookup[$_]
        }
        [void]$Scores.Add($Score)
    }
}
$Scores = $Scores | Sort-Object
$Scores[[Math]::Floor($Scores.Count / 2)]