class ExtensionsController < ApplicationController
  
  respond_to :html, :json
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    respond_with(@extensions = scope_lookup(Extension.order("created_at DESC")))
  end

  def new
    @extension = Extension.new(:user => current_user)
  end

  def create
    @extension = Extension.new(params[:extension].merge(:user => current_user))
    if @extension.save
      redirect_to extension_path(@extension), :notice => t('extension.created')
    else
      render :new
    end
  end


  private 
  
  def name_conditions(arel)
    name = Extension.arel_table[:name]
    arel.where(name.matches("%#{params[:q]}%"))
  end
  
  def paginate_lookup(arel)
    arel.page(params[:page]).per(12)
  end
  
  def scope_lookup(arel)
    arel = name_conditions(arel) if params[:q]
    arel = paginate_lookup(arel) unless request.format == Mime::JSON
    arel
  end

end
