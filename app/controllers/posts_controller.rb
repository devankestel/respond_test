class PostsController < ApplicationController
  respond_to :json, :html

  def index
    respond_with Post.all    
  end

  def create
    respond_with Post.create(post_params)
  end

  def post_params
    params.require(:post).permit(:id, :title, :content)
  end
end
