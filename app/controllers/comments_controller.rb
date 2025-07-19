class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params) # Construit le commentaire pour cet article

    authorize @comment, :create?

    if @comment.save
      redirect_to post_path(@post), notice: "Votre commentaire a été ajouté avec succès."
    else
      @post = Post.find(params[:post_id])
      flash.now[:alert] = "Erreur lors de l'ajout du commentaire."
      render 'posts/show', status: :unprocessable_entity
    end
  end


  def edit
    @comment = Comment.find(params[:id])
    authorize @comment, :update? # Pundit vérifiera si l'utilisateur est admin
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment, :update? # Pundit vérifiera si l'utilisateur est admin

    if @comment.update(comment_params) # Utilisez comment_params pour autoriser le champ :response
      redirect_to post_path(@comment.post), notice: 'Réponse ajoutée/mise à jour.'
    else
      flash.now[:alert] = "Erreur lors de la mise à jour de la réponse."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment, :destroy? #autorise la supp via comment policy#destroy?
    @comment.destroy
    redirect_to post_path(@comment.post), notice: 'Commentaire supprimé'
  end
  
  private

  def comment_params
    params.require(:comment).permit(:author, :body, :response)
  end

end
