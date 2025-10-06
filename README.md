<div align="center">

![Unity CLI Manager](./assets/banner.png)

<h1>Unity CLI Manager</h1>

<p>A command-line interface for managing Unity projects efficiently from the terminal</p>

[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/yourusername/unity-cli-manager)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Windows-lightgrey.svg)](https://github.com/yourusername/unity-cli-manager)

</div>

<br>

## Overview

Unity CLI Manager streamlines Unity project workflows by providing a simple command-line interface. Create, open, build, and manage Unity projects without leaving your terminal.

<br>

## Features

- **Project Management** - Create, open, list, and delete Unity projects
- **Multi-Platform Builds** - Build for Linux, Windows, and macOS
- **Project Templates** - Support for both 2D and 3D project templates
- **Color-Coded Output** - Clear visual feedback with color-coded messages
- **Project Information** - View detailed information about your projects
- **Safety Features** - Confirmation prompts for destructive operations

<br>

## Installation

### Prerequisites

- Unity Editor installed on your system
- Bash shell (Linux, macOS, or WSL on Windows)

### Setup

**1. Clone the repository**

```bash
git clone https://github.com/yourusername/unity-cli-manager.git
cd unity-cli-manager
```

**2. Make the script executable**

```bash
chmod +x unity-cli.sh
```

**3. Configure paths**

Edit `unity-cli.sh` and update:

```bash
UNITY_PATH="$HOME/Flow/Unity/Editor/Unity"      # Path to Unity Editor
PROJECTS_DIR="$HOME/MyProjects"                 # Projects directory
```

**4. Create an alias**

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
alias unity='/path/to/unity-cli.sh'
```

Reload your shell:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

<br>

## Usage

```bash
unity <command> [options]
```

<br>

## Commands

### `new` - Create Project

```bash
unity new <ProjectName> <2d|3d>
```

**Examples**
```bash
unity new MyGame 3d
unity new Platformer 2d
```

---

### `open` - Open Project

```bash
unity open <ProjectName>
```

---

### `build` - Build Project

```bash
unity build <ProjectName> [platform]
```

**Platforms:** `linux64` (default) | `windows` | `mac`

**Examples**
```bash
unity build MyGame              # Linux
unity build MyGame windows      # Windows
unity build MyGame mac          # macOS
```

Builds are saved in `ProjectName/Builds/Platform/`

---

### `list` - List Projects

```bash
unity list
```

---

### `info` - Project Information

```bash
unity info <ProjectName>
```

---

### `delete` - Delete Project

```bash
unity delete <ProjectName>
```

> **Warning:** This action is irreversible.

---

### `version` - Version Information

```bash
unity version
```

---

### `help` - Help

```bash
unity help
```

<br>

## Examples

### New Project Workflow

```bash
unity new AwesomeGame 3d
unity open AwesomeGame
unity build AwesomeGame
```

### Multi-Platform Build

```bash
unity new CrossPlatform 2d
unity build CrossPlatform linux64
unity build CrossPlatform windows
unity build CrossPlatform mac
```

### Project Management

```bash
unity list
unity info MyGame
unity delete OldProject
```

<br>

## Configuration

Edit `unity-cli.sh` to customize:

```bash
UNITY_PATH="$HOME/Flow/Unity/Editor/Unity"
PROJECTS_DIR="$HOME/MyProjects"
```

<br>

## Troubleshooting

> If Unity Editor is not found, verify the `UNITY_PATH` in the script matches your Unity installation. For build issues, check Unity logs at `~/Unity/Editor.log` and ensure platform modules are installed via Unity Hub.

<br>

## Requirements

- Unity Editor (any recent version)
- Bash 4.0 or later
- Sufficient disk space

<br>

## Contributing

Contributions welcome. Potential features: WebGL support, custom build configurations, Unity version switching, project templates management.

<br>

## Version History

**v1.0** - Initial release

<br>
<br>

<div align="center">

**Made for developers who prefer the command line**

[⬆ Back to Top](#unity-cli-manager)

</div>
