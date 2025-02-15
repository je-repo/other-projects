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
// TODO: helper function converting date to unix time stamp in milliseconds
const dateToUnix = (dateInput) => {
  const unixTimeStamp = Math.floor(new Date(dateInput).getTime());
  
  return {
    'unix': unixTimeStamp,
    'utc': dateInput
  };
};


// TODO: helper function converting unix time stamp (milliseconds) to date
const unixToDate = (dateInput) => {
  const standardDateFormat = new Date(dateInput / 1000);

  return {
    'unix': dateInput,
    'utc': standardDateFormat
  }
};

// TODO: function using relevant helper function to return desired json output
const timeStampFunc = (req, res) => {
  const dateInput = req.params.dateParam;
  
  if (Number(dateInput)) {
    res.json(unixToDate(dateInput));
  } else {
    res.json(dateToUnix(dateInput));
  }

};


// TODO: create api endpoint "api/<date- or unix parameter>"
app.get("/api/:dateParam", timeStampFunc);


// Listen on port set in environment variable or default to 3000
var listener = app.listen(process.env.PORT || 3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});
