class Api::V1::SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      render json: SubscriptionSerializer.new(@subscription), status: :created
    else
      render json: { error: @subscription.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end
