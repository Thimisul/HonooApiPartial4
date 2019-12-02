class Msg < ApplicationRecord
    belongs_to :participant, class_name: :Participant, foreign_key: :participantId
end
