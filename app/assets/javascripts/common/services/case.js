angular.module('services.case', [])
    .factory('Case', ['$resource', function($resource) {
      return $resource('/api/v1/cases.json', {}, {
        get: { method: 'GET', isArray: false }
      });
    }]);
;

