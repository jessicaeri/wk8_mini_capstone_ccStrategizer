module Api
  module V1
    class Api::V1::CategoriesController < ApplicationController
      before_action :authorize_request   #current user

      #everyone can view all the categories
      def index
        categories = Category.all
        render json: categories
      end

      #user assigns an existing cat to one of their credit card 
      def assign_category
        category = Category.find(params[:category_id])  #finds an existing category

        user_card = current_user.credit_cards.find(params[:credit_card_id])  #finds the user's credit card

        authorize user_card, :update?  #user modifies their card

        #prevents dupplicate cat
        if user_card.categories.include?(category)
          render json: { message: "Category already exists on this card" }, status: :unprocessable_entity
        else
          UserCategory.create!(credit_card: user_card, category: category, points_per_dollar: params[:points_per_dollar])
          render json: { message: "Category assigned to your credit card" }, status: :created
        end
      end

      #user removes a category from their credit card
      def remove_category
        user_category = UserCategory.find_by(id: params[:id])
        authorize user_category, :destroy?

        if user_category
          user_category.destroy
          render json: { message: "Category removed from your credit card" }
        else
          render json: { error: "Category not found" }, status: :not_found
        end
      end

      #user updates the ppd for a cat on their credit card
      def update_points
        user_category = UserCategory.find(params[:id])
        authorize user_category, :update_points?

        if user_category.update(points_per_dollar: params[:points_per_dollar])
          render json: user_category
        else
          render json: { error: user_category.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
    end
  end
end


