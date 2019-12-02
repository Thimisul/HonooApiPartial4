class Event < ApplicationRecord
  belongs_to :eventType, class_name: :EventType, foreign_key: :eventTypeId
  belongs_to :owner, class_name: :User, foreign_key: :ownerId
  has_many :participants, foreign_key: :eventoId
  has_many :users, through: :participants



  Reducer = Rack::Reducer.new( #pesquisa com todos ou alguns parametros
    self.all,
    ->(rdate:) { by_date(rdate) },
    ->(start_date:) {where("startDate >= ?", start_date)}, #time.now toda pesquisa comeca com a hora de inicio da requisicao
    ->(end_date:) {where("endDate <= ?", end_date)},
    ->(user_id:) { where(owerId: user) },
    ->(event_type:) {where(eventTypeId: event_type)}
  )
  scope :by_date, lambda { |rdate|
    if rdate == "hoje"
      where(startDate:  (Time.now.midnight)..Time.now.midnight + 1.day)
    else if rdate =="proximasemana"
      where(startDate:  (Time.now.midnight)..Time.now.midnight + 7.day)
    end
  end
  }
end
