class MessagesController < ApplicationController
 before_action :authenticate_user!

 def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to room_path(@message.room_id)
    else
      @room = @message.room
      @messages = @room.messages.all
      @entries = @room.entries
      @another_entry = @room.entries.find_by('user_id != ?', current_user.id)
      render 'rooms/show'
    end
  end

 private

 def message_params
    params.require(:message).permit(:user_id, :room_id, :body).merge(user_id: current_user.id)
 end

end