import { module, test } from 'qunit';
import { setupRenderingTest } from 'frontend/tests/helpers';
import { render } from '@ember/test-helpers';
import CreateUserForm from 'frontend/components/create-user-form';

module('Integration | Component | create-user-form', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Updating values is achieved using autotracking, just like in app code. For example:
    // class State { @tracked myProperty = 0; }; const state = new State();
    // and update using state.myProperty = 1; await rerender();
    // Handle any actions with function myAction(val) { ... };

    await render(<template><CreateUserForm /></template>);

    assert.dom().hasText('');

    // Template block usage:
    await render(<template>
      <CreateUserForm>
        template block text
      </CreateUserForm>
    </template>);

    assert.dom().hasText('template block text');
  });
});
