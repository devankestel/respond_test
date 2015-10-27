# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blogApp = angular.module("blogApp", ["ngResource"])

blogApp.config(["$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

blogApp.controller "PostsCtrl", ["$scope", "Post", ($scope, Post) ->
  $scope.heading = "Mah Very Important Posts"
  $scope.posts = Post.query()
  $scope.create = ->
    console.log($scope.newPost)
    Post.save $scope.newPost, ((resource) ->
      $scope.posts.push resource
      console.log(resource)
      $scope.newPost = {}
      ),(response) ->
        console.log "Error: " + response.status
]

blogApp.factory "Post", ["$resource", ($resource) ->
  $resource "/posts.json"
]

