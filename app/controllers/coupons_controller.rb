class CouponsController < ApplicationController
  before_action :set_coupon, only: %i[edit show update destroy]
  after_action :product_coupon, only: :create

  def index
    @sort_column = params[:sort_column] || 'id'
    @sort_direction = params[:sort_direction] || 'asc'
    @pagy,  @coupons = pagy(Coupon.search(params[:search]).order("#{@sort_column} #{@sort_direction}"))
  end

  def new
    @coupon = Coupon.new
    @products = Product.all
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to coupons_path, flast: { alert: 'Coupon Created' }
    else
      redirect_to coupons_path, flast: { alert: 'Coupon Not Created' }
    end
  end

  def show; end

  def edit; end

  def update
    if @coupon.update(coupon_params)
      redirect_to coupons_path, alert: 'Coupon Updated'
    else
      redirect_to coupons_path, alert: 'Coupon Not Updated'
    end
  end

  def destroy
    if @coupon.destroy
      redirect_to coupons_path, alert: 'Coupon Deleted'
    else
      redirect_to coupons_path, alert: 'Coupon not Deleted'
    end
  end

  def export
    @coupons = Coupon.all
    respond_to do |format|
      format.csv { send_data @coupons.to_csv }
    end
  end

  def product_coupon
    @coupon.products.update_all(coupon_id: @coupon.id)
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :discount_value, product_ids: [])
  end

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end
end
