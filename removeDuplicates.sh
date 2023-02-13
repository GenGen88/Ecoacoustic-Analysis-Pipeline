#!/bin/bash

# to prevent duplicate information being present in the report, remove dupliccate lines
# this works because all reports have a time stamp with results. therefore, if the same timestamp and result is seen
# we can concur that the result line is duplicate

# CLA at position 1 represents the in file and out file

#!/bin/bash

sort -u ./report.csv > report_final.csv
