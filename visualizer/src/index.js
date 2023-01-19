const express = require("express");
const fs = require("fs");
const shell = require("shelljs");

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
    res.send("Please include your file path in the ?q=filePath url parameter");
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
  });

  // close the csv table
  htmlContent += "</table>";

  return htmlContent;
}
