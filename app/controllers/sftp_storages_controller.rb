class SftpStoragesController < ApplicationController
    before_filter :authenticate_user!

    respond_to :js, :html

    def index
        @sftp_storages = SftpStorage.all
    end

    def new
        @sftp_storage = SftpStorage.new
    end

    def create
        @sftp_storage = SftpStorage.new(params[:sftp_storage])
        if @sftp_storage.save
            redirect_to sftp_storages_path
        else
            render 'new'
        end
    end

    def edit
        @sftp_storage = SftpStorage.find params[:id]
    end

    def update
        @sftp_storage = SftpStorage.find params[:id]
        if @sftp_storage.update_attributes params[:sftp_storage]
            redirect_to sftp_storages_path
        else
            render 'edit'
        end
    end

    def destroy
        @sftp_storage = SftpStorage.find params[:id]
        @sftp_storage.destroy

        respond_with @sftp_storage
    end
end
