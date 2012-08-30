class User < ActiveRecord::Base
  attr_accessible :access_token, :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.id = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
