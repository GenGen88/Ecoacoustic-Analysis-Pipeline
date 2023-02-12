# error codes
ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE = "expected calling parameter: $1 to equal a target date"
ERROR_404_MESSAGE = "Error 404, audio file not found..."
ERROR_INVALID_DATE_ERROR_MESSAGE = "invalid date found..."

# working directory constants
DIR_SOURCE = "./src/"
DIR_OUT_DIRECTORY = "./out/"
DIR_IN_DIRECTORY = "./data/"

DIR_WEATHER_IN_FILE_PATH = f"{DIR_IN_DIRECTORY}"

DIR_BIRDNET_OUT_FILE_PATH = f"{DIR_OUT_DIRECTORY}birdnet-results.csv"
DIR_WEATHER_OUT_FILE_PATH = f"{DIR_OUT_DIRECTORY}weather.csv"
DIR_REPORT_OUT_FILE_PATH = f"{DIR_OUT_DIRECTORY}report.csv"
# there are some post processing checks done before the final
DIR_TOTAL_REPORT_OUT_FILE_PATH = f"{DIR_OUT_DIRECTORY}final_report.csv"

EMU_SCRIPT_PATH = f"{DIR_SOURCE}/emu/runEmu.sh"

# CLA argument positions
CLA_FILE_IN_POSITION = 1
CLA_PIPELINE_MODE_CLA_POSITION = 2

VALID_AUDIO_FILE_EXTENSIONS = [".wav", ".mp3", ".flac"]

# misc
COLUMN_HEADERS = "Selection,View,Channel,BeginTime,EndTime,LowFreq,HighFreq,SpeciesCode,CommonName,Confidence,date,season,isWet,date,min-temp,max-temp,rainfall,evaporation,sunshine,wind-direction,wind-speed,wind-time-of-measurement,9am-temp,9am-humidity,9am-cloud-amount,9am-wind-direction,9am-wind-speed,9am-pressure,3pm-Temperature,3pm-relative-humidity,3pm-cloud-amount,3pm-wind-direction,3pm-wind-speed,3pm-pressure\n"

CONSOLE_INIT_MESSAGE = """
VRES Analyser
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
