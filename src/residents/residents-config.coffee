'use strict'

angular

  .module("pvdm.residents")

  .config( ($stateProvider) ->

    $stateProvider
      .state('residents',
        parent: 'layout:primary'
        url: '/resident_form'
        templateUrl: 'resident-form.html'
        controller: 'residents.controller as residentsCtrl'
      )
  )