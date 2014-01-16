# Support whyrun
def whyrun_supported?
  true
end

action :run do
	converge_by("Append #{@new_resource}") do
	  file_path = @new_resource.path || @new_resource.name

		ruby_block "#{@new_resource.name}" do
			block do
				begin
					file = ::File.open(file_path, "a")
					file.puts @new_resource.line
				ensure
					file.close
				end
			end
			not_if { ::File.exists?(file_path) && ::File.read(file_path) =~ /^#{Regexp.escape(@new_resource.line)}$/ }
		end
	end
end
