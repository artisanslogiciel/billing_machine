app.controller 'ProjectCtrl', ["$scope", "Project", ($scope, Project) ->
  $scope.projects = Project.query()

  $scope.addProject = ->
    project = Project.save($scope.newProject)
    $scope.projects.push(project)
    $scope.newProject = {}

  $scope.update = (project) ->
    project.$update()
]