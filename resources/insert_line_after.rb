resource_name 'insert_line_after'
actions :run
default_action :run

property :name, :name_property => true, :kind_of => String, :required => true
property :file, :kind_of => String
property :path, :kind_of => String
property :line, :kind_of => [String, Regexp], :required => true
property :insert, :kind_of => String, :required => true

action :run do

	file_path = file || path || name

	# Check if we got a regex or a string
	if line.is_a?(Regexp)
		regex = line
	else
		regex = Regexp.new(Regexp.escape(line))
	end

	unless ::File.exists?(file_path) && ::File.foreach(file_path).grep(/#{insert}/).size > 0

	# Check if file matches the regex
	if ::File.read(file_path) =~ regex

		# Replace the matching text
		converge_by("insert_line_after #{name}") do
			ruby_block "#{name}" do
				block do
					file = Chef::Util::FileEdit.new(file_path)
					file.insert_line_after(regex, insert)
					file.write_file
				end
			end
		end

		Chef::Log.info "+ #{insert}"

		# Notify that a node was updated successfully
		updated_by_last_action(true)

	end
end
