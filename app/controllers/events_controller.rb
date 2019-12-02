class EventsController < ApplicationController
  before_action :set_event, only: [:updateEvent, :getEventById, :destroy, :getMensagens]

  # POST /event
  def addEvent
    @event = Event.new(event_params)
    if @event.save
      render json: {msg: "salvo!"}, status: :ok, location: @event
    else
      render json: @event.errors, status: :bad_request
    end
  end

    # PATCH/PUT /event/1
    def updateEvent
      if @event.update(event_params)
        @json = { participant: @event.participants.map{|part| {id: part.id, registrationDate: part.registrationDate, username: User.find(part.userId).username}},
          endDate: @event.endDate, 
          city: @event.city,
          street: @event.street,
          description: @event.description,
          id: @event.id,
          neighborhood: @event.neighborhood,
          eventType: @event.eventType,
          title: @event.title,
          user: @event.owner,
          startDate: @event.startDate,
          referencePoint: @event.referencePoint,
          status: @event.status}

          render json: @json, status: :ok

          else
            render json: @event.errors, status: :bad_request
        end
     
    end

  # GET /event
    def getEvent
      @json = []
      if @events = Event.all
      @events.each do |event|
        @json.push({participant: event.participants.map{|part| {id: part.id, registrationDate: part.registrationDate, username: User.find(part.userId).username}}, 
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
                    status: event.status
                    }
        )
      end
        render json: @json, except: [:created_at, :updated_at, :password], status: :ok
      else
        render json: @events.errors, status: :bad_request
      end
    end

  # GET /event/1
  def getEventById
    @json = { participant: @event.participants.map{|part| {id: part.id, registrationDate: part.registrationDate, username: User.find(part.userId).username}}, 
      endDate: @event.endDate, 
      city: @event.city,
      street: @event.street,
      description: @event.description,
      id: @event.id,
      neighborhood: @event.neighborhood,
      eventType: @event.eventType,
      title: @event.title,
      user: @event.owner,
      startDate: @event.startDate,
      referencePoint: @event.referencePoint,
      status: @event.status
    }
    render json: @json, except: [:created_at, :updated_at], status: :ok
  end

  # DELETE /event/1
  def destroy
    if (@event.status == false)
      render json: { message: "Evento jah havia sido Cancelado!"}, status: :ok
    elsif @event.update(status: false) 
      render json: { message: "Evento Cancelado!"}, status: :ok
    else
      render json: @user.status, status: :bad_request
    end
  end

  def searchEvent
      @json = []
      @json.push(participant = [])
      if @events =  Event::Reducer.apply(params)
      @events.each do |event|
      @json.push({
        participant: event.participants.map{|part| {id: part.id, registrationDate: part.registrationDate, username: User.find(part.userId).username}},
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
    end
      render json: @json, except: [:created_at, :updated_at]
  end

   # Get /mensagem/event/1
   def getMensagens
    @json = []
    eventId = params[:id]
            @msgs = Msg.find_by_sql(["
              SELECT 
              msgs.id,
              msgs.messageDate,
              msgs.message as message,
              pes.id as userId,
              pes.username as username
            FROM events e
            JOIN participants pe
            ON e.id = pe.eventoId
            JOIN users pes
            ON pe.userId = pes.id
            JOIN msgs 
            ON msgs.participantId = pe.id
            WHERE e.id  = ?",
            eventId])
           
            @msgs.each do |msg| 
            @json.push({
              id: msg.id,
              messageDate: msg.messageDate,
              message: msg.message,
              userId: msg.userId,
              username: msg.username
            })
          end

            render json: @json.sort_by{|j| j[:messageDate]}, except: [:created_at, :updated_at]
    end
  



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
        
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :startDate, :endDate, :street, :neighborhood, :city, :referencePoint, :description, :eventTypeId, :ownerId, :status)
    end
end
