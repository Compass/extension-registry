class ExtensionsController < ApplicationController
  def index
    @extensions = Extension.page(params[:page]).per(12)
  end

  def show
    
  end

end
