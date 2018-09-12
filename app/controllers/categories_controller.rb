class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :has_access, except: [:show, :index]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format| # TODO FL erre csak akkor van szükség, ha többféleképpen is tud válaszolni az action
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' } # TODO FL I18n?
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def has_access
      unless current_user && current_user.admin?
        redirect_to categories_path
        flash[:danger] = "You don't have rights to do this"
      end
    end
end
