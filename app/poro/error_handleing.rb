module ErrorHandleing
  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def invalid_status
    render json: { error: "status can only be canceled or active" }, status: :bad_request
  end

  def invalid_subscription
    render json: { error: @subscription.errors.full_messages.to_sentence }, status: :bad_request
  end
end
