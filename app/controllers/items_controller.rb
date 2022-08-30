class ItemsController < ApplicationController

  def index
    if params[:user_id]
      items = User.find(params[:user_id]).items
    else
      items = Item.all
    end
    render json: items, include: :user
    
    rescue ActiveRecord::RecordNotFound => error
      render json: { errors: error.message }, status: :not_found
  end

  def show
    item = Item.find(params[:id])
    render json: item
    rescue ActiveRecord::RecordNotFound => error
      render json: { errors: error.message }, status: :not_found
  end

  def create
    user = User.find(params[:user_id])
    item = Item.create(item_params)
    user.items << item
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

end
