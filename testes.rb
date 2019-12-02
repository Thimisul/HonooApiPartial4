        @json = []
        @events =  Event.all
        @events.each do |event|
        @json.push({participant: @parti = event.participants.each{ |part| {id: part.id,
                                                                 registrationDate: part.registrationDate,
                                                                 username: part.user.username}},
                                                                 endDate: event.endDate, 
                                                                 city: event.city,
                                                                 street: event.street,
                                                                 description: event.description,
                                                                 id: event.id,
                                                                 neighborhood: event.neighborhood,
                                                                 eventType: event.eventType,
                                                                 title: event.title,
                                                                 user: event.owner,
                                                                 startDate: event.startDate,
                                                                 referencePoint: event.referencePoint,
                                                                 status: event.status})
            
        end
        render json: @json, except: [:created_at, :updated_at]

       })



       @Events = Msg.find_by_sql(["
        SELECT 
        msgs.id,
        msgs.date as messageData,
        msgs.message as message,
        pes.id as userId,
        pes.username as username
      FROM events e
      JOIN participants part
      ON e.id = part.eventoId
      JOIN users us
      ON part.userId = us.id
      JOIN msgs 
      ON msgs.participantId = part.id
      WHERE e.id  = ?",
      eventId])


      SELECT * FROM events e 
      JOIN participants part
      ON e.id = part.eventoId
      JOIN users us
      On part.userId = us.id


      EventType.create(name: "caminhada")
      EventType.create(name: "nataçao")
      EventType.create(name: "futebol")
      EventType.create(name: "corrida")
      EventType.create(name: "Basquete")


      Event.first.participants.joins(:user, :event).collect
      {|part| ({participant: {username: part.user.username,id: part.id,registrationDate: part.registrationDate}
      ,id: part.event.id})}

      @author = Author.first
@author.authorships.collect { |a| a.book } # selects all books that the author's authorships belong to
@author.books