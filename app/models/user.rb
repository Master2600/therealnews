class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  ROLES = {
    guest: 0,
    author: 1,
    admin: 2
  }.freeze

  before_create :set_default_role

  validates :name, presence: true
  validates :age, presence: true

  has_many :news
  has_many :comments

  def has_role?(role_name)
    role == ROLES[role_name.to_sym]
  end

  def admin?
    role == ROLES[:admin]
  end

  private

  def set_default_role
    self.role ||= 1
  end
end

