class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wiki

  enum role: [:standard, :premium, :admin]

  after_initialize :initialize_role

  private
    def initialize_role
      self.role ||= :standard
    end
end
