# PortMaster G350 StockOS Fix

## BatleXP G350 / StockOS controller support

This package documents a controller-detection fix for **BatleXP G350** handhelds running **StockOS** and using PortMaster.

### What was verified on real hardware

- Device: BatleXP G350
- SoC: Rockchip RK3326
- Dual analog sticks
- Linux input device: `batlexp_joypad`
- Event device: `/dev/input/by-path/platform-batlexp-joypad-event-joystick`
- SDL GUID: `1900c510010000000300000011010000`
- SDL mapping: `batlexp_joypad`
- SELECT: SDL button `b12`
- START: SDL button `b13`
- **SELECT + START successfully terminated a test target through gptokeyb.**

The key problem was that the standard PortMaster `get_controls()` device-detection list did not include the G350 event-device path. Without that branch, the controller GUID was not selected for the temporary SDL database used by PortMaster.

PortMaster's current architecture uses `control.txt` to detect devices and select controller mappings; `gptokeyb` provides the standard force-quit mechanism.

## Fix

Two minimal changes are made:

1. Add a G350 branch to `control.txt` using the real event-device path and GUID.
2. Add the verified G350 SDL mapping to `gamecontrollerdb.txt`.

`device_info.txt`, `funcs.txt`, `gptokeyb`, `gptokeyb2`, kernel files and DTBs are **not required** for this fix.

## Installation

1. Back up the existing PortMaster `control.txt` and `gamecontrollerdb.txt`.
2. Copy the two modified files into the PortMaster directory.
3. Restart EmulationStation.
4. Launch a port and test **SELECT + START**.

For the ready-to-use package, run `install.sh`. It creates timestamped backups before replacing files. `restore.sh` restores the most recent backup made by the installer.

## Important

This is a hardware-verified community fix, not an official PortMaster release. It should be treated as a workaround until G350 support is accepted upstream.

## Technical evidence

The SDL test detected one `batlexp_joypad` with 4 axes and 17 buttons and reported the GUID above. The mapping was accepted by SDL 2.28.5. A separate gptokeyb test using the same mapping confirmed that SELECT+START closed the target successfully.

## Upstream

PortMaster documents `control.txt` device detection and `gamecontrollerdb.txt` mappings as part of its controller setup, and documents gptokeyb as the mechanism used for force-quitting ports. This package is intended to provide the exact G350 information needed for upstream support.

## License

See `LICENSE`. The modified PortMaster files remain under the licensing terms of their respective upstream projects.
