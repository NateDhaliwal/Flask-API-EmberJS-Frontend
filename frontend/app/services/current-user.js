import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

export default class CurrentUserService extends Service {
  @tracked currentUser;
  constructor() {
    super(...arguments);
    fetch('https://5wdnpf3r-5000.asse.devtunnels.ms/api/current-user').then(
      (res) => {
        this.currentUser = res.json()['current_user'];
      }
    );
  }
}
