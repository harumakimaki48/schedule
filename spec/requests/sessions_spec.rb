require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) } # FactoryBotで作成したユーザー

  describe "GET /login" do
    it "renders the login page" do
      get login_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("ログイン")
    end
  end

  describe "POST /login" do
    context "with valid credentials" do
      it "logs in the user and redirects to room login page" do
        post login_path, params: { user_number: user.user_number, password: "password" }
        expect(response).to have_http_status(:found) # リダイレクト
        follow_redirect!
        expect(response.body).to include("部屋番号") # ログイン後のページ確認

        # クッキー確認
        expect(cookies["remember_token"]).not_to be_nil
      end
    end

    context "with invalid credentials" do
      it "re-renders the login page with an error message" do
        post login_path, params: { user_number: user.user_number, password: "wrongpassword" }
        expect(response).to have_http_status(:found)
        follow_redirect!
        expect(response.body).to include("ログインに失敗しました")

        # クッキーが設定されていないことを確認
        expect(cookies["remember_token"]).to be_nil
      end
    end
  end

  describe "DELETE /logout" do
    before do
      post login_path, params: { user_number: user.user_number, password: "password" }
    end

    it "logs out the user and redirects to the root path" do
      delete logout_path
      expect(response).to have_http_status(:found)
      follow_redirect!
      expect(response.body).to include("ログアウトしました")

      # クッキーが削除されていることを確認
      expect(cookies["remember_token"]).to satisfy { |value| value.nil? || value.empty? }
    end
  end
end
