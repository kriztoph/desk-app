angular.module("deskApp", [
        'ui.router'
    ])
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      $stateProvider
          .state("agent", {
            url: "/",
            templateUrl: "/desk/templates/agent/agent.html",
            controller: "AgentCtrl"
          })

      $urlRouterProvider.otherwise('/');
    }])

    .controller('AgentCtrl', ['$scope', function($scope){
      console.log('agent controller');
    }])
;

