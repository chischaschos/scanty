require 'base'

describe Scanty::Post do
  before do
    @post = Scanty::Post.new
  end

  it "has a url in simplelog format: /past/2008/10/17/my_post/" do
    @post.created_at = '2008-10-22'
    @post.slug = "my_post"
    expect(@post.url).to eq  '/past/2008/10/22/my_post/'
  end

  it "has a full url including the Blog.url_base" do
    @post.created_at = '2008-10-22'
    @post.slug = "my_post"
    Scanty.settings.url_base = 'http://blog.example.com/'
    expect(@post.full_url).to eq  'http://blog.example.com/past/2008/10/22/my_post/'
  end

  it "produces html from the markdown body" do
    @post.body = "* Bullet"
    expect(@post.body_html).to eq  "<ul>\n  <li>Bullet</li>\n</ul>\n"
  end

  it "syntax highlights ruby blocks" do
    highlighted_code = <<DOC
<div class=\"highlighter-coderay\"><div class=\"CodeRay\">\n  <div class=\"code\"><pre><span class=\"line-numbers\"><a href=\"#n1\" name=\"n1\">1</a></span>puts <span style=\"background-color:hsla(0,100%,50%,0.05)\"><span style=\"color:#710\">&quot;</span><span style=\"color:#D20\">hi</span><span style=\"color:#710\">&quot;</span></span>\n</pre></div>\n</div>\n</div>
DOC
  expect(@post.to_html("~~~ruby\nputs \"hi\"\n~~~")).to eq highlighted_code
  end

  it "makes the tags into links to the tag search" do
    @post.tags = "one two"
    expect(@post.linked_tags).to eq  '<a href="/past/tags/one">one</a> <a href="/past/tags/two">two</a>'
  end

  it "can save itself (primary key is set up)" do
    @post.title = 'hello'
    @post.body = 'world'
    @post.save
    expect(Scanty::Post.filter(:title => 'hello').first.body).to eq  'world'
  end

  it "generates a slug from the title (but saved to db on first pass so that url never changes)" do
    expect(Scanty::Post.make_slug("RestClient 0.8")).to eq  'restclient_08'
    expect(Scanty::Post.make_slug("Rushmate, rush + TextMate")).to eq  'rushmate_rush_textmate'
    expect(Scanty::Post.make_slug("Object-Oriented File Manipulation")).to eq  'objectoriented_file_manipulation'
  end
end
