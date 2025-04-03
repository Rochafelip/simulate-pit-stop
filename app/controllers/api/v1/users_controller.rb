class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update, :destroy] # Requer autenticação para essas ações
  
  # Permitir que os parâmetros sejam passados
  before_action :configure_permitted_parameters, if: :devise_controller?

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      # Gerando os tokens para o novo usuário
      @user.create_new_auth_token
      render json: { message: 'Usuário criado com sucesso.', user: @user }, status: :created
    else
      render json: { error: 'Erro ao criar usuário.', details: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { message: 'Usuário atualizado com sucesso.', user: @user }, status: :ok
    else
      render json: { error: 'Erro ao atualizar usuário.', details: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: 'Usuário removido com sucesso.' }, status: :no_content
  end

  private

  # Permitir parâmetros permitidos para o usuário
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  # Permitir parâmetros adicionais para o Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end
  
end
