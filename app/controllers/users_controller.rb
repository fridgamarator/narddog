class UsersController < ApplicationController
    before_filter :authenticate_user!

    respond_to :html, :js

    def new
        @user = User.new
    end

    def create
        @user = User.new(params[:user])
        @user.password_confirmation = params[:user][:password]
        if @user.save
            redirect_to users_path
        else
            render 'new'
        end
    end

    def update
    end

    def index
        @users = User.all
    end

    def show
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_with @user
    end

    def edit
        @user = User.find params[:id]
    end
end
