# Updating Shelly Firmware from Mongoose OS to ESPEasy

This guide is designed to help users of Shelly Plus and Pro ESP32 devices to update their devices from the Mongoose OS firmware to the ESPEasy firmware over the air (OTA).

## Prerequisites

1. Your Shelly device must have Mongoose OS firmware version 0.12.0 or higher installed.
2. You must have the mgos32-to-espeasy32 firmware http link for your device copied from the table below.

## Process

### Conversion

1. Connect your Shelly device to your local wifi or LAN with an internet connection.
2. Navigate to Settings > Device Settings > Firmware > Custom Firmware and paste the previously prepared http link. 
3. Click the **Upload Firmware** button.
4. Wait for the device to finish updating.
5. Once the update is finished, connect to the device's new ESPEasy wifi access point and add the device back to your network.
6. Now you can configure your device.

## Supported Devices and OTA Links

| **Device** | **Link** | **State** |
|------|------|------|
| **PlusHT** |   `TBD`   |   :warning:**untested**   |
| **PlusPlugS** |   `TBD`   |   :warning:**untested**   |
| **PlusPlugIT** |   `TBD`   |   :warning:**untested**   |
| **PlusPlugUS** |   `TBD`   |   :warning:**untested**   |
| **PlusPlugUK** |   `TBD`   |   :warning:**untested**   |
| **PlusI4** |   `TBD`   |   :warning:**untested**   |
| **PlusWallDimmer** |   `TBD`   |   :warning:**untested**   |
| **Plus1PM** |   `TBD`   |   :warning:**untested**   |
| **Plus1** |   `TBD`   |   :warning:**untested**   |
| **Plus2PM** |   `TBD`   |   :warning:**untested**   |
| **Pro1** |   `TBD`   |   :warning:**untested**   |
| **Pro1PM** |   `TBD`   |   :warning:**untested**   |
| **Pro2** |   `TBD`   |   :warning:**untested**   |
| **Pro2PM** |   `TBD`   |   :warning:**untested**   |
| **Pro3** |   `TBD`   |   :warning:**untested**   |
| **Pro4PM** |   `TBD`   |   :warning:**untested**   |

### If you confirmed an **untested** device working please open an issue!

## What if my device is not listed?

If your Shelly device is not listed in the templates, please open an issue with a link to the Shelly Knowledge Base.

Or buy the device from my [Amazon Wishlist](https://www.amazon.de/hz/wishlist/ls/2ZS2NBA6PPEDD) and I will reverse engineer and confirm the device working.

## Credits

I would like to thank [TD-er](https://github.com/TD-er) for providing help with the custom ESPEasy files.

## License

This repository is released under the GNU General Public License v3.0. Refer to the [LICENSE](LICENSE) file for more information. 

Copyright (C) 2023 Philipp '3D' ten Brink 
