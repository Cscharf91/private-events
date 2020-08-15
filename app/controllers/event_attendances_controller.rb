class EventAttendancesController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @event.attendees << current_user
    current_user.received_invites.each do |invite|
      if invite.event_id == @event.id
        current_user.received_invites.destroy(invite)
      end
    end
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])
    @event.attendees.delete(@user)
    redirect_to @event
  end
end