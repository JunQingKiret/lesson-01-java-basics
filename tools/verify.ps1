$ErrorActionPreference = "Stop"
$utf8 = [System.Text.UTF8Encoding]::new($false)
[Console]::InputEncoding = $utf8
[Console]::OutputEncoding = $utf8
$OutputEncoding = $utf8

$lessonRoot = Split-Path $PSScriptRoot -Parent
$starterSource = Join-Path $lessonRoot "student\starter\WarehouseBasics.java"
$answerSource = Join-Path $lessonRoot "teacher\answer\WarehouseBasics.java"
$workRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("lesson-01-java-basics-verify-" + $PID)
$starterOutput = Join-Path $workRoot "starter"
$answerOutput = Join-Path $workRoot "answer"

function Assert-NativeSuccess([string]$Step) {
    if ($LASTEXITCODE -ne 0) {
        throw "$Step failed with exit code $LASTEXITCODE."
    }
}

function Assert-Contains([string]$Actual, [string]$Expected, [string]$CaseName) {
    if (-not $Actual.Contains($Expected)) {
        throw "$CaseName failed. Missing output: $Expected`nActual output:`n$Actual"
    }
}

function Invoke-Answer([string[]]$InputLines) {
    $inputText = ($InputLines -join [Environment]::NewLine) + [Environment]::NewLine
    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.FileName = (Get-Command java).Source
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardInput = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.StandardInputEncoding = $utf8
    $startInfo.StandardOutputEncoding = $utf8
    $startInfo.StandardErrorEncoding = $utf8
    $startInfo.ArgumentList.Add("-Dfile.encoding=UTF-8")
    $startInfo.ArgumentList.Add("-Dstdout.encoding=UTF-8")
    $startInfo.ArgumentList.Add("-Dstderr.encoding=UTF-8")
    $startInfo.ArgumentList.Add("-Dstdin.encoding=UTF-8")
    $startInfo.ArgumentList.Add("-cp")
    $startInfo.ArgumentList.Add($answerOutput)
    $startInfo.ArgumentList.Add("WarehouseBasics")

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    $null = $process.Start()
    $process.StandardInput.Write($inputText)
    $process.StandardInput.Close()
    $output = $process.StandardOutput.ReadToEnd()
    $errorOutput = $process.StandardError.ReadToEnd()
    $process.WaitForExit()

    if ($process.ExitCode -ne 0) {
        throw "Run answer failed with exit code $($process.ExitCode).`n$errorOutput"
    }

    return $output
}

New-Item -ItemType Directory -Force -Path $starterOutput, $answerOutput | Out-Null

try {
    & javac -encoding UTF-8 -d $starterOutput $starterSource
    Assert-NativeSuccess "Compile starter"

    & javac -encoding UTF-8 -d $answerOutput $answerSource
    Assert-NativeSuccess "Compile answer"

    $results = [System.Collections.Generic.List[object]]::new()

    $t01 = Invoke-Answer @("0")
    Assert-Contains $t01 "===== 103 仓库基础练习 =====" "T01"
    Assert-Contains $t01 "已退出 103 仓库基础练习。" "T01"
    $results.Add([pscustomobject]@{ Test = "T01"; Result = "PASS" })

    $t02 = Invoke-Answer @("1", "0")
    foreach ($item in @("螺丝刀", "Keyboard", "打印纸", "安全帽")) {
        Assert-Contains $t02 $item "T02"
    }
    $results.Add([pscustomobject]@{ Test = "T02"; Result = "PASS" })

    $t03 = Invoke-Answer @("2", "螺丝", "0")
    Assert-Contains $t03 "找到：螺丝刀" "T03"
    $results.Add([pscustomobject]@{ Test = "T03"; Result = "PASS" })

    $t04 = Invoke-Answer @("2", "key", "0")
    Assert-Contains $t04 "找到：Keyboard" "T04"
    $results.Add([pscustomobject]@{ Test = "T04"; Result = "PASS" })

    $t05 = Invoke-Answer @("2", "不存在", "0")
    Assert-Contains $t05 "未找到包含“不存在”的物品。" "T05"
    $results.Add([pscustomobject]@{ Test = "T05"; Result = "PASS" })

    $t06 = Invoke-Answer @("2", "   ", "0")
    Assert-Contains $t06 "搜索关键字不能为空。" "T06"
    $results.Add([pscustomobject]@{ Test = "T06"; Result = "PASS" })

    $t07 = Invoke-Answer @("abc", "0")
    Assert-Contains $t07 "你输入的是：abc" "T07"
    $results.Add([pscustomobject]@{ Test = "T07"; Result = "PASS" })

    $t08 = Invoke-Answer @("1", "2", "key", "9", "0")
    $menuCount = [regex]::Matches($t08, "===== 103 仓库基础练习 =====").Count
    if ($menuCount -ne 4) {
        throw "T08 failed. Expected 4 menus, actual: $menuCount`n$t08"
    }
    Assert-Contains $t08 "已退出 103 仓库基础练习。" "T08"
    $results.Add([pscustomobject]@{ Test = "T08"; Result = "PASS" })

    $results | Format-Table -AutoSize
    Write-Host "Starter and answer compile successfully. All 8 answer behavior tests passed."
}
finally {
    $resolvedWork = [System.IO.Path]::GetFullPath($workRoot)
    $resolvedTemp = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())

    if ($resolvedWork.StartsWith($resolvedTemp, [System.StringComparison]::OrdinalIgnoreCase) -and
        (Split-Path $resolvedWork -Leaf).StartsWith("lesson-01-java-basics-verify-")) {
        [System.IO.Directory]::Delete($resolvedWork, $true)
    }
}

