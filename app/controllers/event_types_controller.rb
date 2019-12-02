class EventTypesController < ApplicationController

  # GET /event_types
  def getEventType
    if @event_types = EventType.all
      render json: @event_types, only: [:id, :name], status: :ok
    else
      render json: @event_type.erros, status: :bad_request
    end
  end
end
