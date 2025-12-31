import { LinkTo } from '@ember/routing';

<template>
  <h1>Welcome!</h1>

  <p>This is a very basic application, where you can create and view users!</p>

  <LinkTo @route="users">Users</LinkTo>
</template>
