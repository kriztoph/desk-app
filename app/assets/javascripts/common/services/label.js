angular.module('services.label', [])
    .factory('Label', ['$resource', function($resource) {
      return $resource('/api/v1/labels.json', {}, {
        get: { method: 'GET', isArray: false },
        create: { method: 'POST' }
      });
    }]);
;

