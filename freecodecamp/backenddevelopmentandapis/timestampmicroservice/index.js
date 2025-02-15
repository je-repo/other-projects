// index.js
// where your node app starts

// init project
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC 
var cors = require('cors');
app.use(cors({optionsSuccessStatus: 200}));  // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});


// your first API endpoint... 
app.get("/api/hello", function (req, res) {
  res.json({greeting: 'hello API'});
});


// timestamp api

// TODO: helper function to check for valid date
const isInvalidDate = (date) => date.toUTCString() === 'Invalid Date';

// TODO: function using relevant helper function to return desired json output
const timestampFunc = (req, res) => {

  let dateInput = req.params.date ? new Date(req.params.date): new Date(Date.now());
  
  if (isInvalidDate(dateInput)) dateInput = new Date(+req.params.date);

  if (isInvalidDate(dateInput)) res.json({ error: 'Invalid Date' });

  res.json({
    unix: dateInput.getTime(),
    utc: dateInput.toUTCString()
  });

};


// TODO: create api endpoint "api/<date- or unix parameter>"
app.get("/api/:date?", timestampFunc);


// Listen on port set in environment variable or default to 3000
var listener = app.listen(process.env.PORT || 3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});
