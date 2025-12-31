import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { fn } from '@ember/helper';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { service } from '@ember/service';

export default class CreateUserForm extends Component {
  @service store;

  @tracked formIsShowing;
  @tracked usernameValue;
  @tracked passwordValue;
  @tracked ageValue;
  @tracked firstNameValue;
  @tracked lastNameValue;
  @tracked bioValue;

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
    let newUser = this.store.createRecord('user', {
      username: this.usernameValue,
      password: this.passwordValue,
      age: this.ageValue,
      first_name: this.firstNameValue,
      last_name: this.lastNameValue,
      bio: this.bioValue,
    });

    newUser.save();

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
          {{on "input" (fn this.updateField "usernameValue")}}
        />

        <label for="password">Password:</label>
        <input
          id="password"
          type="password"
          {{on "input" (fn this.updateField "passwordValue")}}
        />

        <label for="age">Age:</label>
        <input
          id="age"
          type="number"
          {{on "input" (fn this.updateField "ageValue")}}
        />

        <label for="first-name">First name:</label>
        <input
          id="first-name"
          type="text"
          {{on "input" (fn this.updateField "firstNameValue")}}
        />

        <label for="last-name">Last name:</label>
        <input
          id="last-name"
          type="text"
          {{on "input" (fn this.updateField "lastNameValue")}}
        />

        <label for="bio">Bio:</label>
        <textarea id="bio" {{on "input" (fn this.updateField "bioValue")}} />

        <button type="button" {{on "click" this.submitForm}}>Create user</button>
      </div>
    {{/if}}
  </template>
}
