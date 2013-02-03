class BackupsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :format_date, only: [:create, :update]

    respond_to :js, :html

    def index
        @backups = Backup.all
    end

    def new
        @backup = Backup.new
    end

    def create
        @backup = Backup.new params[:backup]
        if @backup.save
            redirect_to backups_path
        else
            render 'new'
        end
    end

    def edit
        @backup = Backup.find params[:id]
    end

    def update
        @backup = Backup.find params[:id]
        if @backup.update_attributes params[:backup]
            redirect_to backups_path
        else
            render 'edit'
        end
    end

    def destroy
        @backup = Backup.find params[:id]
        @backup.destroy

        respond_with @backup
    end

    def run_backup
        require "#{Rails.root}/lib/run_backups.rb"
        @backup = Backup.find params[:id]

        RunBackups.run_backup(@backup)

        render nothing: true
    end

    private

    def format_date
        if params[:backup][:date] && params[:backup][:time]
            params[:backup][:schedule_time] = DateTime.parse(params[:backup][:date] + ' ' + params[:backup][:time])
            params[:backup].delete(:date)
            params[:backup].delete(:time)
        end
    end
end
