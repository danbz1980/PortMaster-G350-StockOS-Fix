# PortMaster G350 StockOS Fix

## Soporte del mando de BatleXP G350 / StockOS

Este paquete documenta una corrección para el mando de la **BatleXP G350** con **StockOS** y PortMaster.

### Verificado en hardware real

- Dispositivo: BatleXP G350
- SoC: Rockchip RK3326
- Dos sticks analógicos
- Dispositivo Linux: `batlexp_joypad`
- Ruta de eventos: `/dev/input/by-path/platform-batlexp-joypad-event-joystick`
- GUID SDL real: `1900c510010000000300000011010000`
- SELECT: botón SDL `b12`
- START: botón SDL `b13`
- **SELECT + START cerró correctamente un proceso de prueba mediante gptokeyb.**

El problema era que `get_controls()` de PortMaster no incluía la ruta de detección específica de la G350. Por ello PortMaster no seleccionaba el GUID de la G350 para su base SDL temporal.

### Corrección

Se realizan solamente dos cambios:

1. Añadir la detección de la G350 en `control.txt`.
2. Añadir el mapeo SDL verificado en `gamecontrollerdb.txt`.

No es necesario modificar `device_info.txt`, `funcs.txt`, `gptokeyb`, `gptokeyb2`, kernel ni DTB.

### Instalación

1. Haz copia de seguridad de `control.txt` y `gamecontrollerdb.txt`.
2. Copia los dos archivos modificados a la carpeta de PortMaster.
3. Reinicia EmulationStation.
4. Ejecuta un port y prueba **SELECT + START**.

El `install.sh` incluido realiza automáticamente una copia de seguridad antes de sustituir los archivos. `restore.sh` permite volver al estado anterior.

### Estado

Es una corrección **probada en una G350 real**, pero todavía no debe considerarse soporte oficial de PortMaster.
