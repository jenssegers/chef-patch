resource_name 'replace'
actions :run
default_action :run

property :name, :name_property => true, :kind_of => String, :required => true
property :file, :kind_of => String
property :path, :kind_of => String
property :replace, :kind_of => [String, Regexp], :required => true
property :with, :kind_of => String, :required => true

action :run do

	file_path = file || path || name

	# Check if we got a regex or a string
	if replace.is_a?(Regexp)
		regex = replace
	else
		regex = Regexp.new(Regexp.escape(replace))
	end

	# Check if file matches the regex
	if ::File.read(file_path) =~ regex
		# Calculate file hash before changes
		before = Digest::SHA256.file(file_path).hexdigest

		# Do changes
		file = Chef::Util::FileEdit.new(file_path)
		file.search_file_replace(regex, with)
		file.write_file

		# Notify file changes
		if Digest::SHA256.file(file_path).hexdigest != before
			Chef::Log.info "- #{replace}"
			Chef::Log.info "+ #{with}"
			updated_by_last_action(true)
		end

		# Remove backup file
		::File.delete(file_path + ".old") if ::File.exist?(file_path + ".old")
	end
end
