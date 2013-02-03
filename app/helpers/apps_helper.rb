module AppsHelper

	# verified button
	def app_verification(app)
		if app.ssh_verified
			content_tag :div, "SSH Verified", class: 'verified alert alert-success'
		else
			link_to verify_app_path(app), remote: true do
				content_tag :div, "SSH Not Verified", class: 'verified alert alert-error'
			end
		end
	end

	# rails_version button
	# TODO: create version.yml file to store current rails version and check against it. This todo probably doesnt belong here
	def app_version(app)
		if app.needs_updated == false
			content_tag :div, app.rails_version, class: 'version alert alert-success'
		else
			link_to get_app_version_path(app), remote: true do
				content_tag :div, app.rails_version || "App needs updated", class: 'version alert alert-error'
			end
		end
	end
end
