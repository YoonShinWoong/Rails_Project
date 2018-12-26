class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # C 만들기------------------------------------------------
  def new
  end
 
  def create  
    
    @post = Post.new 
    @post.title = params[:title]
    @post.content = params[:content]
    @post.user_id = params[:user_id]
    @post.save
    
    redirect_to "/posts/index"
  end
 
  # R 보기------------------------------------------------
  def show
    @post = Post.find(params[:id]) # 해당 Post 객체 찾기
  end
 
  def index
    @posts = Post.all.reverse
  end
 
  # U 수정하기------------------------------------------------
  def edit
    @post = Post.find(params[:id]) # 해당 Post 객체 찾기
  end
 
  def update
    @post = Post.find(params[:id]) # 해당 Post 객체 찾기
 
    # 같을 경우에만 수정
    if current_user.id == @post.user_id
      @post.title = params[:title]
      @post.content = params[:content]
      @post.save
      
      redirect_to "/posts/show/#{@post.id}"
    else
      redirect_to "/posts/show/#{@post.id}"
    end
  end
 
  # D 삭제하기------------------------------------------------  
  def destroy
   
    @post = Post.find(params[:id]) # 해당 Post 객체 찾기
    # 같을 경우에만 삭제
    if current_user.id == @post.user_id 
      @post.destroy
      redirect_to "/posts/index"
    else
      redirect_to "/posts/index"
    end
  end
end
