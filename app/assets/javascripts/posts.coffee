# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blogApp = angular.module("blogApp", ["ngResource", "ngTouch"])

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
  $scope.destroy = (post)->
    console.log(post.id)
    Post.delete {postId: post.id}, ((resource) ->
      console.log("got in")
      $scope.posts = Post.query()
      ), (response) ->
        console.log "Error: " + response.status
  $scope.update = (post) ->
    console.log post.id
    Post.update {postId: post.id}, post, ((resource) ->
      console.log resource
      $scope.posts = Post.query()
      ), (response) ->
      console.log "Error: " + response.status
]

blogApp.factory "Post", ["$resource", ($resource) ->
  $resource "/posts/:postId.json", postId: "@id", 
    update: 
      method: "PATCH"
]

