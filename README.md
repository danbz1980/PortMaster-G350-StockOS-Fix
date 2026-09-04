# PortMaster G350 StockOS Fix

![PortMaster G350 StockOS Fix](assets/PortMaster-G350-StockOS-Fix-Social-Preview.jpg)

Verified hardware compatibility fix for the **BatleXP G350** running **StockOS**.

This project provides a minimal and reversible solution for PortMaster controller detection and restores the **SELECT + START** exit combination inside ports.

## Status

- Verified on real hardware
- BatleXP G350
- RK3326
- StockOS
- Two analog sticks
- SDL 2.28.5
- SELECT + START exit combination verified

> This is a community-developed project. It does not constitute official PortMaster support unless and until the changes are reviewed and accepted by the PortMaster project.

## The Problem

In the tested BatleXP G350 configuration, PortMaster did not have a specific entry to correctly detect the console's controller.

As a result, the controller was not selected correctly by PortMaster's control configuration and the **SELECT + START** combination did not work to exit ports.

The G350 operating system itself correctly identifies the controller through Linux and SDL.

## Hardware Identification

The tested controller appears in Linux as:

    batlexp_joypad

Input devices:

    /dev/input/event2
    /dev/input/js0

The controller provides:

    4 axes
    17 buttons
    0 hats

The SDL version used during testing was:

    SDL 2.28.5

Verified SDL GUID:

    1900c510010000000300000011010000

## Verified SDL Mapping

The verified SDL mapping used by the G350 is:

    1900c510010000000300000011010000,batlexp_joypad,a:b0,b:b1,x:b2,y:b3,leftshoulder:b4,rightshoulder:b5,dpup:b8,dpdown:b9,dpleft:b10,dpright:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,back:b12,start:b13,crc:10c5,platform:Linux

The buttons used for the exit combination are:

    SELECT = b12
    START  = b13

## The Fix

The solution consists of two main changes.

### 1. BatleXP G350 Detection

`control.txt` detects the G350 using:

    /dev/input/by-path/platform-batlexp-joypad-event-joystick

and assigns the verified SDL GUID:

    1900c510010000000300000011010000

The configuration uses:

    param_device=g350
    ANALOGSTICKS=2
    LOWRES=N

### 2. Controller Mapping

`gamecontrollerdb.txt` includes the verified SDL mapping for the G350, including:

    back:b12
    start:b13

## Verification

The controller identification was checked using the SDL tools available directly on the G350.

The system detected:

    batlexp_joypad

with:

    4 axes
    17 buttons

and the GUID:

    1900c510010000000300000011010000

A specific `gptokeyb` test was then performed.

The test confirmed that:

    SELECT + START

correctly closed the target process.

## Installation

Download the package from the **Releases** section of this repository.

The package includes:

- Installer script
- Restoration script
- Backup of the modified files

Only the following PortMaster files are modified:

    control.txt
    gamecontrollerdb.txt

The following files do not need to be modified to apply this fix:

    kernel
    DTB
    gptokeyb
    gptokeyb2
    device_info.txt
    funcs.txt

## Restoration

If you experience any problem after installing the fix, run:

    restore.sh

to restore the previous PortMaster configuration.

## Compatibility

The fix has been verified on:

| Hardware | Status |
|---|---|
| BatleXP G350 | Verified |
| RK3326 | Verified |
| StockOS | Verified |
| Two analog sticks | Verified |
| SDL 2.28.5 | Verified |

### Important

Testing was performed on **one physical BatleXP G350 unit**.

Therefore, this project does not claim that every G350 hardware revision or every StockOS version uses exactly the same SDL GUID.

If your G350 reports a different GUID, please open an **Issue** and provide:

- StockOS version
- SDL version
- Controller name
- SDL GUID
- Number of axes and buttons
- Whether SELECT + START allows you to exit ports

## Version

### v0.3

First version verified on real hardware.

The installable package is available in **Releases**.

## Contributing

If you own a BatleXP G350 and can test this fix, your feedback is welcome.

Testing on additional units can help determine whether different hardware revisions use different controller GUIDs.

## Project Goal

The ultimate goal is to have **BatleXP G350** support integrated directly into PortMaster.

Until that happens, this repository provides a documented, reversible, and hardware-verified solution for affected users.

## License

See the `LICENSE` file.
