require 'rails_helper'

RSpec.describe "UsersRooms", type: :request do
  let!(:user) { create(:user) }
  let!(:room) { create(:room, user: user) }
  let!(:other_user) { create(:user) }

  before do
    room.users << other_user
    post login_path, params: { user_number: user.user_number, password: "password" }
    follow_redirect!
  end

  describe "GET /rooms/:room_id/users_rooms" do
    it "returns a successful response and lists all users in the room" do
      get room_users_rooms_path(room)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(user.user_name, other_user.user_name)
    end
  end
end
