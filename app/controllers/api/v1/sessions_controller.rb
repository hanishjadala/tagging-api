class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json


  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    render status: :ok, json: "User logout successfully"
  end	  
end