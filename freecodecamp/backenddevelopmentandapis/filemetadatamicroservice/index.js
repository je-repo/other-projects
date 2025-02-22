var express = require('express');
var cors = require('cors');
require('dotenv').config()
const busboy = require('busboy');
const req = require('express/lib/request');


var app = express();

app.use(cors());
app.use('/public', express.static(process.cwd() + '/public'));

app.get('/', function (req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});


app.post('/api/fileanalyse', async function(req, res) {
  console.log(`post request\n`);

  const bb = busboy({ headers: req.headers });
  console.log(`req.headers: ${JSON.stringify(req.headers)}`);

  bb.on('file', (name, file, info) => {

    res.json({
      name: info.filename,
      type: info.mimeType,
      size: Number(req.headers['content-length'])
    });


  });

  req.pipe(bb);
  

});


const port = process.env.PORT || 3000;
app.listen(port, function () {
  console.log('Your app is listening on port ' + port)
});
