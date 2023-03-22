# error codes
ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE = "expected calling parameter: $1 to equal a target date"
ERROR_404_MESSAGE = "Error 404, audio file not found..."
ERROR_INVALID_DATE_ERROR_MESSAGE = "invalid date found..."

# working directory constants
DIR_SOURCE = "./src/"
DIR_OUT_DIRECTORY = "./out/"
DIR_DATA_DIRECTORY = "./data/"
DIR_IN_DIRECTORY = "./in/"
DIR_PROCESSING_DIRECTORY = "./tmp/"

DIR_WEATHER_IN_FILE_PATH = f"{DIR_DATA_DIRECTORY}"

DIR_BIRDNET_OUT_FILE_PATH = f"{DIR_OUT_DIRECTORY}birdnet-results.csv"
DIR_WEATHER_OUT_FILE_PATH = f"{DIR_OUT_DIRECTORY}weather.csv"
DIR_REPORT_OUT_FILE_PATH = f"{DIR_OUT_DIRECTORY}report.csv"

PRE_PROCESSING_SCRIPT_PATH = f"{DIR_SOURCE}/preProcessing/runPreprocessing.sh"
CLEANUP_SCRIPT_PATH = f"{DIR_SOURCE}/environmentVariables/report/cleanupReport.sh"

# CLA argument positions
CLA_FILE_IN_POSITION = 1

VALID_AUDIO_FILE_EXTENSIONS = [".wav", ".mp3", ".flac"]

# misc
COLUMN_HEADERS = "Selection,View,Channel,BeginTime,EndTime,LowFreq,HighFreq,SpeciesCode,CommonName,Confidence,date,season,isWet\n"

# CLA arguments
PIPELINE_CLA_ARGUMENT = "--pipeline"
VERBOSE_CLA_ARGUMENT = "--verbose"
DESTRUCTIVE_CLA_ARGUMENT = "--destructive"
RETAIN_METADATA_CLA_ARGUMENT = "--retainmetadata"
RETAIN_ORIGINAL_CLA_ARGUMENT = "--retainoriginal"
ERROR_ALL_CLA_ARGUMENT = "--eall"
SKIP_AUTO_CLA_ARGUMENT = "--skipauto"
FORCE_CLA_ARGUMENT = "--force"
ALLOW_DUPLICATES_CLA_ARGUMENT = "--allowduplicates"
SKIP_PRE_PROCESSING_CLA_ARGUMENT = "--skippreprocessing"

CONSOLE_INIT_MESSAGE = """
Ecoacoustic-Analysis-Pipeline
\tBy: Hudson Newey & Genna Dias\n
\tLicensed under the Unlicense license.

\tThis is free and unencumbered software released into the public domain.

\tAnyone is free to copy, modify, publish, use, compile, sell, or
\tdistribute this software, either in source code form or as a compiled
\tbinary, for any purpose, commercial or non-commercial, and by any
\tmeans.

\tIn jurisdictions that recognize copyright laws, the author or authors
\tof this software dedicate any and all copyright interest in the
\tsoftware to the public domain. We make this dedication for the benefit
\tof the public at large and to the detriment of our heirs and
\tsuccessors. We intend this dedication to be an overt act of
\trelinquishment in perpetuity of all present and future rights to this
\tsoftware under copyright law.

\tTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
\tEXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
\tMERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
\tIN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
\tOTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
\tARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
\tOTHER DEALINGS IN THE SOFTWARE.

\tFor more information, please refer to <https://unlicense.org>
"""
