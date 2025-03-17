module Api
  module V1
    class BestCardController < ApplicationController
      before_action :authorize_request  

      def best_card
        category_name = params[:category]  #Get category from request

        #finds best cc ppd
        best_cards = current_user.credit_cards
                      .joins(:user_categories)
                      .joins("INNER JOIN categories ON user_categories.category_id = categories.id")
                      .where(categories: { name: category_name })
                      .order("user_categories.points_per_dollar DESC")

        #hgihest ppd
        highest_ppd = best_cards.first&.user_categories&.find_by(category: Category.find_by(name: category_name))&.points_per_dollar

        if highest_ppd
          #responds with cc with highest ppd
          top_cards = best_cards.where("user_categories.points_per_dollar = ?", highest_ppd)

          render json: top_cards.map { |card| 
            { 
              name: card.name, 
              bank: card.bank,
              points_per_dollar: highest_ppd 
            } 
          }
        else
          render json: { message: "No matching category found on any credit card" }
        end
      end
    end
  end
end
