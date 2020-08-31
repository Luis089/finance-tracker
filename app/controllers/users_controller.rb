class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: "users/friend_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Freund konnte nicht gefunden werden"
          format.js { render partial: "users/friend_result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Bitte Namen oder E-Mail eines Freundes eingeben."
        format.js { render partial: "users/friend_result" }
      end
    end
  end
end
