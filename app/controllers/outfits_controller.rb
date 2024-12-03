class OutfitsController < ApplicationController
  before_action :set_room
  before_action :set_outfit, only: [ :edit, :update, :destroy ]

  def index
    if params[:user_id].present?
      @outfits = @room.outfits.where(user_id: params[:user_id]).includes(:user)
      @filtered_user = User.find(params[:user_id])
    else
      @outfits = @room.outfits.includes(:user)
      @filtered_user = nil
    end
    @users = @room.users
  end

  def new
    @outfit = @room.outfits.new
  end

  def create
    @outfit = @room.outfits.new(outfit_params)
    @outfit.user = current_user

    if @outfit.save
      redirect_to room_outfits_path(@room), notice: "登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @outfit.update(outfit_params)
      redirect_to room_outfits_path(@room), notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @outfit.destroy
    redirect_to room_outfits_path(@room), notice: "削除しました"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_outfit
    @outfit = @room.outfits.find(params[:id])
  end

  def outfit_params
    params.require(:outfit).permit(:name, :headband_image, :clothing_image, :bag_image, :shoes_image)
  end
end
