const express = require("express");
const fs = require("fs");

const app = express();
const port = 8080;

app.get('/', (req, res) => {
  const websiteHeader = readFile("./src/static/header.html");
  const websiteFooter = readFile("./src/static/footer.html");
  res.send(websiteHeader + getAnalysisResults() + websiteFooter);
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});

const readFile = (filename) => {
   var contents= fs.readFileSync(filename);
   return contents;
}

const getAnalysisResults = () => {
  const results = readFile("../out/report.csv");
  console.log(results);
  return results;
}
