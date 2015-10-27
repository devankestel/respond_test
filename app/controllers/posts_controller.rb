class PostsController < ApplicationController
  respond_to :json, :html

  def index
    respond_with Post.all    
  end
end
