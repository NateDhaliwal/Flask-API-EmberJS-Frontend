import Model, { attr } from '@ember-data/model';

export default class UserModel extends Model {
  @attr('string') username;
  @attr('string') password;
  @attr('string') first_name;
  @attr('string') last_name;
  @attr('number') age;
  @attr('string') bio;

  get fullName() {
    return `${this.first_name} ${this.last_name}`;
  }

  get isLegalAge() {
    return this.age >= 18;
  }
}
