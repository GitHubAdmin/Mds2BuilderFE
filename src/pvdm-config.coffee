"use strict"

angular

  .module( "pvdm" )

  .config( ($httpProvider, $urlRouterProvider, $stateProvider, $compileProvider, $logProvider, paginationTemplateProvider, $translateProvider, PATHS, MDS2) ->

    #
    # Custom pagination template
    paginationTemplateProvider.setPath('pagination-template.html')
    
    #
    # Define layouts
    layoutPrimary =
      abstract: true
      name: "layout:primary"
      template: "<pvdm-primary-layout></pvdm-primary-layout>"

    $stateProvider
      .state(layoutPrimary)

    #
    # Routes
    $urlRouterProvider
      .otherwise("/404_error")

    #
    # Config translations
    $translateProvider
      .addInterpolation('$translateMessageFormatInterpolation')
      .useLoader("pvdmRevLocaleLoader")
      .preferredLanguage("en-us")
      .useSanitizeValueStrategy("sanitize")
      .fallbackLanguage("en-us")
      .useLocalStorage()

    #
    # Disable debug mode on "abaqis.com" domains for better performance
    if RegExp(MDS2.PRODUCTION_DOMAIN, "i").test(window.location.host)
      # Don't add angular debug params to DOM elements
      $compileProvider.debugInfoEnabled(false)
      # Disable console logging
      $logProvider.debugEnabled(false)

    #
    # Delay digest cycle when multiple async calls made to improve performance
    $httpProvider.useApplyAsync(true)

  )
