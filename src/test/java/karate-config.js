function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    url_base: ''
  }
  if (env == 'dev') {
    config.url_base = ''
  } else if (env == 'qa') {
    config.url_base = 'https://restful-booker.herokuapp.com/booking',
    config.headers = {
        Accept:'application/json'
    }

  }
  return config;
}