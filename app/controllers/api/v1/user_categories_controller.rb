module Api
  module V1
    class UserCategoriesController < ApplicationController
      before_action :authorize_request  # ✅ Ensures only authenticated users can modify categories

      def create
        user_category = UserCategory.new(
          credit_card_id: params[:credit_card_id],
          category_id: params[:category_id],
          points_per_dollar: params[:points_per_dollar]
        )

        if user_category.save
          render json: user_category, status: :created
        else
          render json: { errors: user_category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        user_category = UserCategory.find(params[:id])
        authorize user_category

        user_category.destroy
        render json: { message: "Category removed from your credit card" }
      end

      def update_points
        user_category = UserCategory.find(params[:id])
        authorize user_category, :update_points?

        if user_category.update(points_per_dollar: params[:points_per_dollar])
          render json: user_category
        else
          render json: { errors: user_category.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
