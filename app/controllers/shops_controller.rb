class ShopsController < ApplicationController
  before_action :set_shop, only: [ :edit, :update, :destroy ]
  before_action :set_parks_and_areas, only: [ :new, :edit ]

  def index
    if params[:park_id].present?
      begin
        @shops = Shop.where(park_id: params[:park_id]).order(:shop_name)
        render json: @shops.select(:id, :shop_name)
      rescue => e
        logger.error "Error fetching shops: #{e.message}"
        render json: { error: "Error fetching shops" }, status: 500
      end
    else
      @shops = Shop.all.order(:shop_name)
      render :index # 必要であれば、HTMLビュー用にこの行を維持
    end
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to shops_path, notice: "Shop was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to shops_path, notice: "Shop was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    redirect_to shops_path, notice: "Shop was successfully deleted."
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def set_parks_and_areas
    @parks = Park.all
    @areas = if defined?(@shop) && @shop.present? && @shop.park_id.present?
               Area.where(park_id: @shop.park_id)
    else
               []
    end
  end

  def shop_params
    params.require(:shop).permit(:shop_name, :park_id, :area_id, :price, :shop_image)
  end
end
