
---

# 🔄 PowerShell Backup & Directory Watcher

A simple yet powerful PowerShell project that automates folder backups, generates ZIP archives, logs activities, and monitors real-time directory changes.

This repository contains two main scripts:

* **backup.ps1** → Automated backup with timestamp, ZIP compression, and activity logging
* **watcher.ps1** → Real-time file system watcher with event-based logging and color alerts

Ideal for learning PowerShell automation, event subscribers, file operations, and JSON-based configuration.

---

## 📁 Project Structure

```
.
├── backup.ps1          # Backup automation script (ZIP + timestamp + logs)
├── watcher.ps1         # Directory change watcher
├── config.json         # User configuration
└── logs/
    └── activity.log    # Generated automatically
```

---

## ⚙️ Configuration (`config.json`)

Edit the configuration file to set your paths:

```json
{
  "SourceFolder": "/Users/USER/Documents/source",
  "BackupFolder": "/Users/USER/Documents/backups",
  "LogFile": "./logs/activity.log",
  "ZipBackup": true
}
```

### Options

| Key          | Description                              |
| ------------ | ---------------------------------------- |
| SourceFolder | Path of the folder to back up or monitor |
| BackupFolder | Destination for backup output            |
| LogFile      | Log file path                            |
| ZipBackup    | Whether to compress backups into a ZIP   |

---

## 🗂️ Backup Script (`backup.ps1`)

This script:

✔ Creates a timestamped folder
✔ Copies all files from source
✔ Optionally generates a ZIP archive
✔ Writes detailed logs of success/failure

### ▶️ Run Backup

```powershell
pwsh backup.ps1
```

### Example output:

```
✅ Backup done (ZIP): /Users/.../backups/backup_2025-01-05_13-20-55.zip
```

Logs are saved in:

```
logs/activity.log
```

---

## 👀 Directory Watcher (`watcher.ps1`)

Monitors all changes in a folder using **FileSystemWatcher**:

* File Created 🟦
* File Deleted 🟥
* File Changed 🟨
* File Renamed 🟪

Each event is printed in the terminal **with color** and logged to the `activity.log` file.

### ▶️ Start Watching

```powershell
pwsh watcher.ps1
```

### Example output:

```
🟦 File Created: /Users/.../test.txt
🟥 File Deleted: /Users/.../old_file.docx
🟨 File Changed: /Users/.../notes.md
```

---

## 📝 Requirements

* **PowerShell 7+ (pwsh)**

  * macOS: `brew install --cask powershell`
  * Windows: pre-installed or install via Microsoft Store
* Read/Write permission to folders

---

## 🚀 Why This Project Matters?

This repo demonstrates:

* PowerShell scripting on **macOS or Windows**
* File & directory automation
* Using **JSON config files**
* Event-based programming with `Register-ObjectEvent`
* Logging & operational scripting
* ZIP archive automation
* Production-like script structure

Perfect for:

* SysAdmin beginners
* DevOps students
* Automation learners
* GitHub portfolio projects

---

## 🧩 Future Enhancements (Optional Ideas)

If you want to extend this project, here are advanced suggestions:

* 🔔 Send notifications (email/Slack/Telegram) on file changes
* 🗃 Save logs to SQLite instead of text
* 🔁 Auto-backup every X minutes using a scheduler
* 🔒 Encrypt ZIP backups
* 🧪 Add PowerShell tests (Pester)
* ⚡ GitHub Actions workflow for CI

---

## 📜 License

MIT License.
Feel free to use, modify, and share.

---

## ✨ Author

**Amir Yarmohamadi**

---
