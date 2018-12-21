class PostsController < ApplicationController
  def new
    if current_user
      @post = Post.new
    else
      redirect_to login_url
    end
  end

  def create
    @post = Post.create(post_params.merge(user_id: current_user.id))
    flash[:success] = "Your post have been created"
    redirect_to posts_url
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:danger] = "Your post have been deleted"
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
  @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Your post have been updated"
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end

end
