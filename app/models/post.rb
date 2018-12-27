class Post < ApplicationRecord
    has_many :likes
    has_many :replies
    belongs_to :user
end
