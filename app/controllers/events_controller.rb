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
        render json: @event, status: :ok
      else
        render json: @event.errors, status: :bad_request
      end
    end
  # GET /event
    def getEvent
      @json = []
      if @events = Event.all
      @events.each do |event|
        @json.push({ participant: event.participants,            
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
    render json: @event, except: [:created_at, :updated_at], status: :ok
  end

  # DELETE /event/1
  def destroy
    if @event.update(status: false) 
      render json: {msg: "Evento Excluido!" }, status: :ok
    else
      render json: @event.errors, status: :bad_request
    end
  end

  def searchEvent
      @json = []
      if @events =  Event::Reducer.apply(params)
      @events.each do |event|
        @json.push({ participant: event.users, 
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
              msgs.date as messageData,
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
              messageData: msg.messageData,
              message: msg.message,
              userId: msg.userId,
              username: msg.username
            })
          end

            render json: @json.sort_by{|j| j[:messageData]}, except: [:created_at, :updated_at]
    end
  



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      if event = Event.find(params[:id])
        @event = { participant: event.users, 
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
      else
        render json: @event.errors, status: :bad_request
      end
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :startDate, :endDate, :street, :neighborhood, :city, :referencePoint, :description, :eventTypeId, :ownerId, :status)
    end
end
