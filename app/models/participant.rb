class Participant < ApplicationRecord
  belongs_to :event, class_name: :Event, foreign_key: :eventoId
  belongs_to :user, class_name: :User, foreign_key: :userId
  has_many :msgs, foreign_key: :participantId
end
