require 'spec_helper'

describe Backup do
	let(:backup) { FactoryGirl.create(:backup) }

	# Validations
	it { should validate_presence_of :app_id }

	# Associations
	it { should belong_to(:app) }
	it { should belong_to(:cloudfile_container) }
	it { should belong_to(:sftp_storage) }
end
