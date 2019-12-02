class EventType < ApplicationRecord
    has_many :events, foreign_key: :eventTypeId
end
