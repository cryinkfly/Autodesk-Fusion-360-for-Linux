#!/bin/bash

check_secure_boot() {
    # Check if the system supports Secure Boot
    if [ ! -d "/sys/firmware/efi" ]; then
        echo "EFI firmware is not detected. Secure Boot is not supported."
        return 1
    fi

    # Check if the SecureBoot variable exists
    if [ -f "/sys/firmware/efi/efivars/SecureBoot-*" ]; then
        secure_boot_status=$(hexdump -v -e '/1 "%d"' /sys/firmware/efi/efivars/SecureBoot-*)
        if [ "$secure_boot_status" -eq 1 ]; then
            echo "Secure Boot is enabled."
            return 0
        else
            echo "Secure Boot is disabled."
            return 1
        fi
    else
        echo "Secure Boot variable not found. Secure Boot may not be supported."
        return 1
    fi
}

# Call the function to check Secure Boot status
check_secure_boot
