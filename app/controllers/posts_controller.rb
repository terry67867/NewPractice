class PostsController < ApplicationController
  #before_action은 하나의 액션을 실행하기 전에 해당 메소드를 실행.
  #컨트롤러 filter
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts=Post.all
  end

  def new
  end

  def create
    Post.create(post_params)
    puts "***************"
    puts post_params
    puts "***************"

    Post.create(
      title: params[:title],
      content: params[:content]
    )
    redirect_to '/'
  end

  def show
    # @post=Post.find(params[:id])
  end

  def edit
  end

  def update
    # @post=Post.find(params[:id])
    @post.update(title: params[:title], content: params[:content])
    redirect_to "/posts/#{@post.id}"
  end

  def destroy
    # @posts=Post.find(params[:id])
    @post.destroy
    redirect_to '/'
  end

  # private 위에는 public 상태라서 하나의 url로 요청오면 그것을 받아서 뷰를 보여준다.
  private
  # private은 해당 컨트롤러(PostsController)에서만 사용가능함.
  # 객체에서 private속성을 가지면 클래스 내부에서만 접근이 가능했었고,
  # 이 외의 상속받은 클래스나 객체 인스턴스에서도 접근이 불가능했음.
  def set_post
    @post = Post.find(params[:id])
  end

  # strong parameter
  def post_params
    params.require(:post).permit(:title, :content, :postimage)
  end

end
