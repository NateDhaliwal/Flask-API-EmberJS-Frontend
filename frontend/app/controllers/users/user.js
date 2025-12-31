import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class UsersUserController extends Controller {
  @service store;
  @service router;

  @action
  deleteUser(user) {
    user.deleteRecord();
    user.save();
    this.router.transitionTo('users');
  }
}
