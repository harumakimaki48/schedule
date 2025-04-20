class PagesController < ApplicationController
    def how_to_use_guest  # ログイン前
    end

    def how_to_use  # ログイン後
        @room = Room.find(params[:id])
      end
end
