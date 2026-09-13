$path = ".\entry.asm"
$linesOfTokens = [System.Collections.Generic.List[System.Collections.Generic.List[string]]]::new()
$symbolTable = [System.Collections.Generic.Dictionary[string, int]]::new()

[int]$pc = 0


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

            if ($currentLineTokens.Count -gt 0) {
                $linesOfTokens.Add($currentLineTokens)
            }
        }
    }
}
else {
    Write-Host "File $path not found!" -ForegroundColor Red
    exit
}

for ($i = 0; $i -lt $linesOfTokens.Count; $i++) {
    $tokens = $linesOfTokens[$i]
    $firstToken = $tokens[0]

    if ($firstToken.EndsWith(":")) {
        $labelName = $firstToken.TrimEnd(':')

        $symbolTable[$labelName] = $pc
        Write-Host "Label found: $labelName at PC: 0x$($pc.ToString('X4'))"

        if ($tokens.Count -eq 1) {
            continue
        }

        $tokens.RemoveAt(0)
        $firstToken = $tokens[0]
    }
    elseif ($firstToken.StartsWith(".")) {
        Write-Host "Directive found: $firstToken at PC 0x$($pc.ToString('X4'))"

        continue
    }

    Write-Host "Instruction '$firstToken' at PC 0x$($pc.ToString('X4'))"
    $pc += 4
}

Write-Host "`n--- Symbol Table ---" -ForegroundColor Yellow
foreach ($pair in $symbolTable.GetEnumerator()) {
    Write-Host "$($pair.Key) = 0x$($pair.Value.ToString('X4'))"
}