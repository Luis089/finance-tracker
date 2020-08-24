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

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.name} wurde von Liste entfernt."
    redirect_to my_portfolio_path
  end
end
