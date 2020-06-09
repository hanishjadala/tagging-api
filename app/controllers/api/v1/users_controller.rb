class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:update, :disable_user, :destroy, :add_tag, :remove_tag]

  def index
    if params[:search].present?
      users = User.search_filter(params[:search])
    else
      users = User.all.order("first_name ASC") 
  	end
    render status: :ok, json: users
  end

  def create
    user = User.new(user_params)
    if user.save
      render status: :created, json: user
    else
      render status: :unprocessable_entity, json: user.errors.full_messages
    end
  end  

  def update
  	if @user.update(user_params.except(:email))
      render status: :ok, json: @user
  	else
  		render status: :unprocessable_entity, json: @user.errors.full_messages
  	end  	
  end

  def disable_user
    status = @user.is_active
  	if @user.update(is_active: !status)
      render status: :ok, json: @user
  	else
  		render status: :unprocessable_entity, json: @user.errors.full_messages
  	end
  end

  def destroy
  	if @user.destroy
      render status: :ok, json: @user
  	else
  		render status: :unprocessable_entity, json: @user.errors.full_messages
  	end  	
  end

  def sort_field
  	order_fields = ["first_name", "last_name", "email"]
  	order_types = ["DESC", "ASC"]
  	order_type = params[:order_type].upcase
    field = params[:field]
  	if field.blank? || order_type.blank?
      render status: :unprocessable_entity, json: "Sorry required field missing"
  		return  		
  	end
  	if order_fields.exclude?(field)
      render status: :unprocessable_entity, json: "Sorry this field can't sort"
  		return  		
  	end
  	if order_types.exclude?(order_type)
      render status: :unprocessable_entity, json: "Sorry this field can't sort"
  		return  		
  	end  	
  	user = User.all.order("#{field} #{order_type}")
    render status: :ok, json: user
  end

  def add_tag
  	tags = user_params[:tag_list]   	
  	if tags.blank?
  		render status: :unprocessable_entity, json: "Sorry can't add empty tag"
  		return
  	end
  	@user.tag_list.add(tags, parse: true)
  	if @user.save
      render status: :ok, json: @user
  	else
  		render status: :unprocessable_entity, json: @user.errors.full_messages
  	end 
  end 

  def remove_tag
  	tags = user_params[:tag_list]
  	user_tags = @user.tags.pluck(:name)
 	
  	if tags.blank?
  		render status: :unprocessable_entity, json: "Sorry can't remove empty tag"
  		return
  	end
  	@user.tag_list.remove(tags, parse: true)
  	if @user.save
      render status: :ok, json: @user
  	else
  		render status: :unprocessable_entity, json: @user.errors.full_messages
  	end  	
  end 

	private
	def set_user
		@user = User.find_by(id: params[:id])
   	render status: :not_found, json: "User not found" unless @user	
	end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :tag_list)
  end  	
end