class ShopsController < ApplicationController
  before_action :set_shop, only: [ :edit, :update, :destroy ]
  before_action :set_parks_and_areas, only: [ :new, :edit ]

  def index
    @shops = Shop.all
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
    @areas = @shop&.park_id.present? ? Area.where(park_id: @shop.park_id) : []
  end

  def shop_params
    params.require(:shop).permit(:shop_name, :park_id, :area_id, :price, :shop_image)
  end
end
