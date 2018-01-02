### 1. CRUD 끝내기 (non scaffold)

**RESTful** 하게 짜기! (posts 컨트롤러, post 모델!)

RESTful이란, 주소창(url)을 통해서 자원(리소스)과 행위(HTTP Verb)를 표현하는 것.

[가장 깔끔한 설명](http://meetup.toast.com/posts/92)

[routes](#1. routes.rb)

#### 0. 기본 사항

- `git` 셋팅(git init부터)
- C/R/U/D 마다 **commit** 하기
- `posts` 컨트롤러와 `post` 모델만!

# 1. routes.rb

```
  # index
  get '/posts' => 'posts#index'
  # Create
  get '/posts/new' => 'posts#new'
  post '/posts'=> 'posts#create'
  # Read
  get '/posts/:id' => 'posts#show'
  # Update
  get '/posts/:id/edit' => 'posts#edit'
  put '/posts/:id' => 'posts#update'
  # Delete
  delete '/posts/:id' => 'posts#destroy'
```

1. controller

- [filter](http://guides.rorlab.org/action_controller_overview.html#%ED%95%84%ED%84%B0)

```
before_action :set_post, only: [:show, :edit, :update, :destroy]

private

def set_post
  @post = Post.find(params[:id])
end
```

- [strong parameters](http://guides.rorlab.org/action_controller_overview.html#strong-parameters)

```
private

def post_params
  params.require(:post).permit(:title, :content)
end
```

1. view - form_tag / form_for

- [폼 헬퍼](http://guides.rorlab.org/form_helpers.html)

### 2. scaffolding.. 편하게 CRUD

1. `routes.rb`

```
  resources :posts
```

1. `scaffold` 명령어

```
$ rails g scaffold post title:string content:text
```

`posts` 컨트롤러와 `post` 모델을 만들어줌! 코드도 겁나 많음..

### 3. [파일업로드](https://github.com/carrierwaveuploader/carrierwave)

1. `gemfile`

```
gem carrierwave
```

```
$ bundle install
```

1. 파일업로더 생성

```
$ rails generate uploader Avatar
```

1. 서버 작업

- migration : string 타입의 column 추가

- `post.rb`

  ```
  mount_uploader :컬럼명, AvatarUploader
  ```

- `posts_controller.rb`

  ```
  # strong parameter에 받아주거나, create 단계에서 사진 받을 준비
  ```

1. `new.html.erb`

```
<form enctype="multipart/form-data">
  <input type="file" name="post[postimage]">
</form>

<%= form_tag ("/posts", method: "post", multipart: true) do %>
  <%= file_field_tag("post[postimage]") %><br />
<% end %>
```

### 3-1. 사진 크기 조절하여 저장

`gem mini_magick`

### 4. 인스타처럼 꾸미기(카드형 배치)