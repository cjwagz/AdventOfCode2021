$VerbosePreference = 'Continue'
$Stack = [System.Collections.Generic.Stack[string]]::new()
$Openers = @('(','[','{','<')
$Closers = @(')',']','}','>')
$ValidChunk = @{
    ')' = '('
    ']' = '['
    '}' = '{'
    '>' = '<'
}
$ScoreLookup = @{
    ')' = 3
    ']' = 57
    '}' = 1197
    '>' = 25137
}
$Score = 0
Get-Content .\input | ForEach-Object {
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
            $Score = $Score + ($ScoreLookup[[string]$Item])
            break
        }
    }
}
$Score