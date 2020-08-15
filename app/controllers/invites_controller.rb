class InvitesController < ApplicationController
  before_action :login_required

  def show
    invites = current_user.received_invites
    @events = []
    invites.each do |invite|
      @events << Event.find(invite.event_id)
    end
  end

  def new
    @invite = current_user.sent_invites.new
    @event = Event.find(params[:event_id])
    @invite.invited = @user

    @possible_invites = []
    @possible_invites << User.where.not(id: current_user.id)
  end

  def create
    @invite = Invite.new(invite_params)
    @user = User.find(params[:invite][:invited_id])
    respond_to do |format|
      if @invite.save
        format.html { redirect_to @invite.event, notice: 'Invite was successfully created.' }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invite = Invite.find_by(invited_id: params[:invited_id], event_id: params[:event_id])
    @invite.destroy

    redirect_to root_path
  end

  private

    def invite_params
      params.require(:invite).permit(:invited_id, :inviter_id, :event_id)
    end

    def cannot_invite_self
      user = User.find(params[:user_id])
      if current_user == user
        flash[:info] = "You cannot invite yourself to an event."
        redirect_to root_path
      end
    end
end
