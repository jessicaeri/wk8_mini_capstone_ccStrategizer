module Api
  module V1
    class CreditCardsController < ApplicationController
      before_action :authorize_request #current user

      def index #view alls credit card 
        render json: current_user.credit_cards
      end


      def create #user creates credit card
        card = current_user.credit_cards.new(credit_card_params)
        authorize card  #current user allows

        if card.save
          render json: card, status: :created
        else
          render json: { error: card.errors.full_messages }, status: :unprocessable_entity
        end
      end

      
      def destroy #delete account
        card = current_user.credit_cards.find(params[:id])
        authorize card, :destroy?  #current user allows

        card.destroy
        render json: { message: "Credit card deleted" }
      end

      private

      
      def credit_card_params
        params.permit(:name, :bank, :custom_name)
      end

    end
  end 
end 

