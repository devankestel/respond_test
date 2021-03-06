# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

blogApp = angular.module("blogApp", ["ngResource", "ngTouch", "ngRoute"])

blogApp.config(["$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])

blogApp.config(["$routeProvider", ($routeProvider) ->
  $routeProvider
    .when("/posts/:id",
      controller: "PostsCtrl",
      templateUrl: "show.html"
    )
])

blogApp.controller "PostsCtrl", ["$scope", "$routeParams", "$route", "Post", ($scope, $routeParams, $route, Post) ->
  $scope.heading = "Rangular Memo Board:"
  $scope.subheading = "Brought to you by Rails 4 and AngularJS 1.4.7"
  $scope.subsubheading = "With help from Bootstrap, CoffeeScript, and HAML."
  $scope.posts = Post.query()
  pathArray = window.location.pathname.split("/")
  $scope.postId = pathArray[pathArray.length - 1]
  $scope.currentPost = Post.get(postId: $scope.postId) if $scope.postId != ""
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
      console.log(resource)
      index = $scope.posts.map((e) ->
        e.id
      ).indexOf(resource.id)
      console.log(index) 
      $scope.posts.splice(index, 1)
      ), (response) ->
        console.log "Error: " + response.status
  $scope.update = (post) ->
    console.log post.id
    Post.update {postId: post.id}, post, ((resource) ->
      console.log resource
      index = $scope.posts.map((e) ->
        e.id
      ).indexOf(resource.id)
      console.log(index)      
      $scope.posts[index] = resource
      ), (response) ->
      console.log "Error: " + response.status
]

blogApp.factory "Post", ["$resource", ($resource) ->
  $resource "/posts/:postId.json", postId: "@id", 
    update: 
      method: "PATCH"
]


