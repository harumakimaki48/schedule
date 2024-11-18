class UsersRoomsController < ApplicationController
    before_action :set_room
  before_action :set_user_room, only: [ :destroy ]

  # 部屋内のユーザー一覧を表示
  def index
    @users = @room.users
  end

  # 部屋内のユーザーを削除
  def destroy
    if @room.users.destroy(@user)
      redirect_to room_users_rooms_path(@room), notice: "#{@user.user_name} を削除しました"
    else
      redirect_to room_users_rooms_path(@room), alert: "ユーザーの削除に失敗しました"
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
