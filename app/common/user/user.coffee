angular
  .module('shame.user', [
      'ngResource'
    ]
  )
  .factory 'User', ['$resource', ($resource) ->
      $resource 'user', {},
        me:
          method: 'GET'
          url: '/me'
    ]
