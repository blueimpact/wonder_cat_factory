module MarkdownHelper
  def self.renderer
    @renderer ||= Redcarpet::Render::HTML.new(
      escape_html: true,
      hard_wrap: true,
      xhtml: true
    )
  end

  def self.extensions
    @extensions ||= {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      strikethrough: true,
      space_after_headers: true
    }
  end

  def markdown text
    Redcarpet::Markdown.new(MarkdownHelper.renderer, MarkdownHelper.extensions)
                       .render(text)
                       .html_safe
  end
end
