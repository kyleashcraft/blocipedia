class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  after_initialize :initialize_privacy

  private
    def initialize_privacy
      self.private ||= false
    end
end
