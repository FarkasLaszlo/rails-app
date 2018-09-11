class User < ApplicationRecord
  before_create :set_serial
  before_create :set_default_level
  enum level: [:user, :vip, :admin]

  mount_uploader :avatar, AvatarUploader

  attr_accessor :remember_token, :current_password, :password_change

  # VALIDATIONS
  validates :name, presence: true, uniqueness: true
  validates :email, format: { with: /\A^([a-z0-9-]+(\.[a-z0-9-]+)*)@(([a-z\-0-9]+\.)+[a-z]{2,})\z/ }, uniqueness: true
  has_secure_password
  validates :password, confirmation: true, presence: true, format: { with: /\A(?=.*[_?%+|@&#])(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}\z/ }, if: :password_validation_required?
  validates :password_confirmation, presence: true, if: :password_validation_required?
  validates :level, presence: true, on: :update, unless: :password_change?
  validate :current_password_is_correct, if: :password_change?

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def set_default_level
    self.level = :user
  end

  def password_validation_required?
    password_change || password_digest_changed?
  end

  def password_change?
    password_change
  end

  def current_password_is_correct
    user = User.find_by serial: serial
    unless user.authenticate(current_password)
      errors.add :current_password, "field can't be empty"
    end
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
