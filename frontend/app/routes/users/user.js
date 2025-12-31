import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class UsersUserRoute extends Route {
  @service store;

  model(params) {
    return this.store.findRecord('user', parseInt(params.id));
  }
}
