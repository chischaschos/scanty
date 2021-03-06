Scanty::Base.db.create_table? :posts do
  primary_key :id
  String :title
  String :body
  String :slug
  String :tags
  DateTime :created_at
end

module Scanty
  class Post < Sequel::Model

    plugin :validation_helpers


    def url
      d = created_at
      "/past/#{d.year}/#{d.month}/#{d.day}/#{slug}/"
    end

    def full_url
      Scanty.settings.url_base.gsub(/\/$/, '') + url
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

    def make_slug
      self.slug = title.downcase.gsub(/ /, '_').gsub(/[^a-z0-9_]/, '').squeeze('_')
    end

    def to_html(markdown)
      Kramdown::Document.new(markdown).to_html
    end

    def before_save
      make_slug
      super
    end

    def validate
      super
      validates_presence [:title, :created_at, :tags, :body]
    end
  end
end
