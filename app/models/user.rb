class User < ApplicationRecord
    has_many :participants, foreign_key: :userId
    has_many :events, through: :participants
    has_one :event, foreign_key: :ownerId
    validates :email, uniqueness: true, presence: true
    validates :username, :password, presence: true
end
