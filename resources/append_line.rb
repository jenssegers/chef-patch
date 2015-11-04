resource_name 'append_line'
actions :run
default_action :run

property :name, :name_property => true, :kind_of => String, :required => true
property :path, :kind_of => String
property :line, :kind_of => String, :required => true

action :run do

	file_path = path || name

	# Check if the file already contains the line
	unless ::File.exists?(file_path) && ::File.read(file_path) =~ /^#{Regexp.escape(line)}$/

		# Append to file
		converge_by("Append #{name}") do
			ruby_block "#{name}" do
				block do
					begin
						file = ::File.open(file_path, "a")
						file.puts line
					ensure
						file.close
					end
				end
			end
		end

		Chef::Log.info "+ #{line}"

		# Notify that a node was updated successfully
		updated_by_last_action(true)

	end
end
