resource_name 'insert_line_after'

property :file, String
property :path, String
property :line, [String, Regexp], required: true
property :insert, String, required: true

action :run do

	file_path = file || path || name

	# Check if we got a regex or a string
	if line.is_a?(Regexp)
		regex = line
	else
		regex = Regexp.new(Regexp.escape(line))
	end

	# Check if file matches the regex
	if ::File.read(file_path) =~ regex
		# Calculate file hash before changes
		before = Digest::SHA256.file(file_path).hexdigest

		# Do changes
		file = Chef::Util::FileEdit.new(file_path)
		file.insert_line_after_match(regex, insert)
		file.write_file

		# Notify file changes
		if Digest::SHA256.file(file_path).hexdigest != before
			Chef::Log.info "+ #{insert}"
			updated_by_last_action(true)
		end

		# Remove backup file
		::File.delete(file_path + ".old") if ::File.exist?(file_path + ".old")
	end
end
