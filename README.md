# Unity CLI Manager

A command-line interface for managing Unity projects efficiently from the terminal.

## Overview

Unity CLI Manager streamlines Unity project workflows by providing a simple, powerful command-line interface. Create, open, build, and manage Unity projects without leaving your terminal.

## Features

- **Project Management**: Create, open, list, and delete Unity projects
- **Multi-Platform Builds**: Build for Linux, Windows, macOS, Android, and iOS
- **Project Templates**: Support for both 2D and 3D project templates
- **Color-Coded Output**: Clear visual feedback with color-coded messages
- **Project Information**: View detailed information about your projects
- **Safety Features**: Confirmation prompts for destructive operations
- **Error Handling**: Comprehensive validation and helpful error messages

## Installation

### Prerequisites

- Unity Editor installed on your system
- Bash shell (Linux, macOS, or WSL on Windows)
- Basic command-line knowledge

### Setup

1. Download the `unity-cli.sh` script to your system

2. Make the script executable:
```bash
chmod +x unity-cli.sh
```

3. Configure the paths in the script (if different from defaults):
   - `UNITY_PATH`: Path to Unity Editor executable (default: `~/Flow/Unity/Editor/Unity`)
   - `PROJECTS_DIR`: Directory for Unity projects (default: `~/MyProjects`)

4. Create an alias for easy access (add to `~/.bashrc` or `~/.zshrc`):
```bash
alias unity='/path/to/unity-cli.sh'
```

5. Reload your shell configuration:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

## Usage

### Basic Syntax

```bash
unity <command> [options]
```

### Commands

#### Create New Project

Create a new Unity project with a specified template.

```bash
unity new <ProjectName> <2d|3d>
```

**Examples:**
```bash
unity new MyGame 3d          # Create a 3D project
unity new Platformer 2d      # Create a 2D project
unity new RPGGame 3d         # Create another 3D project
```

**Notes:**
- Project name cannot contain spaces (use camelCase or underscores)
- Default template is 3D if not specified
- Project will be created in `~/MyProjects/ProjectName`

#### Open Project

Open an existing Unity project in the Unity Editor.

```bash
unity open <ProjectName>
```

**Examples:**
```bash
unity open MyGame           # Open MyGame project
unity open Platformer       # Open Platformer project
```

**Notes:**
- Unity Editor will launch in the background
- If project doesn't exist, available projects will be listed

#### Build Project

Build a Unity project for a target platform.

```bash
unity build <ProjectName> [platform]
```

**Supported Platforms:**
- `linux64` or `linux` - Linux 64-bit (default)
- `windows` or `win64` - Windows 64-bit
- `mac` or `osx` - macOS
- `android` - Android APK
- `ios` - iOS (requires macOS with Xcode)

**Examples:**
```bash
unity build MyGame              # Build for Linux (default)
unity build MyGame windows      # Build for Windows
unity build MyGame mac          # Build for macOS
unity build Platformer android  # Build for Android
```

**Notes:**
- Builds are saved in `ProjectName/Builds/Platform/`
- Build process runs in batch mode (headless)
- Android and iOS builds require additional SDK configuration

#### List Projects

Display all Unity projects in your projects directory.

```bash
unity list
```

**Alias:** `unity ls`

**Example Output:**
```
Unity Projects:
  - MyGame
  - Platformer
  - RPGGame
```

#### Project Information

View detailed information about a specific project.

```bash
unity info <ProjectName>
```

**Example:**
```bash
unity info MyGame
```

**Example Output:**
```
Project Information:
  Name: MyGame
  Path: /home/user/MyProjects/MyGame
  Unity Version: 2023.2.0f1
  Size: 1.2G
```

#### Delete Project

Permanently delete a Unity project.

```bash
unity delete <ProjectName>
```

**Alias:** `unity rm`

**Example:**
```bash
unity delete OldProject
```

**Notes:**
- Requires confirmation before deletion
- This action is irreversible
- Entire project directory will be removed

#### Version Information

Display Unity CLI Manager version and configuration.

```bash
unity version
```

**Aliases:** `unity --version`, `unity -v`

**Example Output:**
```
Unity CLI Manager v1.0

Configuration:
  Unity Path: /home/user/Flow/Unity/Editor/Unity
  Projects Directory: /home/user/MyProjects

Unity Editor found
```

#### Help

Display comprehensive help information.

```bash
unity help
```

**Aliases:** `unity --help`, `unity -h`

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

## Troubleshooting

### Unity Editor Not Found

**Error:** `Unity Editor not found at: /path/to/Unity`

**Solution:** 
- Verify Unity is installed at the specified path
- Update `UNITY_PATH` in the script to match your Unity installation
- Check file permissions

### Project Creation Fails

**Error:** `Failed to create project`

**Solution:**
- Ensure you have write permissions in the projects directory
- Check available disk space
- Verify Unity Editor is properly installed
- Try creating project manually to test Unity installation

### Build Fails

**Error:** Build command completes but no build is created

**Solution:**
- Check Unity logs in `~/Unity/Editor.log`
- Ensure target platform modules are installed in Unity Hub
- For Android/iOS, verify SDK installation
- Check project for compilation errors

## Tips and Best Practices

1. **Use Descriptive Names**: Choose clear, descriptive project names
2. **Regular Backups**: Keep backups of important projects
3. **Version Control**: Use Git for project versioning (add Unity .gitignore)
4. **Clean Builds**: Delete old builds periodically to save disk space
5. **Project Organization**: Use consistent naming conventions
6. **Check Before Delete**: Always verify project name before deletion
7. **Build Incrementally**: Test builds on your platform before building for others

## Requirements

- Unity Editor (any recent version)
- Bash 4.0 or later
- Sufficient disk space for projects and builds
- Platform-specific SDKs for non-native builds

## Limitations

- Android builds require Android SDK installation
- iOS builds require macOS with Xcode
- WebGL builds not currently supported (can be added)
- Assumes standard Unity project structure

## Contributing

Suggestions and improvements are welcome. Consider adding:
- WebGL build support
- Custom build configurations
- Unity version switching
- Project templates management
- Batch operations
- Project archiving

## License

This tool is provided as-is for personal and commercial use.

## Support

For issues related to:
- **Unity CLI Manager**: Check script configuration and permissions
- **Unity Editor**: Consult Unity documentation
- **Platform SDKs**: Refer to platform-specific documentation

## Version History

**v1.0** - Initial release
- Core project management features
- Multi-platform build support
- Color-coded terminal output
- Comprehensive error handling

---

Made for developers who prefer the command line.
