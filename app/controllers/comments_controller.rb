class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @news = News.find_by(id: params[:news_id])
    @comment = Comment.new
  end

  def edit
    @news = @comment.news
  end

  def create
    @comment = Comment.new(comment_params)

    if user_signed_in?
      @comment.user_id = current_user.id
    else
      @comment.user_id = User.find_by(email: 'invitado@tudominio.com').id
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.news, notice: "Comentario creado exitosamente." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.news, notice: "Comentario actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.news, notice: "Comentario eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :news_id, :user_id)
  end

  def authorize_user!
    unless current_user == @comment.user || current_user.admin?
      flash[:alert] = "No estás autorizado para realizar esta acción."
      redirect_to root_path
    end
  end
end
