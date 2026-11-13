# ramses_esp 0.5.3-wdfix1

Based on branch `v0.5.3_test` (0.5.3-testc) with the fixes discussed in
IndaloTech/ramses_esp issues #48 / #50 and PR #44:

1. PR #44: arm GDO0 interrupt before priming the TX FIFO and queue a
   follow-up refill event if GDO0 is already low (missed-edge TX stall).
2. TX timeout (500 ms, `FRM_TX_TIMEOUT`): a stuck TX is aborted and the
   radio returns to RX (`# FRAME: TX timeout` on the console).
3. RX frame timeout (200 ms, `FRM_RX_TIMEOUT`): an RX frame that never
   completes is aborted instead of blocking the radio forever.
4. Bounded loops: TX prime loop and all CC1101 strobe/state loops have a limit
   (`# CC1101: state loop limit` / `# FRAME: TX prime loop limit`).
5. RX watchdog (`FRM_RX_WATCHDOG_MIN`, default 5): if no valid RF frame is
   received for 5 minutes the stick restarts itself.
6. `CONFIG_ESP_TASK_WDT_PANIC=y`: any other hang reboots instead of only
   printing backtraces.

## Build
    ./build.sh            # needs Docker

## Flash (USB)
Web: https://espressif.github.io/esptool-js/ -> Connect -> address 0x0 ->
`build/ramses_esp-0.5.3-wdfix1-merged.bin` -> Program (do NOT "Erase flash",
so Wi-Fi/MQTT settings in NVS are kept).

CLI: `esptool.py --chip esp32s3 write_flash 0x0 build/ramses_esp-0.5.3-wdfix1-merged.bin`
