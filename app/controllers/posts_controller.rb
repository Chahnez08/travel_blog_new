class PostsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order(published_at: :desc)
    @posts = policy_scope(Post).order(published_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.published_at = Time.current unless @post.published_at.present?
    authorize @post
    if @post.save
      redirect_to @post, notice: 'Article publié'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      @post.published_at = Time.current unless @post.published_at.present?
      redirect_to @post, notice: "Article mit à jour!"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    redirect_to posts_url, notice: "Article supprimé."
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :location, :published_at, :photo)
  end

end
