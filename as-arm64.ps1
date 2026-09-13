$path = ".\entry.asm"
$linesOfTokens = [System.Collections.Generic.List[System.Collections.Generic.List[string]]]::new()
$outputCode = [System.Collections.Generic.List[System.Collections.Generic.list[string]]]::new()

if (Test-Path $path) {
    foreach ($line in [System.IO.File]::ReadLines($path)) {
        $cleanLine = $line.Split(';')[0].Trim()

        if ($cleanLine) {
            $currentLineTokens = [System.Collections.Generic.List[string]]::new()

            $words = $cleanLine -split '[\s,]+'

            foreach ($word in $words) {
                if ($word) {
                    $currentLineTokens.Add($word)
                }
            }

            $linesOfTokens.Add($currentLineTokens)
        }
    }
}
else {
    Write-Host "File $path not found!" -ForegroundColor Red
}


for ($i = 0; $i -lt $linesOfTokens.Count; $i++) {
    Write-Host "Line $i`:" -ForegroundColor Yellow
    
    for ($j = 0; $j -lt $linesOfTokens[$i].Count; $j++) {
        $token = $linesOfTokens[$i][$j]
        Write-Host "  Token [$j]: $token"
    }
}

for ($i = 0; $i -lt $linesOfTokens.Count; $i++) {
    $cmd = $linesOfTokens[$i][0]
    [bool]$isDirective = $cmd.StartsWith(".", [System.StringComparison]::OrdinalIgnoreCase)
    if ($isDirective -eq 1) {
        Write-Host "is directive at $lineOfTokens[$i]"
    }
}
