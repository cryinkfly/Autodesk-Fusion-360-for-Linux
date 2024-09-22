#!/bin/bash

# Function to check if Secure Boot is activated
check_secure_boot() {
    if ! command -v mokutil &> /dev/null; then
        echo "emokutil command not found. Please install it to check Secure Boot status."
        exit 1
    fi

    # Check if Secure Boot is enabled
    if mokutil --sb-state | grep -q 'Secure Boot enabled'; then
        echo "Secure Boot is enabled."
    else
        echo "Secure Boot is not enabled."
    fi
}

# Call the function
check_secure_boot
