require 'maruku'
require 'syntax/convertors/html'

DB.create_table? :posts do
  primary_key :id
  String :title
  String :body
  String :slug
  String :tags
  DateTime :created_at
end

class Post < Sequel::Model

  def url
    d = created_at
    "/past/#{d.year}/#{d.month}/#{d.day}/#{slug}/"
  end

  def full_url
    Blog.url_base.gsub(/\/$/, '') + url
  end

  def body_html
    to_html(body)
  end

  def summary
    @summary ||= body.match(/(.{200}.*?\n)/m)
    @summary || body
  end

  def summary_html
    to_html(summary.to_s)
  end

  def more?
    @more ||= body.match(/.{200}.*?\n(.*)/m)
    @more
  end

  def linked_tags
    tags.split.inject([]) do |accum, tag|
      accum << "<a href=\"/past/tags/#{tag}\">#{tag}</a>"
    end.join(" ")
  end

  def self.make_slug(title)
    title.downcase.gsub(/ /, '_').gsub(/[^a-z0-9_]/, '').squeeze('_')
  end

  ########

  def to_html(markdown)
    out = []
    noncode = []
    code_block = nil
    markdown.split("\n").each do |line|
      if !code_block and line.strip.downcase == '<code>'
        out << Maruku.new(noncode.join("\n")).to_html
        noncode = []
        code_block = []
      elsif code_block and line.strip.downcase == '</code>'
        convertor = Syntax::Convertors::HTML.for_syntax "ruby"
        highlighted = convertor.convert(code_block.join("\n"))
        out << "<code>#{highlighted}</code>"
        code_block = nil
      elsif code_block
        code_block << line
      else
        noncode << line
      end
    end
    out << Maruku.new(noncode.join("\n")).to_html
    out.join("\n")
  end

  def split_content(string)
    parts = string.gsub(/\r/, '').split("\n\n")
    show = []
    hide = []
    parts.each do |part|
      if show.join.length < 100
        show << part
      else
        hide << part
      end
    end
    [ to_html(show.join("\n\n")), hide.size > 0 ]
  end
end
