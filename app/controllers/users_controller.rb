class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    render json: user, include: :items
    rescue ActiveRecord::RecordNotFound => error
      render json: { errors: error.message }, status: :not_found
  end

end
