app.controller 'ProjectCtrl', ["$scope", "Project", ($scope, Project) ->
  $scope.newProject = 
    name: ''
  $scope.projects = Project.query()

  $scope.addProject = ->
    project = Project.save(
      $scope.newProject
      (response) ->
        $scope.projects.push(project)
        $scope.newProject = {}
      (error) ->
        console.log error
        $scope.newProject.errors = error.data
    )

  $scope.update = (project) ->
    project.$update(
      (response) ->
        console.log 'Project updated'
      (error) ->
        project.errors = error.data
        console.log error.data
    )
]