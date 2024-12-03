require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it "returns http success" do
      get new_user_path
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get new_user_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            user_number: "12345",
            user_name: "Test User",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      it "creates a new user" do
        expect {
          post users_path, params: valid_params
        }.to change(User, :count).by(1)
      end

      it "redirects to the root path" do
        post users_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end

      it "sets a success flash message" do
        post users_path, params: valid_params
        expect(flash[:notice]).to eq("ユーザー登録が完了しました")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            user_number: "",
            user_name: "Test User",
            password: "password",
            password_confirmation: "mismatch"
          }
        }
      end

      it "does not create a new user" do
        expect {
          post users_path, params: invalid_params
        }.not_to change(User, :count)
      end

      it "renders the new template" do
        post users_path, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
end
