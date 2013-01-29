require 'spec_helper'

describe CloudfileContainer do
	let(:cloudfile_container) { FactoryGirl.create(:cloudfile_container) }

	# Validations
	it { should validate_presence_of(:name) }

	# Associations
end
