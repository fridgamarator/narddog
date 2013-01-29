class CloudfileContainersController < ApplicationController
    before_filter :authenticate_user!

    respond_to :js, :html
    
    def index
        @cloudfile_containers = CloudfileContainer.all
    end

    def new
        @cloudfile_container = CloudfileContainer.new
    end

    def create
        @cloudfile_container = CloudfileContainer.new params[:cloudfile_container]
        if @cloudfile_container.save
            redirect_to cloudfile_containers_path
        else
            render 'new'
        end
    end

    def edit
        @cloudfile_container = CloudfileContainer.find params[:id]
    end

    def update
        @cloudfile_container = CloudfileContainer.find params[:id]
        if @cloudfile_container.update_attributes params[:cloudfile_container]
            redirect_to cloudfile_containers_path
        else
            render 'edit'
        end
    end

    def destroy
        @cloudfile_container = CloudfileContainer.find params[:id]
        @cloudfile_container.destroy

        respond_with @cloudfile_container
    end
end
