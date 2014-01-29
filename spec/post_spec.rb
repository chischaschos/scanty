require 'base'

describe Post do
  before do
    @post = Post.new
  end

  it "has a url in simplelog format: /past/2008/10/17/my_post/" do
    @post.created_at = '2008-10-22'
    @post.slug = "my_post"
    @post.url.should == '/past/2008/10/22/my_post/'
  end

  it "has a full url including the Blog.url_base" do
    @post.created_at = '2008-10-22'
    @post.slug = "my_post"
    Sinatra::Blogging::App.settings.blog.stub!(:url_base).and_return('http://blog.example.com/')
    @post.full_url.should == 'http://blog.example.com/past/2008/10/22/my_post/'
  end

  it "produces html from the markdown body" do
    @post.body = "* Bullet"
    @post.body_html.should == "<ul>\n  <li>Bullet</li>\n</ul>\n"
  end

  it "syntax highlights ruby blocks" do
highlighted_code = <<DOC
<div><div class=\"CodeRay\">\n  <div class=\"code\"><pre><span class=\"line-numbers\"><a href=\"#n1\" name=\"n1\">1</a></span>puts <span style=\"background-color:hsla(0,100%,50%,0.05)\"><span style=\"color:#710\">&quot;</span><span style=\"color:#D20\">hi</span><span style=\"color:#710\">&quot;</span></span>\n</pre></div>\n</div>\n</div>
DOC
    @post.to_html("~~~ruby\nputs \"hi\"\n~~~").should eq highlighted_code
  end

  it "makes the tags into links to the tag search" do
    @post.tags = "one two"
    @post.linked_tags.should == '<a href="/past/tags/one">one</a> <a href="/past/tags/two">two</a>'
  end

  it "can save itself (primary key is set up)" do
    @post.title = 'hello'
    @post.body = 'world'
    @post.save
    Post.filter(:title => 'hello').first.body.should == 'world'
  end

  it "generates a slug from the title (but saved to db on first pass so that url never changes)" do
    Post.make_slug("RestClient 0.8").should == 'restclient_08'
    Post.make_slug("Rushmate, rush + TextMate").should == 'rushmate_rush_textmate'
    Post.make_slug("Object-Oriented File Manipulation").should == 'objectoriented_file_manipulation'
  end
end
