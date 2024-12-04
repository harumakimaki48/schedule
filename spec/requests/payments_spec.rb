require 'rails_helper'

RSpec.describe "Payments", type: :request do
  let!(:user) { create(:user) }
  let!(:recipient) { create(:user) }
  let!(:room) { create(:room, user: user) }
  let!(:payment) { create(:payment, room: room, user: user, recipient: recipient) }

  before do
    # ユーザーとしてログイン
    post login_path, params: { user_number: user.user_number, password: "password" }
    follow_redirect!
  end

  describe "GET /rooms/:room_id/payments" do
    it "returns a successful response" do
      get room_payments_path(room)
      expect(response.body).to include("Test Payment")
    end
  end

  describe "POST /rooms/:room_id/payments" do
    context "with valid attributes" do
      let(:valid_attributes) do
        {
          payment: {
            recipient_id: recipient.id,
            amount: 2000,
            content: "New Payment",
            date: Date.today,
            payment_date: Date.today
          }
        }
      end

      it "creates a new payment and redirects" do
        post room_payments_path(room), params: valid_attributes
        expect(response).to redirect_to(room_payments_path(room))
        follow_redirect!
        expect(response.body).to include("支払が追加されました")
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) do
        {
          payment: {
            recipient_id: nil,
            amount: nil,
            content: "",
            date: nil,
            payment_date: nil
          }
        }
      end

      it "re-renders the new form with errors" do
        post room_payments_path(room), params: invalid_attributes
        expect(response.body).to include("エラーが発生しました")
      end
    end
  end

  describe "PUT /rooms/:room_id/payments/:id" do
    let(:updated_attributes) do
      { payment: { amount: 3000, content: "Updated Payment" } }
    end

    it "updates the payment and redirects" do
      put room_payment_path(room, payment), params: updated_attributes
      expect(response).to redirect_to(room_payments_path(room))
      follow_redirect!
      expect(response.body).to include("支払が更新されました")
    end
  end

  describe "DELETE /rooms/:room_id/payments/:id" do
    it "deletes the payment and redirects" do
      expect {
        delete room_payment_path(room, payment)
      }.to change(Payment, :count).by(-1)
      expect(response).to redirect_to(room_payments_path(room))
      follow_redirect!
      expect(response.body).to include("支払が削除されました")
    end
  end
end
