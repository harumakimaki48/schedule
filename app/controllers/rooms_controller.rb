class RoomsController < ApplicationController
    def new
        @room = Room.new
    end

    def create
        @room = Room.new(room_params)
        @room.user = current_user  # 部屋の作成者を現在のユーザーに設定

        if @room.save
          # 作成者を自動的に部屋に追加
          @room.users << current_user
          redirect_to login_room_path, notice: "部屋が作成されました"
        else
          # エラーが発生した場合は、Turboが期待する形式でエラーレスポンスを返す
          flash.now[:alert] = "部屋の作成に失敗しました"
          render :new, status: :unprocessable_entity
        end
    end

    def login
        @room = Room.new  # ログイン画面で新しいRoomオブジェクトを渡す
      end

      def login_process
        @room = Room.find_by(room_number: params[:room_number])

        if @room&.authenticate(params[:password])
          session[:room_id] = @room.id

            # 自動でユーザーを部屋に登録
            if !@room.users.include?(current_user)
                @room.users << current_user  # ユーザーを部屋に追加
            end

            redirect_to select_date_room_schedules_path(@room), notice: "部屋に入りました"
        else
          flash.now[:alert] = "部屋番号またはパスワードが間違っています"
          render :login  # 修正: login_formではなくloginビューを再表示
        end
      end

      def share_link
        @room = Room.find(params[:id])
        # 招待用のURLを生成 (適宜URLを変更)
        @invite_url = "#{root_url}rooms/login?room_number=#{@room.room_number}&password=#{@room.password}"
        render json: { invite_url: @invite_url }
      end

      private

      def room_params
        params.require(:room).permit(:room_number, :password, :date_start, :date_end)
      end
end
