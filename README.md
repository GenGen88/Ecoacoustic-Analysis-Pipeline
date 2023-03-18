# Ecoacoustics Analysis Pipeline

A pipeline to download, process, and analyze audio recordings in parallel, and watch results form in real time!

## Required Tools

- Python3
- R
- NodeJS
- NPM
- Git
- ffmpeg
- GNU/Linux Environment (tested on Ubuntu & OpenSuse)
- [EMU](https://github.com/QutEcoacoustics/emu)

### Install

Run the install script `./setup.sh`

### Usage

```sh
./run.sh <file_in_path> [flags]
```

**Optional Flags:**

- `--verbose` Print out extra information to the console
- `--noemu` Do not run emu to fix audio files before processing
- `--force` Keeps running through errors. This can be used to run an analysis without any files
- `--pipeline` Runs in a pipeline mode (downloads and processes data at the same time in a FIFO pipeline)
- `--destructive` Deletes files after they are processed
- `--retainmetadata` Retains metadata throughout entire process
- `--retainoriginal` Does not delete files in the pipeline
- `--eall` Errors and quits application if a corrupted audio file is encountered
- `--skipauto` By default, the analysis pipeline runs all analysis scripts located in `./src/analysis/scripts/auto/`. Use the `--skipauto` flag to skip running these analyses scripts
- `--allowduplicates` Allows for duplicate events in the `results.csv` output

#### Start Analysis Server

```sh
./start-server.sh
```
