const express = require("express");
const fs = require("fs");
const shell = require("shelljs");
const https = require("https");

// constants
const reportLocation = "../out/report.csv";
const analysisScriptPath = "./analysisJob..sh";

const app = express();
const port = 8080;

const readFile = (filename) => fs.readFileSync(filename).toString();
const getAnalysisResults = () => readFile(reportLocation);

const hasValue = (object) => object !== undefined && object !== null;

app.get('/', (req, res) => {
  const websiteHeader = readFile("./src/static/header.html");
  const websiteFooter = readFile("./src/static/footer.html");
  res.send(websiteHeader + constructAnalysisResults() + websiteFooter);
});

// download the report csv
app.get("/analysis_jobs/download", (req, res) => res.download(reportLocation));

app.get("/analysis_jobs/new", (req, res) => {
  const analysisFilePath = req.query.filePath;

  if (!hasValue(analysisFilePath)) {
    res.send("Please include your file path in the ?filePath= url parameter");
    return;
  }

  // the analysis job will start
  console.log(`Starting new analysis job ${analysisFilePath}`);
  res.send(
    readFile("./src/static/newAnalysisJob.html")
  );

  // start the entry point shell script for the program
  shell.exec(`${analysisScriptPath} ${analysisFilePath}`);
});

app.get("/audio_recordings/download", (req, res) => {
  const audioRecordingId = req.query.id;

  if (!hasValue(audioRecordingId)) {
    res.send("Please include your audio recording id in the ?id= url parameter");
    return;
  }

  // the analysis job will start
  console.log(`Downloading new audio recording ${audioRecordingId}`);

  const apiEndpoint = "https://api.acousticobservatory.org/audio_recordings";
  const url = `${apiEndpoint}/${audioRecordingId}/original`;
  https.get(url, (res) => {
    const path = `./in/recording_${audioRecordingId}`;
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}\n`);
  console.log("Open your web browser to one of the following addresses to see the visualizer");
  console.log(`\thttp://localhost:8080\n\thttp://127.0.0.1:8080\n\thttp://0.0.0.0:8080`);
});

const constructAnalysisResults = () => {

  const analysisResults = getAnalysisResults();
  const analysisResultsRows = analysisResults.split("\n");

  const parsedCSV = [];
  analysisResultsRows.forEach((row) => {
    parsedCSV.push(row.split(","));
  });

  let rowIndex = 0;
  let htmlContent = "<table class='min-w-full text-center border-b overflow-auto'>";
  parsedCSV.forEach(row => {
    htmlContent += "<tr>";

    // iterate through each column
    row.forEach(column => {
      htmlContent += `<td class='text-sm text-gray-900 px-6 py-4 whitespace-nowrap ${!+rowIndex ? "font-bold" : "font-medium"}'>${column}</td>`;
    });

    rowIndex += 1;
    htmlContent += "</tr>"

    // since there may be millions of lines, only render the first 30
    if (rowIndex >= 30) {
      return;
    }
  });

  // close the csv table
  htmlContent += "</table>";

  return htmlContent;
}
