require 'spec_helper'

describe SftpStorage do
	let(:sftp_storage) { FactoryGirl.create(:sftp_storage) }

	# Validations
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:server_ip) }
	it { should validate_presence_of(:server_path) }
	it { should validate_presence_of(:server_username) }

	# Associations
end
