# watcher.ps1
param(
    [string]$ConfigPath = "./config.json"
)

if (-Not (Test-Path $ConfigPath)) {
    Write-Host "❌ Config file not found!"
    exit
}
$config = Get-Content $ConfigPath | ConvertFrom-Json

$source = $config.SourceFolder
$logFile = $config.LogFile

function Write-Log($msg) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Add-Content -Path $logFile -Value "$timestamp - $msg"
}

if (-Not (Test-Path $source)) {
    Write-Host "❌ Source folder does not exist!"
    exit
}

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $source
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

Write-Host "🟢 Directory Watcher Running on: $source"

Register-ObjectEvent $watcher Created -SourceIdentifier FileCreated -Action {
    Write-Host "🟦 File Created:" $Event.SourceEventArgs.FullPath
    Write-Log "File Created: $($Event.SourceEventArgs.FullPath)"
}

Register-ObjectEvent $watcher Deleted -SourceIdentifier FileDeleted -Action {
    Write-Host "🟥 File Deleted:" $Event.SourceEventArgs.FullPath
    Write-Log "File Deleted: $($Event.SourceEventArgs.FullPath)"
}

Register-ObjectEvent $watcher Changed -SourceIdentifier FileChanged -Action {
    Write-Host "🟨 File Changed:" $Event.SourceEventArgs.FullPath
    Write-Log "File Changed: $($Event.SourceEventArgs.FullPath)"
}

Register-ObjectEvent $watcher Renamed -SourceIdentifier FileRenamed -Action {
    Write-Host "🟪 File Renamed:" $Event.SourceEventArgs.FullPath
    Write-Log "File Renamed: $($Event.SourceEventArgs.FullPath)"
}

Write-Host "⏳ Watching for changes... (Press CTRL+C to stop)"
while ($true) { Start-Sleep -Seconds 1 }
