# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blogApp = angular.module("blogApp", ["ngResource"])

blogApp.controller "PostsCtrl", ["$scope", "Post", ($scope, Post) ->
  $scope.heading = "Mah Very Important Posts"
  $scope.posts = Post.query()
]

blogApp.factory "Post", ["$resource", ($resource) ->
  $resource "/posts.json"
]
