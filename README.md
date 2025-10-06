<div align="center">

![Unity CLI Manager](./assets/banner.png)

<h1>Unity CLI Manager</h1>

<p>A command-line interface for managing Unity projects efficiently</p>

[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/yourusername/unity-cli-manager)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Windows-lightgrey.svg)](https://github.com/yourusername/unity-cli-manager)

</div>

<br>

## Overview

Unity CLI Manager brings the power of Unity project management to your terminal. Whether you're creating new projects, building for multiple platforms, or managing your workspace, everything is just one command away. Built for developers who value speed and efficiency.

<br>

## What It Does

**Project Lifecycle Management**  
Create, open, and delete Unity projects with simple commands. No more navigating through Unity Hub for basic operations.

**Multi-Platform Building**  
Build your projects for Linux, Windows, and macOS directly from the command line. Perfect for CI/CD pipelines and automated workflows.

**Project Templates**  
Start with 2D or 3D templates right from project creation. The tool handles all Unity initialization automatically.

**Smart Project Organization**  
All projects are centralized in one configurable directory. View detailed information, check Unity versions, and see project sizes at a glance.

**Safety First**  
Destructive operations like project deletion require confirmation. Color-coded output keeps you informed at every step.

<br>

## Installation

### What You Need

- Unity Editor installed on your system
- Bash shell (works on Linux, macOS, or Windows via WSL)

### Getting Started

**Step 1: Download**

```bash
git clone https://github.com/yourusername/unity-cli-manager.git
cd unity-cli-manager
```

**Step 2: Make Executable**

```bash
chmod +x unity-cli.sh
```

**Step 3: Configure Your Environment**

Open `unity-cli.sh` in your favorite editor and set your paths:

```bash
UNITY_PATH="$HOME/Flow/Unity/Editor/Unity"      # Path to your Unity Editor
PROJECTS_DIR="$HOME/MyProjects"                 # Where you want projects stored
```

> [!TIP]
> On macOS, your Unity path might be `/Applications/Unity/Hub/Editor/[version]/Unity.app/Contents/MacOS/Unity`

**Step 4: Create Command Alias**

Add this to your `~/.bashrc`, `~/.zshrc`, or `~/.bash_profile`:

```bash
alias unity='/absolute/path/to/unity-cli.sh'
```

Then reload:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

**Step 5: Test It**

```bash
unity version
```

You should see your configuration and a confirmation that Unity Editor was found.

<br>

## Command Reference

### Creating Projects

```bash
unity new <ProjectName> <2d|3d>
```

Creates a new Unity project with the specified template. Project names must not contain spaces—use camelCase or underscores.

**Examples:**
```bash
unity new SpaceShooter 3d
unity new PlatformerGame 2d
unity new RPG_System 3d
```

The script runs Unity in batch mode to create the project, so you won't see the Unity Editor window during creation. Projects are placed in your configured `PROJECTS_DIR`.

---

### Opening Projects

```bash
unity open <ProjectName>
```

Launches Unity Editor with the specified project. The editor opens in the background, letting you continue working in your terminal.

**Example:**
```bash
unity open SpaceShooter
```

If the project doesn't exist, you'll see a list of available projects.

---

### Building Projects

```bash
unity build <ProjectName> [platform]
```

Builds your project for the target platform in batch mode. If no platform is specified, defaults to Linux 64-bit.

**Supported Platforms:**

| Platform | Aliases | Output |
|----------|---------|--------|
| `linux64` | `linux` | Executable for Linux 64-bit |
| `windows` | `win64` | .exe for Windows 64-bit |
| `mac` | `osx` | .app bundle for macOS |

**Examples:**
```bash
unity build SpaceShooter                  # Builds for Linux
unity build SpaceShooter windows          # Builds for Windows
unity build PlatformerGame mac            # Builds for macOS
```

**Build Output:**

Builds are automatically organized in your project:
```
ProjectName/
  Builds/
    Linux/
      ProjectName.x86_64
    Windows/
      ProjectName.exe
    Mac/
      ProjectName.app
```

The build process runs headless (no graphics), making it perfect for remote servers and automation.

> [!NOTE]
> Make sure you have the required platform build support installed in Unity Hub before building for non-native platforms.

---

### Listing Projects

```bash
unity list
```

**Alias:** `unity ls`

Displays all Unity projects in your projects directory.

**Output:**
```
Unity Projects:
  - SpaceShooter
  - PlatformerGame
  - RPG_System
```

---

### Project Information

```bash
unity info <ProjectName>
```

Shows detailed information about a specific project.

**Example:**
```bash
unity info SpaceShooter
```

**Output:**
```
Project Information:
  Name: SpaceShooter
  Path: /home/user/MyProjects/SpaceShooter
  Unity Version: 2023.2.0f1
  Size: 1.2G
```

Useful for checking Unity version compatibility before opening projects or verifying project sizes.

---

### Deleting Projects

```bash
unity delete <ProjectName>
```

**Alias:** `unity rm`

Permanently removes a project directory and all its contents.

**Example:**
```bash
unity delete OldPrototype
```

You'll be prompted to confirm:
```
Are you sure you want to delete 'OldPrototype'? (y/N):
```

> [!WARNING]
> Deletion is permanent and irreversible. The entire project directory will be removed from your filesystem. Always double-check the project name before confirming.

---

### Version Information

```bash
unity version
```

**Aliases:** `unity --version`, `unity -v`

Displays the Unity CLI Manager version, your configuration, and verifies Unity Editor installation.

**Output:**
```
Unity CLI Manager v1.0

Configuration:
  Unity Path: /home/user/Flow/Unity/Editor/Unity
  Projects Directory: /home/user/MyProjects

Unity Editor found
```

---

### Help

```bash
unity help
```

**Aliases:** `unity --help`, `unity -h`

Shows comprehensive usage information and examples for all commands.

<br>

## Real-World Workflows

### Starting a New Game

```bash
# Create your project
unity new MyAwesomeGame 3d

# Open it in Unity Editor for development
unity open MyAwesomeGame

# Build for testing on your machine
unity build MyAwesomeGame

# Build for distribution
unity build MyAwesomeGame windows
unity build MyAwesomeGame mac
```

### Maintaining Multiple Projects

```bash
# See what you're working on
unity list

# Check project details
unity info OldProject

# Clean up finished projects
unity delete Prototype_v1
unity delete TestProject
```

### Automated Build Pipeline

```bash
# Build script for CI/CD
unity build GameProject linux64
unity build GameProject windows
unity build GameProject mac

# All builds are now in GameProject/Builds/
```

<br>

## Configuration Details

### Customizing Paths

The script uses two main configuration variables:

```bash
UNITY_PATH="$HOME/Flow/Unity/Editor/Unity"
PROJECTS_DIR="$HOME/MyProjects"
```

**UNITY_PATH:**  
Full path to your Unity Editor executable. This varies by platform and installation method:

- **Linux:** Usually in your home directory or `/opt/Unity/`
- **macOS:** Typically `/Applications/Unity/Hub/Editor/[version]/Unity.app/Contents/MacOS/Unity`
- **Windows (WSL):** Mounted from your Windows installation

**PROJECTS_DIR:**  
Where all your Unity projects will be created and managed. Can be any directory where you have write permissions.

### Working with Multiple Unity Versions

If you work with multiple Unity versions, you can:

1. **Create separate scripts** for each version:
   ```bash
   cp unity-cli.sh unity-2022.sh
   cp unity-cli.sh unity-2023.sh
   # Edit each to point to different Unity installations
   ```

2. **Use environment variables:**
   ```bash
   UNITY_PATH="/path/to/Unity2023" unity new Project2023 3d
   ```

3. **Create version-specific aliases:**
   ```bash
   alias unity2022='/path/to/unity-2022.sh'
   alias unity2023='/path/to/unity-2023.sh'
   ```

<br>

## Understanding the Output

The script uses color-coded messages for clarity:

- **Blue** - Informational messages (operations in progress)
- **Green** - Success messages (operations completed)
- **Yellow** - Warnings (non-critical issues)
- **Red** - Errors (critical issues that stop execution)

### Common Messages

**"Creating new 3d project: ProjectName"**  
Unity is being invoked to create your project. This might take a minute depending on your system.

**"Unity Editor launched"**  
The editor has started. It will open in a separate window.

**"Build completed successfully"**  
Your build finished without errors. Check the build location in the output.

**"Project already exists"**  
You tried to create a project with a name that's already taken. Choose a different name.

<br>

## Troubleshooting

> [!WARNING]
> If Unity Editor is not found, verify that `UNITY_PATH` in the script points to your actual Unity installation. Run `unity version` to check your configuration. For build issues, check Unity logs at `~/Unity/Editor.log` and ensure target platform build support is installed via Unity Hub.

### Quick Fixes

**Script won't run:**
- Check that it's executable: `chmod +x unity-cli.sh`
- Verify you're using bash: `bash --version`

**Projects not appearing in `unity list`:**
- Verify `PROJECTS_DIR` points to the correct location
- Check that the directory exists and contains Unity projects

**Builds fail silently:**
- Open the Unity log file: `cat ~/Unity/Editor.log`
- Ensure no compilation errors exist in the Unity project
- Verify platform build support is installed

<br>

<!-- ## Technical Requirements -->
<!---->
<!-- **Essential:** -->
<!-- - Unity Editor (any recent version: 2020.x, 2021.x, 2022.x, 2023.x, or newer) -->
<!-- - Bash 4.0 or later -->
<!-- - Read/write permissions for projects directory -->
<!---->
<!-- **For Specific Platforms:** -->
<!-- - **Windows builds:** No additional requirements (cross-compilation supported) -->
<!-- - **macOS builds:** Best results when building on macOS, but cross-compilation possible -->
<!-- - **Linux builds:** No additional requirements -->
<!---->
<!-- **Storage:** -->
<!-- - Unity projects: 500MB - 5GB per project (depending on assets) -->
<!-- - Builds: 50MB - 500MB per platform build -->
<!---->
<!-- <br> -->

<!-- ## Extending the Tool -->
<!---->
<!-- The script is designed to be easily extended. Here are some ideas: -->
<!---->
<!-- **Additional Templates:** -->
<!-- Add support for Universal Render Pipeline (URP) or High Definition Render Pipeline (HDRP) templates. -->
<!---->
<!-- **WebGL Support:** -->
<!-- Add WebGL as a build target for browser-based games. -->
<!---->
<!-- **Custom Build Configurations:** -->
<!-- Extend the build command to support debug/release configurations. -->
<!---->
<!-- **Project Archiving:** -->
<!-- Add a command to compress projects for backup or sharing. -->
<!---->
<!-- **Batch Operations:** -->
<!-- Add support for building multiple projects or all projects at once. -->
<!---->
<!-- The script is well-commented and modular—each command is a separate function, making additions straightforward. -->
<!---->
<!-- <br> -->

## Version History

**v1.0** — Initial Release (2025)
- Project creation with 2D and 3D templates
- Project opening and management
- Multi-platform builds (Linux, Windows, macOS)
- Color-coded terminal output
- Safety confirmations for destructive operations
- Comprehensive error handling
- Alias support for common commands

<br>

## Contributing

This is an open tool that welcomes improvements. Some areas for contribution:

- Additional build platform support (WebGL, mobile)
- Unity Hub integration
- Project template customization
- Build configuration options
- Automated testing support
- Plugin/package management

Feel free to fork, modify, and submit pull requests.

<br>
<br>

<div align="center">

**Built for developers who live in the terminal**

[⬆ Back to Top](#unity-cli-manager)

</div
