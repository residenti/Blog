# markdown構文向けの独自のレンダリングクラス
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class BlogRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end
