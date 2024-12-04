require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let!(:user) { create(:user) }

  before do
    login_as(user) # Helperでユーザーをログインさせる
  end

  describe "GET /rooms/new" do
    it "renders the room creation form" do
      get new_room_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("部屋を作成")
    end
  end

  describe "POST /rooms" do
    context "with invalid attributes" do
      let(:invalid_attributes) { { room: { room_number: "", password: "" } } }

      it "re-renders the room creation form with errors" do
        post rooms_path, params: invalid_attributes
        expect(response).to have_http_status(422) # 修正: :unprocessable_entity を 422 に変更
        expect(response.body).to include("部屋の作成に失敗しました")
      end
    end
  end


    context "with invalid attributes" do
      let(:invalid_attributes) { { room: { room_number: "", password: "" } } }

      it "re-renders the room creation form with errors" do
        post rooms_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("部屋の作成に失敗しました")
      end
    end

  describe "POST /rooms/login_process" do
    let!(:room) { create(:room, user: user) }

    context "with valid room number and password" do
      it "logs the user into the room and redirects to select_date" do
        post login_room_process_path, params: { room_number: room.room_number, password: room.password }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(select_date_room_schedules_path(room))
      end
    end

    context "with invalid room number or password" do
      it "re-renders the login form with an error message" do
        post login_room_process_path, params: { room_number: "wrong", password: "wrong" }
        expect(response.body).to include("部屋番号またはパスワードが間違っています")
      end
    end
  end
end
