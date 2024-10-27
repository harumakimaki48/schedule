class FoodsController < ApplicationController
    before_action :set_room # Roomをセットする
    before_action :set_food, only: [ :edit, :update, :destroy ]

    def index
      @foods = if params[:park]
                 @room.foods.joins(:shops).where(shops: { park_id: params[:park] })
      else
                 @room.foods
      end
    end

    def new
      @food = @room.foods.new
      @shops = Shop.order(:shop_name) # 昇順でショップを取得
    end

    def create
      @food = @room.foods.new(food_params) # Roomに紐づけてFoodを作成
      @shops = Shop.order(:shop_name) # エラー時の再レンダリングで使用

      respond_to do |format|
        if @food.save
          format.html { redirect_to room_foods_path(@room), notice: "Food was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @shops = Shop.order(:shop_name)
    end

    def update
      if @food.update(food_params)
        redirect_to room_foods_path(@room), notice: "Food was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @food.destroy
      redirect_to room_foods_path(@room), notice: "Food was successfully deleted."
    end

    private

    def set_room
      @room = Room.find(params[:room_id]) # URLのroom_idを使用してRoomを取得
    end

    def set_food
      @food = @room.foods.find(params[:id]) # Roomに紐づいたFoodを取得
    end

    def food_params
      params.require(:food).permit(:menu_name, :price, :favorite, :shop_image, shop_ids: [])
    end
end
