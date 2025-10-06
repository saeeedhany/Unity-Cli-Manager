<div align="center">

![Unity CLI Manager](./assets/banner.png)

<h1>Unity CLI Manager</h1>

<p>A powerful command-line interface for managing Unity projects efficiently from the terminal</p>

[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/yourusername/unity-cli-manager)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20WSL-lightgrey.svg)](https://github.com/yourusername/unity-cli-manager)

</div>

<br>

## Overview

Unity CLI Manager streamlines Unity project workflows by providing a simple, powerful command-line interface. Create, open, build, and manage Unity projects without leaving your terminal—designed for developers who value efficiency and prefer working from the command line.

<br>

## Features

**Project Management**  
Create, open, list, and delete Unity projects with simple commands

**Multi-Platform Builds**  
Build for Linux, Windows, macOS, Android, and iOS from a single interface

**Project Templates**  
Quick project setup with support for both 2D and 3D templates

**Color-Coded Output**  
Clear visual feedback with intuitive color-coded messages

**Project Information**  
View detailed information about your projects instantly

**Safety Features**  
Confirmation prompts for destructive operations

**Error Handling**  
Comprehensive validation and helpful error messages

<br>

## Installation

### Prerequisites

- Unity Editor installed on your system
- Bash shell (Linux, macOS, or WSL on Windows)
- Basic command-line knowledge

### Setup

**1. Download the script**

```bash
git clone https://github.com/yourusername/unity-cli-manager.git
cd unity-cli-manager
```

**2. Make the script executable**

```bash
chmod +x unity-cli.sh
```

**3. Configure paths**

Edit `unity-cli.sh` and update the following if needed:

```bash
UNITY_PATH="$HOME/Flow/Unity/Editor/Unity"      # Path to Unity Editor
PROJECTS_DIR="$HOME/MyProjects"                 # Projects directory
```

**4. Create an alias**

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
alias unity='/path/to/unity-cli.sh'
```

Then reload your shell:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

<br>

## Usage

### Basic Syntax

```bash
unity <command> [options]
```

<br>

## Commands Reference

### Create New Project

Create a new Unity project with a specified template.

```bash
unity new <ProjectName> <2d|3d>
```

**Examples**

```bash
unity new MyGame 3d          # Create a 3D project
unity new Platformer 2d      # Create a 2D project
```

> **Note:** Project names cannot contain spaces. Use camelCase or underscores instead.

---

### Open Project

Open an existing Unity project in the Unity Editor.

```bash
unity open <ProjectName>
```

**Examples**

```bash
unity open MyGame           # Open MyGame project
unity open Platformer       # Open Platformer project
```

---

### Build Project

Build a Unity project for a target platform.

```bash
unity build <ProjectName> [platform]
```

**Supported Platforms**

| Platform | Aliases | Description |
|----------|---------|-------------|
| `linux64` | `linux` | Linux 64-bit (default) |
| `windows` | `win64` | Windows 64-bit |
| `mac` | `osx` | macOS |
| `android` | - | Android APK |
| `ios` | - | iOS (requires macOS + Xcode) |

**Examples**

```bash
unity build MyGame              # Build for Linux (default)
unity build MyGame windows      # Build for Windows
unity build Platformer android  # Build for Android
```

> **Note:** Builds are saved in `ProjectName/Builds/Platform/`

---

### List Projects

Display all Unity projects in your projects directory.

```bash
unity list
```

**Alias:** `unity ls`

---

### Project Information

View detailed information about a specific project.

```bash
unity info <ProjectName>
```

**Example Output**

```
Project Information:
  Name: MyGame
  Path: /home/user/MyProjects/MyGame
  Unity Version: 2023.2.0f1
  Size: 1.2G
```

---

### Delete Project

Permanently delete a Unity project.

```bash
unity delete <ProjectName>
```

**Alias:** `unity rm`

> **Warning:** This action is irreversible. The entire project directory will be removed.

---

### Version Information

Display Unity CLI Manager version and configuration.

```bash
unity version
```

**Aliases:** `unity --version`, `unity -v`

---

### Help

Display comprehensive help information.

```bash
unity help
```

**Aliases:** `unity --help`, `unity -h`

<br>

## Workflow Examples

### Starting a New 3D Game

```bash
# Create new 3D project
unity new AwesomeGame 3d

# Open it for development
unity open AwesomeGame

# Build for testing
unity build AwesomeGame linux64

# Build for distribution
unity build AwesomeGame windows
unity build AwesomeGame mac
```

### Managing Multiple Projects

```bash
# List all projects
unity list

# Check project details
unity info MyGame

# Delete old projects
unity delete OldPrototype
```

### Cross-Platform Development

```bash
# Create project
unity new CrossPlatformGame 2d

# Build for multiple platforms
unity build CrossPlatformGame linux64
unity build CrossPlatformGame windows
unity build CrossPlatformGame android
```

<br>

## Configuration

### Custom Paths

Edit the script to customize paths for your environment:

```bash
# Path to Unity Editor executable
UNITY_PATH="$HOME/Flow/Unity/Editor/Unity"

# Projects directory
PROJECTS_DIR="$HOME/MyProjects"
```

### Multiple Unity Versions

To manage multiple Unity versions, create separate scripts or modify the `UNITY_PATH` variable based on your needs.

<br>

## Troubleshooting

**Unity Editor Not Found**

```
Error: Unity Editor not found at: /path/to/Unity
```

*Solutions:*
- Verify Unity is installed at the specified path
- Update `UNITY_PATH` in the script to match your Unity installation
- Check file permissions

**Project Creation Fails**

```
Error: Failed to create project
```

*Solutions:*
- Ensure you have write permissions in the projects directory
- Check available disk space
- Verify Unity Editor is properly installed
- Try creating a project manually to test Unity installation

**Build Fails**

```
Error: Build command completes but no build is created
```

*Solutions:*
- Check Unity logs in `~/Unity/Editor.log`
- Ensure target platform modules are installed in Unity Hub
- For Android/iOS, verify SDK installation
- Check project for compilation errors

<br>

## Tips and Best Practices

**Use Descriptive Names**  
Choose clear, descriptive project names for better organization

**Regular Backups**  
Keep backups of important projects to prevent data loss

**Version Control**  
Use Git for project versioning with a Unity-specific `.gitignore`

**Clean Builds**  
Delete old builds periodically to save disk space

**Project Organization**  
Use consistent naming conventions across all projects

**Check Before Delete**  
Always verify project name before deletion—it's irreversible

**Build Incrementally**  
Test builds on your platform before building for others

<br>

## Requirements

- Unity Editor (any recent version)
- Bash 4.0 or later
- Sufficient disk space for projects and builds
- Platform-specific SDKs for non-native builds

<br>

## Limitations

- Android builds require Android SDK installation
- iOS builds require macOS with Xcode
- WebGL builds not currently supported (can be added)
- Assumes standard Unity project structure

<br>

## Contributing

Suggestions and improvements are welcome. Consider adding:

- WebGL build support
- Custom build configurations
- Unity version switching
- Project templates management
- Batch operations
- Project archiving

<br>

## License

This tool is provided as-is for personal and commercial use.

<br>

## Support

**Unity CLI Manager**  
Check script configuration and permissions

**Unity Editor**  
Consult Unity documentation

**Platform SDKs**  
Refer to platform-specific documentation

<br>

## Version History

**v1.0** — Initial release
- Core project management features
- Multi-platform build support
- Color-coded terminal output
- Comprehensive error handling

<br>
<br>

<div align="center">

**Made for developers who prefer the command line**

[⬆ Back to Top](#unity-cli-manager)

</div>
