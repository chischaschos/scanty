module Scanty
  class WebApp < Base

    helpers Scanty::Helpers

    get '/' do
      posts = Post.reverse_order(:created_at).limit(10)
      @section = :all
      haml :index, locals: { posts: posts }
    end

    get '/past/:year/:month/:day/:slug/' do
      post = Post.filter(slug: params[:slug]).first
      halt [ 404, "Page not found" ] unless post
      @title = post.title
      @section = :past
      haml :post, locals: { post: post }
    end

    get '/past/:year/:month/:day/:slug' do
      redirect "/past/#{params[:year]}/#{params[:month]}/#{params[:day]}/#{params[:slug]}/", 301
    end

    get '/past' do
      posts = Post.reverse_order(:created_at)
      @title = "Archive"
      @section = :past
      haml :index, locals: { posts: posts }
    end

    get '/past/tags/:tag' do
      tag = params[:tag]
      posts = Post.grep(:tags, "%#{tag}%").reverse_order(:created_at).limit(30)
      @title = "Tagged: #{tag}"
      @tag = tag
      @section = :tag
      haml :index, locals: { posts: posts, tag: tag }
    end

    get '/feed' do
      @posts = Post.reverse_order(:created_at).limit(20)
      content_type 'application/atom+xml', charset: 'utf-8'
      builder :feed
    end

    get '/rss' do
      redirect '/feed', 301
    end

    ### Admin

    get '/auth' do
      @section = :auth
      haml :auth
    end

    post '/auth' do
      response.set_cookie(Scanty.settings.admin_cookie_key, Scanty.settings.admin_cookie_value) if params[:password] == Scanty.settings.admin_password
      redirect '/'
    end

    get '/posts/new' do
      auth
      @section = :edit
      haml :edit, locals: { post: Post.new, url: '/posts' }
    end

    post '/posts' do
      auth
      post = Post.new title: params[:title], tags: params[:tags], body: params[:body],
        created_at: params[:date]
      post.save
      redirect post.url
    end

    get '/past/:year/:month/:day/:slug/edit' do
      auth
      post = Post.filter(slug: params[:slug]).first
      halt [ 404, "Page not found" ] unless post
      @section = :edit
      haml :edit, locals: { post: post, url: post.url }
    end

    post '/past/:year/:month/:day/:slug/' do
      auth
      post = Post.filter(slug: params[:slug]).first
      halt [ 404, "Page not found" ] unless post
      post.title = params[:title]
      post.tags = params[:tags]
      post.body = params[:body]
      post.save
      redirect post.url
    end

    get '/about' do
      @section = :about
      haml :about
    end
  end
end
