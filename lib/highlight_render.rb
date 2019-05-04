class HighlightRender < Redcarpet::Render::HTML

  def block_code(code, lang)
    lang = 'md' if lang.nil?
    CodeRay.scan(code, lang).div
  end

end
