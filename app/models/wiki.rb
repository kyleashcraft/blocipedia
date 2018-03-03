class Wiki < ApplicationRecord
  belongs_to :user

  after_initialize :initialize_privacy

  private
    def initialize_privacy
      self.private ||= false
    end
end
