class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db_for_ticker(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker]) #
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Daten von #{stock.name} wurden zum Portfolio hinzugefügt."
    redirect_to my_portfolio_path
  end
end
