require 'spec_helper'

describe App do
	let(:app) { FactoryGirl.create(:app) }

	# Validations
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:server_ip) }
	it { should validate_presence_of(:server_path) }
	it { should validate_presence_of(:server_username) }
	it { should ensure_inclusion_of(:db_type).in_array(['msyql', 'postgresql']) }

	# Associations
	it { should belong_to :cloudfile_container }
	it { should belong_to :sftp_storage }

	it { should have_many(:backups).dependent(:destroy) }
end
