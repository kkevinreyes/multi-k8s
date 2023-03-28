const keys = require('./keys'); // API/connection keys
const redis = require('redis'); // redis client

//Create redis client
const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  retry_strategy: () => 1000,
});
const sub = redisClient.duplicate();

// Fibonacci Recursive Solution
function fib(index) {
  if (index < 2) return 1;
  return fib(index - 1) + fib(index - 2);
}

// Watch Redis
// subscription
sub.on('message', (channel, message) => {
  //message is the index
  redisClient.hset('values', message, fib(parseInt(message))); //hash of values
});
sub.subscribe('insert');
