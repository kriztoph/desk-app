angular.module("deskApp", [
      'ui.router',
      'ngResource',
      'services.case',
      'services.filter'
    ])
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      $stateProvider
          .state("cases", {
            url: "/cases",
            templateUrl: "/desk/templates/cases/cases.html",
            controller: "CasesCtrl"
          })

      $urlRouterProvider.otherwise('/');
    }])

    .controller('CasesCtrl', ['$scope', 'Case', 'Filter', function($scope, Case, Filter){
      Case.get().$promise.then(function(result){
        $scope.cases = result._embedded.entries;
      });

      Filter.get().$promise.then(function(result){
        $scope.filters = result._embedded.entries;
      });

      $scope.filterCases = function(filter){
        filter_id = filter._links.self.href.replace('/api/v2/filters/', '')
        Filter.cases({filter_id: filter_id}).$promise.then(function(result){
          $scope.cases = result._embedded.entries;
          if ($scope.cases.length == 0) {
            $scope.no_cases = true;
          } else {
            $scope.no_cases = false;
          }
        })
      };
    }])
;