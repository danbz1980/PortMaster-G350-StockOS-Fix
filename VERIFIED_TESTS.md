# Verified test record

The following results were obtained from tests performed on a real BatleXP G350 running StockOS.

## SDL identification

- SDL version reported: 2.28.5
- Joystick: `batlexp_joypad`
- Axes: 4
- Buttons: 17
- GUID: `1900c510010000000300000011010000`
- Verified mapping includes `leftx:a0,lefty:a1,rightx:a2,righty:a3` and the face/shoulder/D-pad mappings.

## Hotkey test

The gptokeyb test used the G350 mapping with SELECT=`b12` and START=`b13`. The recorded result was: **SELECT+START closed the target correctly**.

These tests establish that the G350's SDL identity/mapping and gptokeyb exit mechanism work. The PortMaster fix therefore targets the missing G350 detection/mapping selection rather than replacing gptokeyb.
