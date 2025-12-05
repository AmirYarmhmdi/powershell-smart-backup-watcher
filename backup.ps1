# backup.ps1
param(
    [string]$ConfigPath = "./config.json"
)

# --- Load Config ---
if (-Not (Test-Path $ConfigPath)) {
    Write-Host "❌ Config file not found!"
    exit
}
$config = Get-Content $ConfigPath | ConvertFrom-Json

$source = $config.SourceFolder
$backupRoot = $config.BackupFolder
$logFile = $config.LogFile
$zipEnabled = $config.ZipBackup

function Write-Log($msg) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Add-Content -Path $logFile -Value "$timestamp - $msg"
}

# --- Check Source Folder ---
if (-Not (Test-Path $source)) {
    Write-Log "❌ Backup failed: Source folder not found."
    Write-Host "❌ Source folder missing."
    exit
}

# --- Create Backup Destination ---
if (-Not (Test-Path $backupRoot)) {
    New-Item -Path $backupRoot -ItemType Directory | Out-Null
}

$timeStamp = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")
$backupFolder = Join-Path $backupRoot "backup_$timeStamp"

New-Item -ItemType Directory -Path $backupFolder | Out-Null

# --- Copy the files ---
Copy-Item -Path "$source/*" -Destination $backupFolder -Recurse -Force

# --- Optional ZIP ---
if ($zipEnabled -eq $true) {
    $zipPath = "$backupFolder.zip"
    Compress-Archive -Path $backupFolder -DestinationPath $zipPath -Force

    # حذف فولدر اصلی (اختیاری)
    Remove-Item $backupFolder -Recurse -Force

    Write-Log "✅ Backup created (ZIP): $zipPath"
    Write-Host "✅ Backup done (ZIP): $zipPath"
}
else {
    Write-Log "✅ Backup created: $backupFolder"
    Write-Host "✅ Backup done: $backupFolder"
}
