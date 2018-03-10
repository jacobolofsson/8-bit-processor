# 8-bit microprocessor in VHDL
This is a project for a course in Digital Electronics Design with VHDL for my university programme.
The project is divided into a memory and a processor at top level. The processor is further divided into:
* A control unit
* An ALU
* 2 adress registers
* A loop counter

All operations are made during two clock cycles, one "fetch" and one "execute" cycle.

This design was made and tested using the Quartus II software with Altera cyclone II as target architecture but should work with other compilers and targets.
