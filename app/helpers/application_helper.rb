module ApplicationHelper


  def gem_link(text, name, version=nil)
    if version
      link_to text, "http://rubygems.org/gems/#{name}/versions/#{version}", :target => :_blank
    else
      link_to text, "http://rubygems.org/gems/#{name}", :target => :_blank
    end
  end


end
