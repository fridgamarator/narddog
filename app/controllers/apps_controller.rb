class AppsController < ApplicationController
    # require "#{Rails.root}/lib/ssh/ssh_check"

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
            render 'new'
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

    # Verify app has ssh access
    def verify
        @app = App.find params[:id]
        @response = @app.check_key

        if @response
            @app.update_attributes(ssh_verified: true)
        end

        respond_with @response, @app
    end

    # Get the app's version
    def get_version
        @app = App.find params[:id]
        @response = @app.get_version

        if @response
            @app.update_attributes(rails_version: @response)
        end

        respond_with @response, @app
    end
end