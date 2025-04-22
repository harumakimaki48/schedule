class PaymentsController < ApplicationController
  before_action :set_room
  before_action :set_payment, only: [ :edit, :update, :destroy ]

  def index
    if params[:user_id].present?
      @payments = @room.payments.where(user_id: current_user.id, recipient_id: params[:user_id])
                                .includes(:user, :recipient, :schedule)
                                .order(:date)
      @total_amount = @payments.sum(:amount)
      @filtered_user_name = User.find(params[:user_id]).user_name
    else
      @payments = @room.payments.where(user_id: current_user.id) # ログインユーザーが登録した支払いのみ取得
                                .includes(:user, :recipient, :schedule)
                                .order(:date)
      @total_amount = nil
      @filtered_user_name = nil
    end

    @unsettled_payments = @payments.where(status: "未精算")
    @users = @room.users.where.not(id: current_user.id) # current_userを除外
  end


  def new
    @payment = @room.payments.build
    set_form_data
  end

  def create
    @payment = @room.payments.build(payment_params)

    if current_user
      @payment.user_id = current_user.id
    else
      redirect_to login_path, alert: "ログインが必要です" and return
    end

    Rails.logger.debug "Payment Params: #{payment_params.inspect}"
    Rails.logger.debug "Payment Date (before save): #{@payment.payment_date}"

    begin
      if @payment.save!
        redirect_to room_payments_path(@room), notice: "支払が追加されました"
      else
        set_form_data
        render :new
      end
    rescue ActiveRecord::RecordInvalid => e
      set_form_data
      flash[:alert] = "エラーが発生しました: #{e.message}"
      render :new
    end
  end

  def edit
    set_form_data
  end

  def update
    # レシート画像削除チェック
    if params[:payment][:remove_receipt_image] == "1"
      @payment.receipt_image.purge if @payment.receipt_image.attached?
    end

    if @payment.update(payment_params)
      redirect_to room_payments_path(@room), notice: "支払が更新されました"
    else
      set_form_data
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to room_payments_path(@room), notice: "支払が削除されました"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_payment
    @payment = @room.payments.find(params[:id])
  end

  def set_form_data
    @users = @room.users.where.not(id: current_user.id) # current_userを除外
    @dates = (@room.date_start..@room.date_end).to_a
  end

  def payment_params
    params.require(:payment).permit(:user_id, :recipient_id, :schedule_id, :amount, :content, :status, :date, :receipt_image, :payment_date)
  end
end
