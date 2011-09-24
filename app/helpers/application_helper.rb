module ApplicationHelper
  
  def title(yielded_title)
    default = t("global.title")
    [default, yielded_title].compact.join(' | ')
  end
  
end
