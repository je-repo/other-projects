require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();

// Declare dns instance
const dns = require('node:dns');

// Declare url parser instance
const urlParser = require('url');

// Declare mongoose instance
const mongoose = require('mongoose');

// Connect to mongodb free instance
mongoose.connect(process.env.MONGO_URI, {useNewUrlParser: true, useUnifiedTopology: true});

// Declare body-parser instance
const bodyParser = require('body-parser');

// Mount body-parser middleware
app.use(bodyParser.urlencoded({ extended: false }));

// Create mdb schema
let shortUrlSchema = new mongoose.Schema({
  originalUrl: String,
  shortUrl: Number
});

// Create mdb model
let ShortUrl = mongoose.model('ShortUrl', shortUrlSchema);

// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());

app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function(req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});


// TODO: Endpoint /api/shorturl 
app.post('/api/shorturl', function (req, res) {
  const urlInput = req.body.url;

  const dnsLookup = dns.lookup(urlParser.parse(urlInput).hostname, async (err, address) => {
    if (!address) {
      res.json({ error: 'invalid url' });
    } else {
      
      const shortenedUrl = await ShortUrl.countDocuments({}) + 1;
      const result = await ShortUrl.create({ shortUrl: shortenedUrl.toString(), originalUrl: urlInput });

      console.log(`db insertion result: ${result}`);

      res.json({ original_url: urlInput, short_url: shortenedUrl });

    // alternative method of handling promise, without declaring async function
    //   ShortUrl.countDocuments()
    //               .then(count => {
    //                 console.log(`The short url is: ${count + 1}.`);
    //                 const shortenedUrl = count + 1;
    
    //                 ShortUrl.create({shortUrl: shortenedUrl.toString(), originalUrl: urlInput})
    //                             .then(result => {
    //                               res.json({ original_url: result.originalUrl, short_url: result.shortUrl });
    //                             });
    //               })
    //               .catch(err => console.error(err));

    }
  });
});


// TODO: Endpoint /api/shorturl/<short-url>
app.get('/api/shorturl/:shortUrl', async function (req, res) {
  
  const mongoDoc = await ShortUrl.findOne({ shortUrl: req.params.shortUrl });
  console.log(`mongodoc: ${mongoDoc}`);
  res.redirect(mongoDoc.originalUrl);
  
  // alternative way of handling promise, without declaring async function
  // ShortUrl.findOne({shortUrl: +req.params.shortUrl})
  // .then(doc => {
  //   console.log(`Retrieved document: ${doc}`)
  //   res.redirect(doc.originalUrl);
  // })
  // .catch(err => console.error(err));

});


app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});
