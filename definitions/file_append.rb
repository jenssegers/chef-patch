define :file_append do

	ruby_block "#{params[:name]}" do
		block do
			begin
				file = ::File.open(params[:name], "a")
				file.puts params[:line]
			ensure
				file.close
			end
		end
		not_if { ::File.exists?(params[:name]) && ::File.read(params[:name]) =~ /#{params[:line]}/ }

		# Notify listener
		if params[:notifies]
			notifies params[:notifies][0], params[:notifies][1]
		end
	end

end
