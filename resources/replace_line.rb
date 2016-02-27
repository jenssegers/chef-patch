resource_name 'replace_line'
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

		# Replace the line
		converge_by("Replace line #{name}") do
			ruby_block "#{name}" do
				block do
					file = Chef::Util::FileEdit.new(file_path)
					file.search_file_replace_line(regex, with)

					# Write to file if something has changed
					if file.unwritten_changes?()
						file.write_file

						Chef::Log.info "- #{replace}"
						Chef::Log.info "+ #{with}"

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
