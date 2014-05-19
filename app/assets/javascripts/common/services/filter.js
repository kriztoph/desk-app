angular.module('services.filter', [])
    .factory('Filter', function($resource) {
      return $resource('/api/v1/filters.json', {},
      { 'get':  { method: 'GET', isArray: false },
        'cases': { method:'GET',
                   params: { filter_id: '@filter_id' },
                   url: '/api/v1/filters/:filter_id/cases' }
      });
    })
;