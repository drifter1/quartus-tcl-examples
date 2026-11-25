# quartus-tcl-examples

## Prerequisites

- [Quartus® Prime Lite Edition Design Software](https://www.altera.com/downloads/fpga-development-tools/quartus-prime-lite-edition-design-software-version-25-1-linux)
- [Ubuntu LTS Release](https://www.releases.ubuntu.com)

## Included Examples

- Binary to Gray code converter (**bin2gray**)
- Synchronous counter with reset and enable signals (**sync_counter**)

## Usage

### Building the project

```
make project
```

> [!NOTE]
> By default, the Makefile targets the **bin2gray** project and **5CSEBA6U23I7** device from the **Cyclone V** FPGA family.

### Cleanup of build files

```
make clean
```