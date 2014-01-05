module Sinatra
  module Blogging
    module Routes

      def self.registered app
        app.class_eval do
          get '/' do
            posts = Post.reverse_order(:created_at).limit(10)
            haml :index, :locals => { :posts => posts }
          end

          get '/past/:year/:month/:day/:slug/' do
            post = Post.filter(:slug => params[:slug]).first
            stop [ 404, "Page not found" ] unless post
            @title = post.title
            haml :post, :locals => { :post => post }
          end

          get '/past/:year/:month/:day/:slug' do
            redirect "/past/#{params[:year]}/#{params[:month]}/#{params[:day]}/#{params[:slug]}/", 301
          end

          get '/past' do
            posts = Post.reverse_order(:created_at)
            @title = "Archive"
            haml :archive, :locals => { :posts => posts }
          end

          get '/past/tags/:tag' do
            tag = params[:tag]
            posts = Post.filter(:tags.like("%#{tag}%")).reverse_order(:created_at).limit(30)
            @title = "Posts tagged #{tag}"
            haml :tagged, :locals => { :posts => posts, :tag => tag }
          end

          get '/feed' do
            @posts = Post.reverse_order(:created_at).limit(20)
            content_type 'application/atom+xml', :charset => 'utf-8'
            builder :feed
          end

          get '/rss' do
            redirect '/feed', 301
          end

          ### Admin

          get '/auth' do
            haml :auth
          end

          post '/auth' do
            response.set_cookie(settings.blog.admin_cookie_key, settings.blog.admin_cookie_value) if params[:password] == settings.blog.admin_password
            redirect '/'
          end

          get '/posts/new' do
            auth
            haml :edit, :locals => { :post => Post.new, :url => '/posts' }
          end

          post '/posts' do
            auth
            post = Post.new :title => params[:title], :tags => params[:tags], :body => params[:body], :created_at => Time.now, :slug => Post.make_slug(params[:title])
            post.save
            redirect post.url
          end

          get '/past/:year/:month/:day/:slug/edit' do
            auth
            post = Post.filter(:slug => params[:slug]).first
            stop [ 404, "Page not found" ] unless post
            haml :edit, :locals => { :post => post, :url => post.url }
          end

          post '/past/:year/:month/:day/:slug/' do
            auth
            post = Post.filter(:slug => params[:slug]).first
            stop [ 404, "Page not found" ] unless post
            post.title = params[:title]
            post.tags = params[:tags]
            post.body = params[:body]
            post.save
            redirect post.url
          end
        end

      end
    end
  end
end