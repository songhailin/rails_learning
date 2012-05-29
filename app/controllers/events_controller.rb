class EventsController < ApplicationController
  before_filter :find_event,:only=>[:show,:edit,:update,:destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to events_url
      flash[:notice] = "event was successfully created"
    else
      render :action => :new
    end
  end

  def show    
#    @page_title = @event.name
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to event_url(@event)
      flash[:notice] = "event was successfully updated"
    else
      render :action =>:edit
    end

  end

  def destroy
    @event.destroy
    redirect_to :action => :index
    flash[:notice] = "event was successfully deleted"
  end

  protected
  def find_event
    @event = Event.find(params[:id])
  end
end
