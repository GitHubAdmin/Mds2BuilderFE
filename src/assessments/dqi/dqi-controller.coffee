"use strict"

angular

  .module( "pvdm.assessments.dqi" )

  .controller( "dqi.controllers.collection", ( $scope, $state, $filter, $window, Collection, DqiSchema, ASSESSMENT_TYPE, MDS2) ->
    
    vm = @
    vm.MDS2 = MDS2
    vm.state = $state

    vm.schema = DqiSchema.schema
    vm.form = DqiSchema.form
    vm.model = DqiSchema.model
    # Assessments
    vm.assessments = []
    vm.assessments = new Collection(vm.assessments).sortBy('Resident_identifier')

    vm.addAssessment = ->
      vm.assessmentData = angular.copy(vm.model)
      vm.assessments.add(vm.assessmentData)
      $window.scrollTo(0,0)
    # Table
    vm.resetTable = ->
      vm.assessments.records = []

    vm.setAsssessment = (assessmentId) ->
      vm.assessmentId = assessmentId
      vm.model = vm.assessments.records[vm.assessmentId]

    # Batch
    vm.num_residents = "1"

    vm.assessmentType = 
      admission : true
      quarterly : false
      annual : false
      discharge : false

    vm.populateTable = (unq_res) ->
      n = 1
      while n <= unq_res
        resId = Math.random().toString().slice(2,12)
        vm.model.Resident_identifier = resId
        if vm.assessmentType.admission == true
          $filter('assessmentType')(vm.model, ASSESSMENT_TYPE.ADMISSION)
          vm.addAssessment()
        if vm.assessmentType.quarterly == true
          $filter('assessmentType')(vm.model, ASSESSMENT_TYPE.QUARTERLY)
          vm.addAssessment()
        if vm.assessmentType.annual == true
          $filter('assessmentType')(vm.model, ASSESSMENT_TYPE.ANNUAL)
          vm.addAssessment()
        if vm.assessmentType.discharge == true
          $filter('assessmentType')(vm.model, ASSESSMENT_TYPE.DISCHARGE)
          vm.addAssessment()
        n++
    
    ### CSV ###
    vm.facname = "1111111111"
    vm.getHeaders = ->
      vm.filename = vm.facname+"_CCIM_"+$filter('daysAgoFormatted')(0)+".csv"
      for keyName of vm.model
        key = keyName    
    # Csv download
    vm.getAssessmentList = vm.assessments.records

    return
  )
