class ExtensionsController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, :with => :handel_not_found_error

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :get_extension, :only => [:edit, :update, :destroy]
  before_filter :current_user_owns_extension?, :only => [:edit, :update, :destroy]
  
  def index
    @extensions = Extension.page(params[:page]).per(12)
  end

  def new
    @extension = Extension.new
  end
  
  def edit;end
  
  def destroy
    @extension.destroy
    redirect_to root_path, :notice => t('extension.destroyed')
  end
  
  def update    
    if @extension.update_attributes(params[:extension])
      redirect_to extension_path(@extension), :notice => t('extension.updated')
    else
      render :edit
    end
  end
  
  def create
    @extension = Extension.new(params[:extension].merge(:user => current_user))
    if @extension.save
      redirect_to extension_path(@extension), :notice => t('extension.created')
    else
      render :new
    end
  end
  
  def show;end
  
  private
  
  def get_extension
    @extension = Extension.find(params[:id])
  end
  
  def current_user_owns_extension?
    unless current_user.id == @extension.user_id
      redirect_to root_path, :alert => t('extension.invalid_permissions')
      return false
    end
  end
  
  def handel_not_found_error
    redirect_to root_path, :alert => t('extension.not_found')
  end

end
