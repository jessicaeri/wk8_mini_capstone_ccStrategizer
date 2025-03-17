class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create]  # ✅ Allows signup without login
  before_action :authenticate_user!, except: [:create]  # ✅ Ensures login isn't required for signup


  def show #user views own profile
    user = User.find(params[:id])
    authorize user #only current user can see their info
    render json:user
  end 

  def create #user signup
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
      )
    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update #user can update profile
    user = User.find(params[:id])
    user.update(
      name: params[:name] || user.name,
      email: params[:email] || user.email ,
      # figure out how to do password update later
      # password: params[:password] || user.password,
      # password_confirmation: params[:password_confirmation]
    )
    render json: user
  end
end
