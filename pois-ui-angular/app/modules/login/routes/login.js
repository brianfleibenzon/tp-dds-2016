angular.module('pois-app')
.config(function($stateProvider) {
  return $stateProvider
  .state('main.login', {
    url: "/",
    templateUrl: "app/modules/login/login.html",
    controller: "LoginCtrl",
    controllerAs: "loginCtrl"
  })
  .state('main.login.incorrecto', {
     views : { "resultado-login": { templateUrl: "app/modules/login/views/loginIncorrecto.html" } }
  })
});