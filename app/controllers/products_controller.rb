class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update show destroy]
  before_action :authenticate_admin!

  def index
    @sort_column = params[:sort_column] || 'title' || 'price'
    @sort_direction = params[:sort_direction] || 'asc'
    @pagy, @products = pagy(Product.search(params[:search]).order("#{@sort_column} #{@sort_direction}"))
  end

  def new
    @product = Product.new
  end

  def show; end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, alert: 'Product Created!!!'
    else
      redirect_to new_product_path, alert: 'Product Not Created!!!'
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to root_path, alert: 'Product Updated!!!'
    else
      redirect_to edit_product_path, alert: 'Product Not Updated'
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path, alert: 'Product Deleted'
    else
      redirect_to root_path, alert: 'Product Not Deleted'
    end
  end

  def export
    @products = Product.all
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :description, :status)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def authenticate_admin!
    return if current_user.admin?

    redirect_to users_path, alert: 'You are not authorized to perform this action.'
  end
end
