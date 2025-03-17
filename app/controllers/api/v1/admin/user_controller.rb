module Api 
  module V1
    module Admin
      class Api::V1::Admin::UsersController < ApplicationController
        before_action :authenticate_user!
        before_action :authorize_request

        def index #admin can see all users
          render json: User.all
        end 

        def update #admin can update user info
          user = User.find(params[:id])
          if user.update(
            name: params[:name] || user.name,
            email: params[:email] || user.email ,
            )
            render json: user 
          else 
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
          end
        end 

        def destroy #ONLY admin can delete user account
          user = User.find(params[:id])
          user.destroy
          render json: { message: "User deleted" }
        end

      end
    end
  end
end

