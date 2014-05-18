angular.module("deskApp", [
      'ui.router',
      'ngResource',
      'services.case'
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

    .controller('CasesCtrl', ['$scope', 'Case', function($scope, Case){
      Case.get().$promise.then(function(result){
        $scope.cases = result._embedded.entries;
      });
    }])
;