var express = require('express');
var app = express();

app.use("/app", express.static("app"));
app.use("/imagenes", express.static("imagenes"));
app.use("/js", express.static("js"));
app.use("/css", express.static("css"));

app.get('/*', function (req, res) {
  res.sendfile('index.html');
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
