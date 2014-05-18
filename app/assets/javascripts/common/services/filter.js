angular.module('services.filter', [])
    .factory('Filter', function($resource) {
      return $resource('/api/v1/filters.json', {}, {
        get: { method: 'GET', isArray: false }
      });
    })
;