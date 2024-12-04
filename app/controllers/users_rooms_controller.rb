class UsersRoomsController < ApplicationController
  before_action :set_room
  before_action :set_user_room, only: [ :destroy ]

  def index
    @users = @room.users
  end

  def destroy
    if @room.users.destroy(@user)
      @users = @room.users # 削除後に再取得
      flash[:notice] = "#{@user.user_name} を削除しました"
      render :index # リダイレクトではなく、直接indexビューを再レンダリング
    else
      flash[:alert] = "ユーザーの削除に失敗しました"
      render :index
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_user_room
    @user = @room.users.find(params[:id])
  end
end
