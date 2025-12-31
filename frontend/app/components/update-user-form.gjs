import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { service } from '@ember/service';

export default class UpdateUserForm extends Component {
  @service store;

  @tracked formIsShowing;
  @tracked usernameValue;
  @tracked passwordValue;
  @tracked ageValue;
  @tracked firstNameValue;
  @tracked lastNameValue;
  @tracked bioValue;

  constructor() {
    super(...arguments);

    this.usernameValue = this.args.user.username;
    this.ageValue = this.args.user.age;
    this.firstNameValue = this.args.user.first_name;
    this.lastNameValue = this.args.user.last_name;
    this.bioValue = this.args.user.bio;
  }

  @action
  changeFormState() {
    this.formIsShowing = !this.formIsShowing;
  }

  @action
  updateField(trackedVar, event) {
    // Event is passed in automatically
    this[trackedVar] = event.target.value;
  }

  @action
  submitForm() {
    if (!this.passwordValue) {
      return;
    }

    const user = this.args.user;
    user.username = this.usernameValue;
    user.password = this.passwordValue;
    user.age = this.ageValue;
    user.first_name = this.firstNameValue;
    user.last_name = this.lastNameValue;
    user.bio = this.bioValue;

    user.save();

    // Close the form
    this.changeFormState();
  }

  <template>
    <button type="button" {{on "click" this.changeFormState}}>
      {{if this.formIsShowing "Close" "Open"}}
      form
    </button>

    {{#if this.formIsShowing}}
      <div id="create-user-form">
        <label for="username">Username:</label>
        <input
          id="username"
          type="text"
          value={{this.usernameValue}}
          {{on "input" (fn this.updateField "usernameValue")}}
        />

        <label for="password">Password:</label>
        <input
          id="password"
          type="password"
          value={{this.passwordValue}}
          {{on "input" (fn this.updateField "passwordValue")}}
          required
        />

        <label for="age">Age:</label>
        <input
          id="age"
          type="number"
          value={{this.ageValue}}
          {{on "input" (fn this.updateField "ageValue")}}
        />

        <label for="first-name">First name:</label>
        <input
          id="first-name"
          type="text"
          value={{this.firstNameValue}}
          {{on "input" (fn this.updateField "firstNameValue")}}
        />

        <label for="last-name">Last name:</label>
        <input
          id="last-name"
          type="text"
          value={{this.lastNameValue}}
          {{on "input" (fn this.updateField "lastNameValue")}}
        />

        <label for="bio">Bio:</label>
        <textarea
          id="bio"
          {{on "input" (fn this.updateField "bioValue")}}
        >{{this.bioValue}}</textarea>

        <button type="button" {{on "click" this.submitForm}}>Update user</button>
      </div>
    {{/if}}
  </template>
}
