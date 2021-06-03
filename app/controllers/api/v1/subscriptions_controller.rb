class Api::V1::SubscriptionsController < ApplicationController

  def index
    @customer = Customer.find(params[:customer_id])
    if params[:status] == "active"
      subscriptions = @customer.subscriptions.active
      render json: SubscriptionSerializer.new(subscriptions), status: :ok
    elsif params[:status] == "canceled"
      subscriptions = @customer.subscriptions.canceled
      render json: SubscriptionSerializer.new(subscriptions), status: :ok
    elsif (params[:status] && params[:status] != "")
      render json: { error: "status can only be canceled or active" }, status: :bad_request
    else
      render json: SubscriptionSerializer.new(@customer.subscriptions), status: :ok
    end
  end

  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      render json: SubscriptionSerializer.new(@subscription), status: :created
    else
      render json: { error: @subscription.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def update
    @subscription = Subscription.find(params[:id])
    if params[:status] == "canceled" || params[:status] == "active"
      @subscription.status = params[:status]
      render json: SubscriptionSerializer.new(@subscription), status: :ok
    else
      render json: { error: "status can only updated to canceled or active" }, status: :bad_request
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end
