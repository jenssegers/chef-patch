resource_name 'append_line'
actions :run
default_action :run

property :name, :name_property => true, :kind_of => String, :required => true
property :file, :kind_of => String
property :path, :kind_of => String
property :line, :kind_of => String, :required => true

action :run do

	file_path = file || path || name

	# Check if we got a regex or a string
	if line.is_a?(Regexp)
		regex = line
	else
		regex = Regexp.new(Regexp.escape(line))
	end

	# Check if file matches the regex
	if ::File.read(file_path) !~ regex

		# Replace the matching text
		converge_by("insert_line_if_no_match #{name}") do
			ruby_block "#{name}" do
				block do
					file = Chef::Util::FileEdit.new(file_path)
					file.insert_line_if_no_match(regex, line)

					# Write to file if something has changed
					if file.unwritten_changes?()
						file.write_file

						Chef::Log.info "+ #{line}"

						# Notify that a node was updated successfully
						updated_by_last_action(true)

						# Remove backup file
						::File.delete(file_path + ".old") if ::File.exist?(file_path + ".old")
					end
				end
			end
		end
	end
end
