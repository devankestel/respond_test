class PostsController < ApplicationController
  respond_to :json, :html

  def index
    respond_with Post.all    
  end

  def create
    respond_with Post.create(post_params)
  end

  def update
    respond_with Post.find(params[:id]).update(post_params)
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  def post_params
    params.require(:post).permit(:id, :title, :content)
  end
end
