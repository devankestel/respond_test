class PostsController < ApplicationController
  respond_to :json, :html

  def index
    @posts = Post.all
    respond_with @posts    
  end
end
