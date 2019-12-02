
@events = Event.all

@aux = []

def getusers
    @events.each do |event|
        @participants = event.participants
            @participants.each do |participant|
               @aux.push({
                "participant": [
                  {
                    "id": participant.id,
                    "username": participant.user.username,
                    "registrationDate": participant.registrationDate
                  }
                ],
                "endDate": event.endDate,
                "city": event.city,
                "street": event.street,
                "description": event.description,
                "id": event.id,
                "neighborhood": event.neighborhood,
                "eventType": {
                  "name": event.eventType.name,
                  "id": event.eventType.id
                },
                "title": event.title,
                "user": {
                  "birthdate": event.owner.birthdate,
                  "sex": event.owner.sex,
                  "id": event.owner.id,
                  "email": ecent.owner.email,
                  "username": event.owner.username
                },
                "startDate": event.startDate,
                "referencePoint": event.referencePoint,
                "status": event.status
              })
            end
        end
    end
end