class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles
  enum role: [:admin, :user]
  after_initialize :set_default_role, :if => :new_record?


  def set_default_role
    self.role ||= :user
  end

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
