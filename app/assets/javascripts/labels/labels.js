angular.module("deskApp", [
      'ui.router',
      'ngResource',
      'services.label'
    ])
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      $stateProvider
          .state("labels", {
            url: "/labels",
            templateUrl: "/desk/templates/labels/labels.html",
            controller: "LabelsCtrl"
          })

      $urlRouterProvider.otherwise('/');
    }])

    .controller('LabelsCtrl', ['$scope', 'Label', function($scope, Label){
      $scope.label = {};

      Label.get().$promise.then(function(result){
        $scope.labels = result._embedded.entries;
        console.log($scope.labels);
      });

      $scope.createLabel = function(){
        var label = new Label;
        label.name = $scope.label.name;
        label.$create();
      }
    }])
;