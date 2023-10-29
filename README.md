# tranz330_hellorld
Minimal Z80 assembly to write `HELLORLD`<sup>*</sup> on the VFD of a Verifone Tranz 330 credit card terminal

The Tranz 330 is a Zilog Z80 based credit card terminal that uses standard Z80 peripherals and is [very hacker friendly](https://github.com/al177/tranz330_re). As of 2023 these are still plentiful and cheap on the used market.

![](/docs/tranz330_closed.jpg)
![](/docs/tranz330_open.jpg)

*<sup>\*</sup> not `Hellorld!` because the 14 segment VFD can't print exclamation points or lowercase*

## Prereqs
* Be a Linux user
* Have a Tranz 330, 27C256 EPROM or flash and means to program
* Build zasm: https://github.com/Megatokio/zasm
* If flashing from here, install minipro CLI: https://gitlab.com/DavidGriffith/minipro/

## Building

* export ZASM_PATH=/path/to/zasm/tree
* make

## Using
* Make sure Makefile "ROM_IC" is the right type for your EPROM or flash
* If using an EPROM, "make burn", and if using flash, "make flash"
* Install ROM
* Power it up
* `HELLORLD`

