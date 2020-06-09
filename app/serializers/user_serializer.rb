class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :first_name, :last_name, :email, :is_active, :tag_list
  
  def tag_list
  	object.tags if object.tags.present?
  end
end
