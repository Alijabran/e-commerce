class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update show destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Category Created'
    else
      redirect_to new_category_path, flash: { alert: 'Category Not Created' }
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, flash: { alert: 'Category Updated' }
    else
      redirect_to categories_path, flash: { alert: 'Category Not Updated' }
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, flash: { alert: 'Category Deleted' }
    else
      redirect_to categories_path, flash: { alert: 'Category Not Deleted' }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
