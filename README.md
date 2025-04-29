# Semianalytically Designed Dual-Polarized PCB

This repository contains code and resources related to the paper *"Semianalytically Designed Dual-Polarized Printed-Circuit-Board (PCB)-Compatible Metagratings"*.

It is designed to be easy to use, even for those new to Git and GitHub.

---

## 📦 Installation (Cloning the Project)

To get a copy of this project on your computer, follow these steps:

1. **Open a terminal**  
   On Windows, you can use **Command Prompt**, **PowerShell**, or **Git Bash**.

2. **Navigate to the folder where you want to save the project**  
   For example:
   ```bash
   cd C:\Users\YourName\Documents
   ```

3. **Clone the project from GitHub (download it)**  
   This command downloads the project into a new folder.
   ```bash
   git clone https://github.com/yulie0101/Semianalytically-Designed-Dual-Polarized-PCB.git
   ```

4. **Go into the new project folder**
   This changes your working folder to the downloaded project.
   ```bash
   cd Semianalytically-Designed-Dual-Polarized-PCB
   ```

You're now inside the project folder and ready to work with the code!

---

## 🛠 Work Process

This section describes how to work with the project using Git.

If you make changes to files, you need to **tell Git to track those changes**, then **save them**, and finally **upload them to GitHub**.

---

## 🧠 Git Basics (Step-by-Step)

### 🔍 Step 1: Check the current status

This command shows which files were changed or added:
```bash
git status
```

### ➕ Step 2: Stage your changes (prepare to save)

If you edited or created a file, you must "stage" it so Git knows you want to include it in your next save (called a commit).

- To stage a specific file:
  ```bash
  git add filename.ext
  ```
- To stage all the changed files:
  ```bash
  git add .
  ```

### ✅ Step 3: Commit (save) your changes locally

Now you're ready to save your staged changes. You must write a short message explaining what you did:

```bash
git commit -m "Explain what you changed"
```

Example:
```bash
git commit -m "Added graphs and updated README"
```

### 🚀 Step 4: Push your changes to GitHub (upload)

After committing, your changes are saved **only on your computer**. To send them to the GitHub server so others can see them, use:

```bash
git push origin main
```

> 🔁 If this is your first push, Git might ask for your username and password (or personal access token).

### 📥 Step 5: Pull the latest version from GitHub

Before making new changes, it's a good idea to get the latest version of the project in case others updated it.

```bash
git pull origin main
```

---

## 🌿 Optional: Use Branches (for testing without affecting the main project)

A branch lets you experiment without changing the main project directly.

- Create a new branch:
  ```bash
  git checkout -b new-feature
  ```

- Switch between branches:
  ```bash
  git checkout main          # go back to the main version
  git checkout new-feature   # go to your branch
  ```

- After testing your changes, you can merge them into the main branch:
  ```bash
  git checkout main
  git merge new-feature
  ```

---

## 📝 Summary
