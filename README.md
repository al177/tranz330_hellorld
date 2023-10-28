# tranz330_hellorld
Minimal code to write "Hellorld" to the VFD

## Prereqs
* Be a Linux user
* Build zasm: https://github.com/Megatokio/zasm
* If flashing from here, install minipro CLI: https://gitlab.com/DavidGriffith/minipro/

## Building

* export ZASM_PATH=/path/to/zasm/tree
* make

## Programming and using
* Make sure Makefile "ROM_IC" is the right type for your EPROM or flash
* If using an EPROM, "make burn", and if using flash, "make flash"
* fun time

