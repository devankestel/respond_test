class PostsController < ApplicationController
  respond_to :json, :html

  def index
    if session[:guest_id]
      respond_with User.find(session[:guest_id]).posts.all
    else
      respond_with sample_posts
    end    
  end
  
  def show
    respond_with Post.find(params[:id])
  end

  def logout
    User.find(session[:guest_id]).posts.destroy_all
    session[:guest_id] = nil
    redirect_to '/'
  end

  def create
    if session[:guest_id]
      respond_with User.find(session[:guest_id]).posts.create!(post_params)
    else
      @current_user = User.create()
      session[:guest_id] = @current_user.id
      respond_with @current_user.posts.create!(post_params)
    end
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
  def add_sample_posts
    sample_posts.each do |sample_post|
      Post.create!(sample_post)
    end
  end
  def sample_posts
    [{"title": "Here Comes Honey Boo Boo", "content": "I got my go-go juice."},{"title": "Another hum-drum post.", "content": "Oh here we go again."}]
  end
end
