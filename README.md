# Digital Logic Design and Verification

A collection of digital hardware design implementations using Verilog and SystemVerilog, with a focus on RTL development and simulation-based functional verification.

## Overview

This repository contains HDL source code and associated testbenches for digital logic design, modular hardware implementation, and simulation-based verification.

## Implementation

The project is organized into independent design modules, with source files and testbenches maintained separately where applicable.

## Tools and Technologies

- Verilog
- SystemVerilog
- RTL Design
- Cadence Xcelium
- Cadence SimVision
- Functional Simulation

## Running the Simulation

For designs using Cadence Xcelium, a typical command is:

```bash
xrun -sv mac_seq_b.sv tb_mac_seq_b.sv -l run_b.log
```

Replace the placeholders with the relevant filenames and any required simulator options.

## Simulation Results

Simulation outputs are included to demonstrate the functional behavior of the implemented designs.

### Output Waveforms

<img width="940" height="415" alt="image" src="https://github.com/user-attachments/assets/9dbf93d9-dfed-473f-ba61-2323f88f1a65" />


## Key Concepts

- Combinational and sequential logic
- Modular RTL development
- Testbench development
- Functional verification
- Waveform analysis and debugging

## License

See `LICENSE` for the applicable license terms.
