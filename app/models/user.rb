class User < ApplicationRecord
  before_create :set_serial
  mount_uploader :avatar, AvatarUploader
  attr_accessor :remember_token
  validates :name, presence: true, uniqueness: true
  validates :email, format: { with: /\A[a-z0-9.]+@([a-z0-9]+\.)+[a-z]+\z/ }, uniqueness: true
  has_secure_password
  validates :password, confirmation: true, format: { with: /\A(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}\z/ }
  validates :password_confirmation, presence: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    remember_digest.nil? ? false : BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def to_param
    serial
  end

  private
  def set_serial
    loop do
      self.serial = SecureRandom.uuid
      break unless User.where(serial: serial).exists?
    end
  end
end
