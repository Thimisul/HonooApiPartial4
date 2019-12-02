class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: [:login, :addUser]


  # POST /users
  def addUser
    @user = User.new(user_params)

    if @user.save
      render json: @user, except: [:created_at, :updated_at, :status], status: :ok, location: @user 
    else
      render json: @user.errors, status: :bad_request #default status: :unprocessable_entity
    end
  end

   # PATCH/PUT /users/1
   def update
    if @user.update(user_params)
      render json: @user, except: [:created_at, :updated_at, :status], status: :ok
    else
      render json: @user.errors, status: :bad_request # status: :unprocessable_entity
    end
  end

   # GET /users/1
   def show
    if(@user.status == true)
      render json: @user, except: [:created_at, :updated_at, :status, :password], status: :ok
    else 
      if(@user.status == false)
        render status: :bad_request
      else
        render json: @user.errors, status: :bad_request
      end
    end
  end

  # DELETE /users/1
  def destroy
    if (@user.status == false)
      render json: { message: "Usuario jah havia sido deletado!"}, status: :ok
    elsif @user.update(status: false) 
      render json: { message: "Usuario deletado!"}, status: :ok
    else
      render json: @user.status, status: :bad_request
    end
  end
 
  # Login /user/login
  def login
    
    command = AuthenticateUser.call(params[:email], params[:password])
    @user =  User.find_by(email: params[:email], password: params[:password], status: true)
    if command.success?
      render json: {token: command.result, user: @user}, except: [:created_at, :updated_at, :status, :password]
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :birthdate, :sex)
    end
end
