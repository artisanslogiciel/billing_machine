# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app.factory "Project", ["$resource", ($resource) ->
  $resource("/api/v1/projects/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.directive 'bbNameEdit', ->
  return (scope, element) ->
    element.find('.edit').hide()
    element.find('.show a').bind 'click', -> 
      element.find('.show').hide()
      element.find('.edit').show()
    element.find('.edit :submit').bind 'click', -> 
      element.find('.show').show()
      element.find('.edit').hide()


app.controller 'ProjectCtrl', ["$scope", "Project", ($scope, Project) ->
  $scope.projects = Project.query()

  $scope.addProject = ->
    project = Project.save($scope.newProject)
    $scope.projects.push(project)
    $scope.newProject = {}

  $scope.update = (project) ->
    project.$update()
]