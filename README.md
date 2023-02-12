# Realtime analysis of bird species, and the interaction with environment variables

## Objectives

- Analyze abundance of bird species over seasonal dates
- Display realtime analyses on a website

## Features

- chart bird species over time
- relate to seasonal data
- acoustic indices
- vegetation?

## Required Tools

- Python3
- R
- NodeJS
- NPM
- Git
- GNU/Linux Environment (tested on Ubuntu & OpenSuse)
- [EMU](https://github.com/QutEcoacoustics/emu)

### Install

Run the install script `./setup.sh`

### Fetch Data Columns

`./run.sh [file_path] [path] <flags>`

**Optional Flags:**

- `--verbose` Print out extra information to the console
- `--noemu` Do not run emu to fix audio files before processing
- `--force` Keeps running through errors
- `--pipeline` Runs in a pipeline mode (downloads and processes data at the same time in a FIFO pipeline)

---

**Potential Future Flags:**

- `--keepmetadata` Retains metadata throughout entire process
- `--keeporiginal` Does not delete files in the pipeline

### Visualize Data

Visualizing uses an Angular website that handles rendering the data, and fetching new data when it becomes available.
