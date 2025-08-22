# CDP8 Audio Processing Toolkit - Nix Derivations

## **Disclaimer**

# **This project utilizes AI-assisted development with MCP Internet Grounding. Please note:**

- Repeated public code patterns may appear due to AI-assisted development
- **ALL** development involved continuous human supervision and intervention
- Final code was **human-reviewed and approved** by the derivation maintainer
- AI usage aims to **improve efficiency** - not to replace human expertise
- *Please* don't take AI usage as personal offense; it accelerates *my* development.

This project provides Nix expressions to build the CDP8 audio processing toolkit and its dependencies.

## Packages

### `libaaio` (v0.3.1)

- Lightweight Unix library providing Windows-style console I/O functions
- Non-blocking keyboard input without terminal initialization
- Maintains terminal state integrity
- **License**: BSD-style (see source headers)

### `cdp8` (v8.0)

- Comprehensive audio processing toolkit
- Requires libaaio as a dependency
- Builds with ALSA and JACK support via PortAudio
- **License**: LGPL 2.1

## Building

Build all packages:

```bash
nix build
```

Build specific package:

```bash
nix build .#libaaio
nix build .#cdp8
```

## Technical Details

- Uses pinned nixpkgs revision (32f313e)
- PortAudio configured with ALSA and JACK support
- Automatic patching of ELF dependencies
- CMake-based build system

## License

- CDP8: LGPL 2.1
- libaaio: Custom BSD-style
