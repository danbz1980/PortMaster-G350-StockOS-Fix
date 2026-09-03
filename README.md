# PortMaster G350 StockOS Fix

Hardware-verified controller fix for the **BatleXP G350** running **StockOS**.

This project provides a minimal and reversible fix for PortMaster controller detection and the `SELECT + START` exit hotkey on the BatleXP G350.

## Status

✅ Tested on real hardware  
✅ BatleXP G350  
✅ RK3326  
✅ StockOS  
✅ Dual analog sticks  
✅ SDL 2.28.5  
✅ SELECT + START exit hotkey verified

> This is a community-developed fix. It is not official PortMaster support unless and until the changes are accepted upstream.

---

## The problem

On the tested BatleXP G350 configuration, PortMaster did not have a specific device-detection entry for the G350 controller.

As a result, the controller was not correctly selected by the PortMaster control configuration and the `SELECT + START` exit hotkey did not work inside ports.

The G350 itself correctly exposes its controller through Linux input and SDL.

---

## Hardware and SDL identification

The tested controller is identified by Linux as:

```text
batlexp_joypad
Input devices:
/dev/input/event2
/dev/input/js0
The controller exposes:
4 axes
17 buttons
0 hats
SDL version:
SDL 2.28.5
Verified SDL GUID:
1900c510010000000300000011010000
SDL mapping
The verified SDL mapping is:
1900c510010000000300000011010000,batlexp_joypad,a:b0,b:b1,x:b2,y:b3,leftshoulder:b4,rightshoulder:b5,dpup:b8,dpdown:b9,dpleft:b10,dpright:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,back:b12,start:b13,crc:10c5,platform:Linux
The important buttons for the PortMaster exit hotkey are:
SELECT = b12
START  = b13
Fix
The fix consists of two small changes:
1. BatleXP G350 detection
control.txt detects the G350 through:
/dev/input/by-path/platform-batlexp-joypad-event-joystick
and assigns the verified SDL GUID:
1900c510010000000300000011010000
The configuration uses:
param_device=g350
ANALOGSTICKS=2
LOWRES=N
2. SDL controller mapping
gamecontrollerdb.txt contains the verified G350 SDL mapping, including:
back:b12
start:b13
Verification
The controller identification was verified using the G350's native SDL tools.
The controller was detected as:
batlexp_joypad
with:
4 axes
17 buttons
and the verified GUID:
1900c510010000000300000011010000
The gptokeyb test subsequently confirmed that pressing:
SELECT + START
correctly closed the target process.
Installation
Download the latest release from the Releases section.
The release package contains an installer and a restoration script.
Before modifying PortMaster, the installer creates a backup of the files it changes.
Only these PortMaster files are modified:
control.txt
gamecontrollerdb.txt
No kernel, DTB, gptokeyb, gptokeyb2, device_info.txt or funcs.txt changes are required for this fix.
Restoration
If the fix causes any problem, use:
restore.sh
to restore the previous PortMaster configuration.
Compatibility
This fix has been verified on:
Hardware
Status
BatleXP G350
✅ Tested
RK3326
✅ Tested
StockOS
✅ Tested
Dual analog sticks
✅ Tested
SDL 2.28.5
✅ Tested
Important
Only one physical BatleXP G350 has been used for the hardware verification documented in this repository.
Therefore, this project does not claim that every G350 revision or StockOS image uses exactly the same SDL GUID.
If another G350 reports a different GUID, please open an issue and provide the SDL identification information.
Release
v0.3
Initial hardware-verified release.
See the Releases section for the ready-to-install package.
Contributing
If you own a BatleXP G350 and can test this fix, feedback is welcome.
Useful information includes:
StockOS version
SDL version
controller name
SDL GUID
number of axes/buttons
whether SELECT + START exits ports correctly
Please open an issue with the results.
Upstream
The long-term goal is to have BatleXP G350 support incorporated into PortMaster itself.
Until that happens, this repository provides a documented and reversible community fix for affected G350 users.
License
See LICENSE.
