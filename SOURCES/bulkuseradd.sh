#!/bin/bash

# bulkuseradd.sh - A professional, cross-platform script to add multiple users in bulk.
# This script allows you to add bulk users from the command line or from a file,
# assign groups, set passwords, set UID ranges, etc.

# Default values
DEFAULT_SHELL="/bin/bash"
DEFAULT_PASSWORD="Password123"
LOG_FILE=""
USER_SPECIFIED_UID=0  # 0 = auto-detect, 1 = user-provided

# Help message function
usage() {
    cat << EOF
Usage: bulkuseradd [OPTIONS] [USERNAMES...]
       bulkuseradd -f FILE [OPTIONS]

This script adds users to the system in bulk.

Options:
  -f FILE            Input file containing usernames (one per line)
  -G GROUP           Assign users to a specific group (default: user's own group)
  -u START_UID       Start UID for the first user (default: system behavior)
  -s SHELL           Specify the shell for the users (default: /bin/bash)
  -p PASSWORD        Set a password for the users (default: Password123)
  -l, --log          Enable logging of user creation (default: /var/log/bulkuseradd.log)
  -h, --help         Display this help message and exit
EOF
}

# Log function
log_message() {
    if [ -n "$LOG_FILE" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
    fi
}

# Validate user
validate_user() {
    if id "$1" &>/dev/null; then
        echo "User '$1' already exists, skipping..."
        log_message "User '$1' already exists, skipping."
        return 1
    fi
    return 0
}

# Find next available UID (if needed)
get_next_uid() {
    local last_uid=$(getent passwd | awk -F: '$3 >= 1000 && $3 < 60000 {print $3}' | sort -n | tail -n1)
    echo $((last_uid + 1))
}

# Parse command-line arguments
USERS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -f)
            if [ -z "$2" ]; then
                echo "Error: Option '-f' requires a file argument."
                usage
                exit 1
            fi
            FILE=$2
            shift 2
            ;;
        -G)
            if [ -z "$2" ]; then
                echo "Error: Option '-G' requires a group name argument."
                usage
                exit 1
            fi
            GROUP=$2
            shift 2
            ;;
        -u)
            if [ -z "$2" ]; then
                echo "Error: Option '-u' requires a UID argument."
                usage
                exit 1
            fi
            START_UID=$2
            USER_SPECIFIED_UID=1
            shift 2
            ;;
        -s)
            if [ -z "$2" ]; then
                echo "Error: Option '-s' requires a shell argument."
                usage
                exit 1
            fi
            SHELL=$2
            shift 2
            ;;
        -p)
            if [ -z "$2" ]; then
                echo "Error: Option '-p' requires a password argument."
                usage
                exit 1
            fi
            PASSWORD=$2
            shift 2
            ;;
        -l|--log)
            LOG_FILE="/var/log/bulkuseradd.log"
            shift
            ;;
        *)
            USERS+=("$1")
            shift
            ;;
    esac
done

# Validate input sources
if [ ${#USERS[@]} -eq 0 ] && [ -z "$FILE" ]; then
    echo "Error: No users provided. Use -f FILE or specify usernames."
    usage
    exit 1
fi

# Read from file if specified
if [ -n "$FILE" ]; then
    if [ ! -f "$FILE" ]; then
        echo "Error: File '$FILE' not found."
        exit 1
    fi
    while IFS= read -r USER; do
        USERS+=("$USER")
    done < "$FILE"
fi

# Set defaults
SHELL=${SHELL:-$DEFAULT_SHELL}
PASSWORD=${PASSWORD:-$DEFAULT_PASSWORD}

# Create users with system's default UID handling
for USER in "${USERS[@]}"; do
    validate_user "$USER" || continue

    # Resolve UID if needed
    if [ "$USER_SPECIFIED_UID" -eq 1 ]; then
        NEW_UID=$(get_next_uid)
    else
        NEW_UID=""
    fi

    # Create user with or without UID and group
    if [[ -n "$GROUP" ]]; then
        useradd -m -s "$SHELL" -u "$NEW_UID" -G "$GROUP" "$USER"
    else
        useradd -m -s "$SHELL" "$USER"
    fi
    
    if [ $? -eq 0 ]; then
        echo "User '$USER' added successfully."
        echo "$USER:$PASSWORD" | chpasswd
        log_message "User '$USER' added successfully."
    else
        echo "Error: Failed to add user '$USER'."
        log_message "Error: Failed to add user '$USER'."
    fi
done

echo "Bulk user creation process completed."

