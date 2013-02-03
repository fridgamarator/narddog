require 'spec_helper'

describe Backup do
	let(:backup) { FactoryGirl.create(:backup) }

	# Associations

	# Validations
	it { should belong_to(:app) }
	it { should belong_to(:cloudfile_container) }
	it { should belong_to(:sftp_storage) }
end
