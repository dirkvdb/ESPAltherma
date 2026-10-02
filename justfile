build environment="m5stickc":
    secretspec run -- platformio run -e {{environment}}

ota environment="m5stickc":
    secretspec run -- platformio run -e {{environment}} -t upload --upload-port ESPAltherma.local

# Flash firmware over USB using the first udev-managed USB serial device.
flash environment="m5stickc-usb":
    test -n "$(find /dev/serial/by-id -type l -print -quit)" || { echo "No USB serial device found under /dev/serial/by-id" >&2; exit 1; }; secretspec run -- platformio run -e {{environment}} -t upload --upload-port "$(find /dev/serial/by-id -type l -print -quit)"
