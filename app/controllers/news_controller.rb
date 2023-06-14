class NewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :create_comment]
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_or_admin!, only: [:edit, :update, :destroy]

  # GET /news or /news.json
  def index
    @news = News.all
  end

  # GET /news/1 or /news/1.json
  def show
    @news = News.find(params[:id])
    @user = @news.user
    @comment = Comment.new
  end

  # GET /news/new
  def new
    if current_user.nil?
      flash[:warning] = "Debe iniciar sesión o registrarse para crear una nueva noticia."
      redirect_to new_user_session_path
    else
      @news = News.new
    end
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news or /news.json
  def create
    @news = News.new(news_params)
    @news.user = current_user if user_signed_in?

    respond_to do |format|
      if @news.save
        format.html { redirect_to news_url(@news), notice: "Noticia Fue Creada." }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1 or /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to news_url(@news), notice: "News was successfully updated." }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1 or /news/1.json
  def destroy
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url, notice: "News was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_comment
    @news = News.find(params[:id])
    @comment = @news.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @news, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def news_params
      params.require(:news).permit(:title, :content, :user_id)
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id)
    end
  
    def authorize_user_or_admin!
      unless current_user.admin? || (current_user == @news.user)
        flash[:alert] = "No tienes permisos para realizar esta acción."
        redirect_to root_path
      end
    end
    
    
end
