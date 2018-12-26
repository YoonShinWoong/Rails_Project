class PostsController < ApplicationController
  # C 만들기------------------------------------------------
  def new
  end
 
  def create  
    
    @post = Post.new 
    @post.title = params[:title]
    @post.content = params[:content]
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
    @post.title = params[:title]
    @post.content = params[:content]
    @post.save
    
    redirect_to "/posts/show/#{@post.id}"
    
  end
 
  # D 삭제하기------------------------------------------------  
  def destroy
    
   @post = Post.find(params[:id]) # 해당 Post 객체 찾기
   @post.destroy
 
   redirect_to "/posts/index"
  end
end
