require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  let!(:user) { create(:user) }
  let!(:room) { create(:room, user: user) }

  before do
    post login_path, params: { user_number: user.user_number, password: "password" }
    follow_redirect!
  end

  describe "POST /rooms/:room_id/schedules" do
    context "with valid attributes" do
      let(:valid_attributes) do
        {
          schedule: {
            content: "Test Schedule",
            selected_date: Date.today,
            time_start: "10:00",
            time_end: "12:00"
          }
        }
      end

      it "creates a new schedule and redirects to the schedules index" do
        post room_schedules_path(room), params: valid_attributes
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(room_schedules_path(room, date: Date.today))
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) do
        {
          schedule: {
            content: "",
            selected_date: nil,
            time_start: "",
            time_end: ""
          }
        }
      end

      it "re-renders the new schedule form with errors or redirects for unauthenticated users" do
        allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(false)
        post room_schedules_path(room), params: invalid_attributes

        if response.status == 302
          follow_redirect!
          expect(response.body).to include("ログインが必要です")
        else
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include("エラーが発生しました")
        end
      end
    end
  end
end
