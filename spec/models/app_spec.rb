require 'spec_helper'

describe App do
	let(:app) { FactoryGirl.create(:app) }

	# Validations
	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:server_ip) }
	it { should validate_presence_of(:server_path) }
	it { should validate_presence_of(:server_username) }

	# Associations
end
