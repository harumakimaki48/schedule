require 'rails_helper'

RSpec.describe "Outfits", type: :request do
  let!(:user) { create(:user) }
  let!(:room) { create(:room, user: user) }
  let!(:outfit) { create(:outfit, user: user, room: room) }

  before do
    post login_path, params: { user_number: user.user_number, password: "password" }
    follow_redirect!
  end

  describe "GET /rooms/:room_id/outfits" do
    it "returns a successful response and lists outfits" do
      get room_outfits_path(room)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Casual Outfit")
    end
  end

  describe "POST /rooms/:room_id/outfits" do
    context "with valid attributes" do
      let(:valid_attributes) do
        {
          outfit: {
            name: "Vacation Outfit",
            headband_image: fixture_file_upload('spec/fixtures/files/headband.jpg', 'image/jpg'),
            clothing_image: fixture_file_upload('spec/fixtures/files/clothing.jpg', 'image/jpg'),
            bag_image: fixture_file_upload('spec/fixtures/files/bag.jpg', 'image/jpg'),
            shoes_image: fixture_file_upload('spec/fixtures/files/shoes.jpg', 'image/jpg')
          }
        }
      end

      it "creates a new outfit and redirects" do
        post room_outfits_path(room), params: valid_attributes
        expect(response).to redirect_to(room_outfits_path(room))
        follow_redirect!
        expect(response.body).to include("Vacation Outfit")
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) do
        {
          outfit: { name: "" }
        }
      end

      it "re-renders the new form with errors" do
        post room_outfits_path(room), params: invalid_attributes
        expect(response.body).to include("エラーが発生しました")
      end
    end
  end

  describe "PUT /rooms/:room_id/outfits/:id" do
    let(:updated_attributes) do
      { outfit: { name: "Updated Outfit" } }
    end

    it "updates the outfit and redirects" do
      put room_outfit_path(room, outfit), params: updated_attributes
      expect(response).to redirect_to(room_outfits_path(room))
      follow_redirect!
      expect(response.body).to include("Updated Outfit")
    end
  end

  describe "DELETE /rooms/:room_id/outfits/:id" do
    it "deletes the outfit and redirects" do
      expect {
        delete room_outfit_path(room, outfit)
      }.to change(Outfit, :count).by(-1)
      expect(response).to redirect_to(room_outfits_path(room))
      follow_redirect!
      expect(response.body).to_not include("Casual Outfit")
    end
  end
end
