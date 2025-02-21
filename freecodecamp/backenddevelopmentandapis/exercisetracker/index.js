const express = require('express')
const app = express()
const cors = require('cors')
require('dotenv').config()

app.use(cors())
app.use(express.static('public'))
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

const mongoose = require('mongoose');
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true });

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));


// TODO: Create mongoose user schema
const userSchema = new mongoose.Schema({
  username: String
});

// TODO: Create mongoose exercise schema
const exerciseSchema = new mongoose.Schema({
  description: String,
  duration: Number,
  date: Date,
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User'}
});

const User = mongoose.model('User', userSchema);
const Exercise = mongoose.model('Exercise', exerciseSchema);


// TODO: /api/users POST endpoint
app.post('/api/users', async function(req, res) {
  
  const usernameInput = req.body.username;
  const newUser = await User.create({ username: usernameInput});
  
  res.json({_id: newUser._id.toString(), username: newUser.username});
  
});


// TODO: /api/users GET endpoint
app.get('/api/users', async function(req, res) {
  const allUsers = await User.find({})
                             .select( '_id username')
                             .then(objArray => objArray.map(obj => {
                                return {username: obj.username, _id: obj._id.toString()}
                              }));
  
  res.json(allUsers);
});


// TODO: /api/users/:_id/exercises POST endpoint
app.post('/api/users/:_id/exercises', async function(req, res) {

  const userId = req.params._id;
  const { description, duration, date } = req.body;

  const userDoc = await User.findById(userId);
  
  // check user id is valid
  if (userDoc) {
    // create exercise record referencing user id
    const newExerciseRecord = await Exercise.create({ 
      description, 
      duration, 
      date: date ? new Date(date) : new Date(), 
      user: userDoc._id});
 
    // return json response
    res.json({
      _id: userDoc._id.toString(),
      username: userDoc.username,
      date: newExerciseRecord.date.toDateString(),
      duration: newExerciseRecord.duration,
      description: newExerciseRecord.description
    });
  }
});


// TODO: /api/users/:_id/logs GET endpoint
app.get('/api/users/:_id/logs', async function(req, res) {
  
  // TODO: /api/users/:_id/logs GET endpoint search parameters
  const from =req.query.from ? new Date(req.query.from) : null;
  const to = req.query.to ? new Date(req.query.to) : null;
  const limit = req.query.limit;

  const userId = req.params._id;
  const userDoc = await User.findById(userId);
  const userExerciseCount = await Exercise.countDocuments({user: userId});

  const ifQuery = (prop, queryProp, value) => value === null ? null : {[prop]: {[queryProp]: value}};

  console.log(`from: ${from}`);
  console.log(`to: ${to}`);
  console.log(ifQuery('date', '$gte', from));

  let userExercises = await Exercise.find({ $and: [
                                                    {user: userId},
                                                    ifQuery('date', '$gte', from),
                                                    ifQuery('date', '$lte', to)
                                                  ]
                                                  .filter(q => q !== null)
                                                })
                                    .limit(limit)
                                    .then(objArray => objArray.map(obj => {
                                      return {
                                        ...obj._doc, 
                                        date: new Date(obj.date).toDateString()
                                        }
                                      }));

  res.json({
    username: userDoc.username,
    count: userExerciseCount,
    _id: userDoc._id,
    log: userExercises
  });
});


const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})
