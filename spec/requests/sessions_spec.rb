require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }

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
        follow_redirect! # リダイレクト後のレスポンスを確認
        expect(response.body).to include("部屋の前") # 次のページの内容を確認
      end
    end

    context "with invalid credentials" do
      it "re-renders the login page with an error message" do
        post login_path, params: { user_number: user.user_number, password: "wrongpassword" }
        follow_redirect! # リダイレクト後のレスポンスを確認
        expect(response.body).to include("ログインに失敗しました。")
      end
    end
  end

  describe "DELETE /logout" do
    it "logs out the user and redirects to the root path" do
      delete logout_path
      follow_redirect! # リダイレクト後のレスポンスを確認
      expect(response.body).to include("ログアウトしました。")
    end
  end
end
