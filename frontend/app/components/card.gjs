import { equals, notEquals } from '../helpers/conditionals';
import { LinkTo } from '@ember/routing';
import Component from '@glimmer/component';
import { service } from '@ember/service';

export default class Card extends Component {
  @service router;

  get currentRoute() {
    return this.router.currentRouteName;
  }

  <template>
    <div class="card">
      {{#if (notEquals this.currentRoute "users.user")}}
        <LinkTo @route="users.user" @model={{@model}}>
          <h3>Username: {{@model.username}}</h3>
        </LinkTo>
      {{else}}
        <h3>Username: {{@model.username}}</h3>
      {{/if}}
      <h4>Full name: {{@model.fullName}}</h4>
      <p>Age:
        {{@model.age}}
        {{if (equals @model.age 1) "year" "years"}}
        old ({{if
          @model.isLegalAge
          "Is of a legal age!"
          "Is not of a legal age"
        }})</p>
      <p>Bio: {{@model.bio}}</p>
    </div>
  </template>
}
