class PostsController < ApplicationController
  respond_to :json, :html

  def index
    if session[:guest_id]
      respond_with User.find(session[:guest_id]).posts.all && Post.where(sample: true)
    else
      if Post.where(user_id: !nil).length > 0
        redirect_to '/posts/logout'

      elsif Post.where(sample: true).length >= 1
        respond_with Post.where(sample: true)
      else
        add_sample_posts
        respond_with Post.where(sample: true)
      end
    end    
  end
  
  def show
    respond_with Post.find(params[:id])
  end

  def logout
    User.find(session[:guest_id]).posts.destroy_all
    Post.where(sample: true).destroy_all
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
  def find_sample_posts
    
  end
  def add_sample_posts
    sample_posts.each do |sample_post|
      Post.create!(sample_post)
    end
  end
  def sample_posts
    [{title: "Dbl-click the blue header to edit a title.", content: "Double click the content to edit.", sample: "true"}, {title: "Use the form to add a memo.", content: "Or click 'logout' or hit 'refresh' to start fresh.", sample: "true"}]
  end
end
