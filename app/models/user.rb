class User < ActiveRecord::Base

  has_many :orders

  validates :username, uniqueness: {case_sensitive: false}, presence: true
  validates :email, uniqueness: {case_sensitive: false}, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "only valid email addresses"}
  has_secure_password

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.username  = auth.info.name
        user.image_url = auth.info.image
        user.email     = auth.info.email
        user.password  = auth.credentials.token
        user.save!
      end
    end
end
