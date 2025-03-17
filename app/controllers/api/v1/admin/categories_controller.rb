module Api
  module V1
    module Admin
      class Api::V1::Admin::CategoriesController < ApplicationController
        before_action :authenticate_user! #user is logge in 
        before_action :authorize_admin #admins can access

        def create #admin creates new category
          category = Category.new(category_params)
          authorize category #pundit permission admin permission

          if category.save
            render json: category, status: :created
          else
            render json: { error: category.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update #admin updates an existing category
          category = Category.find(params[:id])
          authorize category #ensure only admin can update

          if category.update(category_params)
            render json: category
          else
            render json: { error: category.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy #admin can delete a category
          category = Category.find(params[:id])
          category.destroy
          render json: { message: "Category deleted" }
        end

        private

        def authorize_admin #admin access to controller
          render json: { error: "Unauthorized" }, status: :unauthorized unless current_user.admin?
        end

        def category_params #permitted field
          params.permit(:name, :points_per_dollar)

      end
    end
  end
end 
