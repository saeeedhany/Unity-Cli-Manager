#!/bin/bash

# Unity CLI Manager
# A command-line interface for managing Unity projects

set -e

# Configuration
UNITY_PATH="$HOME/Flow/Unity/Editor/Unity"
PROJECTS_DIR="$HOME/MyProjects"
CONFIG_FILE="$HOME/.unity-cli.conf"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Utility functions
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_info() {
    echo -e "${BLUE}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

# Check if Unity exists
check_unity() {
    if [ ! -f "$UNITY_PATH" ]; then
        print_error "Unity Editor not found at: $UNITY_PATH"
        exit 1
    fi
}

# Ensure projects directory exists
ensure_projects_dir() {
    if [ ! -d "$PROJECTS_DIR" ]; then
        mkdir -p "$PROJECTS_DIR"
        print_info "Created projects directory: $PROJECTS_DIR"
    fi
}

# Create a new Unity project
unity_new() {
    local PROJECT_NAME=$1
    local TEMPLATE=$2
    local PROJECT_PATH="$PROJECTS_DIR/$PROJECT_NAME"

    if [ -z "$PROJECT_NAME" ]; then
        print_error "Project name is required"
        echo "Usage: unity new <ProjectName> <2d|3d>"
        exit 1
    fi

    if [ -z "$TEMPLATE" ]; then
        TEMPLATE="3d"
    fi

    # Normalize template name
    case "${TEMPLATE,,}" in
        2d)
            TEMPLATE_ARG="com.unity.template.2d"
            ;;
        3d)
            TEMPLATE_ARG="com.unity.template.3d"
            ;;
        *)
            print_error "Invalid template: $TEMPLATE. Use '2d' or '3d'"
            exit 1
            ;;
    esac

    if [ -d "$PROJECT_PATH" ]; then
        print_error "Project '$PROJECT_NAME' already exists at: $PROJECT_PATH"
        exit 1
    fi

    print_info "Creating new ${TEMPLATE} project: $PROJECT_NAME"
    print_info "Location: $PROJECT_PATH"
    
    "$UNITY_PATH" -createProject "$PROJECT_PATH" -projectTemplate "$TEMPLATE_ARG" -quit -batchmode

    if [ -d "$PROJECT_PATH" ]; then
        print_success "Project '$PROJECT_NAME' created successfully"
    else
        print_error "Failed to create project"
        exit 1
    fi
}

# Open an existing Unity project
unity_open() {
    local PROJECT_NAME=$1
    local PROJECT_PATH="$PROJECTS_DIR/$PROJECT_NAME"

    if [ -z "$PROJECT_NAME" ]; then
        print_error "Project name is required"
        echo "Usage: unity open <ProjectName>"
        exit 1
    fi

    if [ ! -d "$PROJECT_PATH" ]; then
        print_error "Project '$PROJECT_NAME' not found"
        print_info "Available projects:"
        unity_list
        exit 1
    fi

    print_info "Opening project: $PROJECT_NAME"
    "$UNITY_PATH" -projectPath "$PROJECT_PATH" &
    print_success "Unity Editor launched"
}

# Build an existing Unity project
unity_build() {
    local PROJECT_NAME=$1
    local BUILD_TARGET=$2
    local PROJECT_PATH="$PROJECTS_DIR/$PROJECT_NAME"

    if [ -z "$PROJECT_NAME" ]; then
        print_error "Project name is required"
        echo "Usage: unity build <ProjectName> [linux64|windows|mac|android|ios]"
        exit 1
    fi

    if [ ! -d "$PROJECT_PATH" ]; then
        print_error "Project '$PROJECT_NAME' not found"
        exit 1
    fi

    # Default to Linux 64-bit
    if [ -z "$BUILD_TARGET" ]; then
        BUILD_TARGET="linux64"
    fi

    local BUILD_DIR="$PROJECT_PATH/Builds"
    mkdir -p "$BUILD_DIR"

    print_info "Building project: $PROJECT_NAME"
    print_info "Target platform: $BUILD_TARGET"

    case "${BUILD_TARGET,,}" in
        linux64|linux)
            BUILD_PATH="$BUILD_DIR/Linux/${PROJECT_NAME}.x86_64"
            "$UNITY_PATH" -projectPath "$PROJECT_PATH" -buildLinux64Player "$BUILD_PATH" -quit -batchmode -nographics
            ;;
        windows|win64)
            BUILD_PATH="$BUILD_DIR/Windows/${PROJECT_NAME}.exe"
            "$UNITY_PATH" -projectPath "$PROJECT_PATH" -buildWindows64Player "$BUILD_PATH" -quit -batchmode -nographics
            ;;
        mac|osx)
            BUILD_PATH="$BUILD_DIR/Mac/${PROJECT_NAME}.app"
            "$UNITY_PATH" -projectPath "$PROJECT_PATH" -buildOSXPlayer "$BUILD_PATH" -quit -batchmode -nographics
            ;;
        android)
            BUILD_PATH="$BUILD_DIR/Android/${PROJECT_NAME}.apk"
            "$UNITY_PATH" -projectPath "$PROJECT_PATH" -buildTarget Android -quit -batchmode -nographics
            print_warning "Android build requires additional SDK setup"
            ;;
        ios)
            BUILD_PATH="$BUILD_DIR/iOS"
            "$UNITY_PATH" -projectPath "$PROJECT_PATH" -buildTarget iOS -quit -batchmode -nographics
            print_warning "iOS build requires Mac with Xcode"
            ;;
        *)
            print_error "Invalid build target: $BUILD_TARGET"
            echo "Supported targets: linux64, windows, mac, android, ios"
            exit 1
            ;;
    esac

    print_success "Build completed successfully"
    print_info "Build location: $BUILD_PATH"
}

# List all Unity projects
unity_list() {
    if [ ! -d "$PROJECTS_DIR" ]; then
        print_warning "No projects directory found"
        return
    fi

    local PROJECTS=($(find "$PROJECTS_DIR" -maxdepth 1 -type d -not -path "$PROJECTS_DIR" -exec basename {} \;))

    if [ ${#PROJECTS[@]} -eq 0 ]; then
        print_info "No projects found in: $PROJECTS_DIR"
        return
    fi

    echo "Unity Projects:"
    for project in "${PROJECTS[@]}"; do
        echo "  - $project"
    done
}

# Delete a Unity project
unity_delete() {
    local PROJECT_NAME=$1
    local PROJECT_PATH="$PROJECTS_DIR/$PROJECT_NAME"

    if [ -z "$PROJECT_NAME" ]; then
        print_error "Project name is required"
        echo "Usage: unity delete <ProjectName>"
        exit 1
    fi

    if [ ! -d "$PROJECT_PATH" ]; then
        print_error "Project '$PROJECT_NAME' not found"
        exit 1
    fi

    read -p "Are you sure you want to delete '$PROJECT_NAME'? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Deletion cancelled"
        exit 0
    fi

    rm -rf "$PROJECT_PATH"
    print_success "Project '$PROJECT_NAME' deleted successfully"
}

# Get project information
unity_info() {
    local PROJECT_NAME=$1
    local PROJECT_PATH="$PROJECTS_DIR/$PROJECT_NAME"

    if [ -z "$PROJECT_NAME" ]; then
        print_error "Project name is required"
        echo "Usage: unity info <ProjectName>"
        exit 1
    fi

    if [ ! -d "$PROJECT_PATH" ]; then
        print_error "Project '$PROJECT_NAME' not found"
        exit 1
    fi

    echo "Project Information:"
    echo "  Name: $PROJECT_NAME"
    echo "  Path: $PROJECT_PATH"
    
    if [ -f "$PROJECT_PATH/ProjectSettings/ProjectVersion.txt" ]; then
        echo "  Unity Version: $(grep 'm_EditorVersion:' "$PROJECT_PATH/ProjectSettings/ProjectVersion.txt" | cut -d':' -f2 | xargs)"
    fi

    local SIZE=$(du -sh "$PROJECT_PATH" 2>/dev/null | cut -f1)
    echo "  Size: $SIZE"
}

# Show version and configuration
unity_version() {
    check_unity
    print_info "Unity CLI Manager v1.0"
    echo ""
    echo "Configuration:"
    echo "  Unity Path: $UNITY_PATH"
    echo "  Projects Directory: $PROJECTS_DIR"
    echo ""
    
    if [ -f "$UNITY_PATH" ]; then
        print_success "Unity Editor found"
    else
        print_error "Unity Editor not found"
    fi
}

# Display help
unity_help() {
    cat << EOF
Unity CLI Manager - Command-line interface for Unity projects

Usage:
  unity <command> [options]

Commands:
  new <ProjectName> <2d|3d>      Create a new Unity project
  open <ProjectName>              Open an existing project
  build <ProjectName> [platform]  Build a project (platforms: linux64, windows, mac, android, ios)
  list                            List all projects
  info <ProjectName>              Show project information
  delete <ProjectName>            Delete a project
  version                         Show Unity CLI version and configuration
  help                            Show this help message

Examples:
  unity new MyGame 3d             Create a new 3D project named MyGame
  unity new MyGame2D 2d           Create a new 2D project named MyGame2D
  unity open MyGame               Open the MyGame project
  unity build MyGame              Build MyGame for Linux 64-bit
  unity build MyGame windows      Build MyGame for Windows
  unity list                      List all projects
  unity info MyGame               Show information about MyGame
  unity delete MyGame             Delete MyGame project

EOF
}

# Main entry point
main() {
    check_unity
    ensure_projects_dir

    if [ $# -eq 0 ]; then
        unity_help
        exit 0
    fi

    case "$1" in
        new)
            unity_new "$2" "$3"
            ;;
        open)
            unity_open "$2"
            ;;
        build)
            unity_build "$2" "$3"
            ;;
        list|ls)
            unity_list
            ;;
        info)
            unity_info "$2"
            ;;
        delete|rm)
            unity_delete "$2"
            ;;
        version|--version|-v)
            unity_version
            ;;
        help|--help|-h)
            unity_help
            ;;
        *)
            print_error "Unknown command: $1"
            echo ""
            unity_help
            exit 1
            ;;
    esac
}

main "$@"
