module ArticlesHelper
  require './lib/blog_render.rb'

  OPTIONS = {
    filter_html: true,
    hard_wrap: true,
    space_after_headers: true
  }

  EXTENSIONS = {
    autolink: true,
    fenced_code_blocks: true,
    lax_spacing: true,
    no_intra_emphasis: true,
    strikethrough: true,
    superscript: true,
    tables: true
  }.freeze

  def markdown(text)
    renderer = BlogRender.new(OPTIONS)
    @markdown = Redcarpet::Markdown.new(renderer, EXTENSIONS)
    @markdown.render(text).html_safe
  end

end
