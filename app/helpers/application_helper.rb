module ApplicationHelper

	# Sign in or out link based on signed in status
	def sign_in_out
		content_tag :li do
			if user_signed_in?
				link_to 'sign out', destroy_user_session_path, method: 'delete'
			else
				html = link_to 'sign in', new_user_session_path
			end
		end
	end

	# Delete and Edit actions for list item objects
	def item_actions(that)
		html = link_to 'Delete', that, method: :delete, remote: true, class: 'btn btn-danger', confirm: "Are you sure?"
		html += link_to 'Edit', polymorphic_path(that, action: :edit), class: 'btn btn-primary'
	end

	# current / safe rails version
	def current_version
		require "#{Rails.root}/lib/get_current_version.rb"
		GetCurrentVersion.current_rails_version
	end
end
