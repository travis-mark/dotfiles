# CLAUDE.md
This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview
This is a personal dotfiles repository containing miscellaneous scripts, utilities, and word lists. It's structured as a "junk drawer" collection of useful tools and customizations.

## Installation
- `make` or `make scripts` - Installs all scripts from `src/bin/` to `$(HOME)/bin` with executable permissions and removes file extensions

## Directory Layout
- `bin/` - Current collection of executable scripts
- `old/` - Legacy scripts and utilities (archived)
- `Makefile` - Simple build system for script installation

## Working with Scripts
- All scripts should be executable and include appropriate shebangs
- When adding new scripts, place them in `bin/` directory
- Run `make` to install after adding or modifying scripts
- Scripts should handle their own dependencies and provide usage information
- Python scripts should use `uv run --script` in their shebang
- Python scripts should list dependancies based on [PEP 723](https://peps.python.org/pep-0723/)