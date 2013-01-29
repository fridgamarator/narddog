require 'spec_helper'

describe User do
	let(:user) { FactoryGirl.create(:user) }

	# Validations
	it { should validate_presence_of(:email) }

	# Associations
end
