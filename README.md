# FPGA Snake Game 🎮

This project implements the classic **Snake game** on an FPGA board using **VHDL**.  


## Overview
The game is implemented on the **Nexys A7** development board featuring an **Artix-7 FPGA**.  
It combines VGA display, push-button inputs, and 7-segment displays to create a functional hardware-based game.

The architecture includes:
- A **finite state machine (FSM)** for movement and state control.  
- **VGA initialization** for screen drawing.  
- A **pseudo-random generator** for food placement.  
- **Frequency manager** for movement, display, and timer updates.  
- **7-segment drivers** for score and time display.  
- A **collision detection and scoring module**.

## Folder Structure
- `src/` — main VHDL source files  
- `simu/` — testbenches and simulation files  
- `docs/` — contains the architecture diagram of the system
- - `constraints/` — FPGA pin assignments file 

## Tools Used
- **Xilinx Vivado** for synthesis and simulation.
- **Nexys A7 FPGA board (Artix-7)** for hardware implementation  

## Constraints
The file `constraints/NexysA7.xdc` defines the mapping between FPGA pins and hardware components:
- VGA interface (R, G, B, HSYNC, VSYNC)  
- Push buttons for direction control  
- 7-segment display connections  
- Clock and reset inputs  
