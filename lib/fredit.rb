require 'fredit/version'
if Rails.version < '3.1.0'
  require 'fredit/template30'
else
  require 'fredit/template31'
end
require 'uri'

module Fredit
  extend self

  # customize the fredit links
  LINK_CSS = "margin:0;margin-top:-1em;padding:1px;font-size:10px;background-color:#a3f66c;border:1px solid #666;"
  # customize the default github email address: "#{name} <#{Fredit::FREDIT_EMAIL}>"
  FREDIT_EMAIL = "<name@example.com>"

  def rel_path(path)
    path.sub(Rails.root.to_s + '/', '')
  end

  def rel_paths(paths)
    paths.map {|x| rel_path(x)}
  end

  # TODO change this to be compatible with HAML
  def link(x)
    s = %Q| <a style="#{LINK_CSS}" href="/fredit?file=#{URI.escape(x)}" target="_blank">#{x}</a> |
    s.strip.html_safe
  end

  def entries(glob)
    Dir[glob].entries.map {|e| rel_path(e)}
  end

  def editables
    prefix = File.directory?(Rails.root + 'app/assets') ? 'app/assets' : 'public'
    css = entries(prefix + '/stylesheets/*')
    js = entries(prefix + '/javascripts/*')
    views = entries('app/views/**/*.html.*')
    {:css => css, :views => views, :javascript => js}
  end

  def add_fredit_link(template, s)
    return s unless template_editable?(template)
    if s =~ /^\s*<!DOCTYPE/ && s =~ /<body[^>]*>/
      s.sub(/<body[^>]*>/, '\&' + fredit_link(template))
    else
      fredit_link(template) + s
    end
  end

  def fredit_link(template)
    source_file = Fredit.rel_path template.identifier
    edit_link = "<div style='color:red'>#{Fredit.link(source_file)}</div>".html_safe
  end

  def template_editable?(template)
    template.identifier.index(Rails.root.to_s) == 0 &&
      template.formats &&
      template.formats.include?(:html)
  end


end

require 'fredit/engine'

