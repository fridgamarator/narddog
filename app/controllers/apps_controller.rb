class AppsController < ApplicationController
    before_filter :authenticate_user!

    respond_to :html, :js

    def index
        @apps = App.all
    end

    def new
        @app = App.new
    end

    def create
        @app = App.new(params[:app])
        if @app.save
            redirect_to apps_path
        else
            render 'edit'
        end
    end

    def edit
        @app = App.find params[:id]
    end

    def update
        @app = App.find params[:id]
        if @app.update_attributes params[:app]
            redirect_to apps_path
        else
            render 'edit'
        end
    end

    def destroy
        @app = App.find(params[:id])
        @app.destroy

        respond_with @app
    end
end
