class Api::V1::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:update, :destroy]

  def index
  	tags = ActsAsTaggableOn::Tag.all.order("name ASC")

    render status: :ok, json: tags
  end

  def create   	
    tag = ActsAsTaggableOn::Tag.new(tag_params)
    if tag.save
      render status: :ok, json: tag
  	else
  		render status: :unprocessable_entity, json: tag.errors.full_messages  	
    end
  end

  def update
  	if @tag.update(tag_params)
      render status: :ok, json: @tag
  	else
  		render status: :unprocessable_entity, json: @tag.errors.full_messages
  	end
  end

  def destroy
  	if @tag.destroy
      render status: :ok, json: "Tag deleted"
  	else
  		render status: :unprocessable_entity, json: @tag.errors.full_messages
  	end  	  	
  end

  def sort_field
  	order_fields = ["name"]
  	order_types = ["DESC", "ASC"]
    field = params[:field].downcase
    order_type = params[:order_type].upcase	
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
  	tags = ActsAsTaggableOn::Tag.order("#{field} #{order_type}")
    render status: :ok, json: tags
  end  


	private

  def set_tag
    @tag = ActsAsTaggableOn::Tag.find_by_id(params[:id])
   	render status: :not_found, json: "Tag not found" unless @tag
  end

  def tag_params
    params.require(:acts_as_taggable_on_tag).permit(:name)
  end
end