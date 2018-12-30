class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :log_impression, :only=> [:show]
 
 # 조회수 설정
  def log_impression
      @hit_post = Post.find(params[:id])
      # this assumes you have a current_user method in your authentication system
      @hit_post.impressions.create(ip_address: request.remote_ip,user_id:current_user.id)
  end

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
    @posts = Post.order("created_at DESC").page(params[:page]).per(10)
    @page = (params[:page]).to_i
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
  

  # 검색하기 -------------------------------------------------  
  def search
      if params[:cate] == "1"
        @posts =Post.where("title LIKE ?", "%#{params[:q]}%")
      elsif params[:cate] == "2"
        @posts =Post.where("content LIKE ?", "%#{params[:q]}%")
      elsif params[:cate] == "3" #OR 처리
        @posts =Post.where("title LIKE ? OR content LIKE ?", "%#{params[:q]}%","%#{params[:q]}%")
      elsif params[:cate] == "4"  #작성자 검색은 조금 다름
        @posts = User.where("username LIKE ?","%#{params[:q]}%").take.posts
      end
  end
end
