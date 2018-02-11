module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable
    has_many :users, through: :likes
  end
end
