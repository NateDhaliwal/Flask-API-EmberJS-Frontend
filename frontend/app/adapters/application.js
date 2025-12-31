import JSONAPIAdapter from '@ember-data/adapter/json-api';

export default class ApplicationAdapter extends JSONAPIAdapter {
  host = 'https://5wdnpf3r-5000.asse.devtunnels.ms'; // your Flask API
  namespace = ''; // optional, e.g. 'api'
}
