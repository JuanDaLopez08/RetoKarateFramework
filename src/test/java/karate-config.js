function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    url_base: '',
    headers:{
        'Accept':'application/json',
        'Content-Type':'application/json'
    }
  }
  if (env == 'dev') {
    config.url_base = ''
  } else if (env == 'qa') {
    config.url_base = 'https://restful-booker.herokuapp.com',
    config.headers = {
        'Accept':'application/json',
        'Content-Type':'application/json'
    }

  }
  return config;
}