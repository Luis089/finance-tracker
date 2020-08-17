class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: "users/result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Symbol nicht bekannt, bitte valides Symbol eingeben"
          format.js { render partial: "users/result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Bitte Symbol (Kürzel) eingeben, z.B. 'GOOGL' für Google."
        format.js { render partial: "users/result" }
      end
    end
  end
end
