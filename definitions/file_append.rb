define :file_append do
  file_path = params[:path] || params[:name]

	ruby_block "#{params[:name]}" do
		block do
			begin
				file = ::File.open(file_path, "a")
				file.puts params[:line]
			ensure
				file.close
			end
		end
		not_if { ::File.exists?(file_path) && ::File.read(file_path) =~ /#{Regexp.escape(params[:line])}/ }

		# Notify listener
		if params[:notifies]
			notifies params[:notifies][0], params[:notifies][1]
		end
	end

end
