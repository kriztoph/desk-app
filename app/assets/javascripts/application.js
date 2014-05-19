// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require angular
//= require angular-resource
//= require angular-ui-router

angular.module("deskApp", [
      'ui.router',
      'ngResource'
    ])
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      $stateProvider
          .state("cases", {
            url: "/",
            templateUrl: "/desk/templates/app/cases/cases.html",
            controller: "CasesCtrl"
          })
          .state("labels", {
            url: "/labels",
            templateUrl: "/desk/templates/app/labels/labels.html",
            controller: "LabelsCtrl"
          })

      $urlRouterProvider.otherwise('/');
    }])

    .factory('Case', ['$resource', function($resource) {
      return $resource('/api/v1/cases.json', {}, {
        get: { method: 'GET', isArray: false }
      });
    }])

    .factory('Filter', ['$resource', function($resource) {
      return $resource('/api/v1/filters.json', {},
          { 'get':  { method: 'GET', isArray: false },
            'cases': { method:'GET',
              params: { filter_id: '@filter_id' },
              url: '/api/v1/filters/:filter_id/cases' }
          });
    }])

    .factory('Label', ['$resource', function($resource) {
      return $resource('/api/v1/labels.json', {}, {
        get: { method: 'GET', isArray: false },
        create: { method: 'POST' }
      });
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

    .controller('LabelsCtrl', ['$scope', 'Label', function($scope, Label){
      $scope.label = {};

      $scope.updateLabels = function(){
        Label.get().$promise.then(function(result){
          $scope.labels = result._embedded.entries;
        });
      }

      $scope.createLabel = function(){
        var label = new Label;
        label.name = $scope.label.name;
        label.$create().then(function(){
          $scope.updateLabels();
        })
      }

      $scope.updateLabels();
    }])
;


