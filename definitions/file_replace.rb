define :file_replace do

	ruby_block "#{params[:name]}" do
		block do
			file = Chef::Util::FileEdit.new(params[:name])
			file.search_file_replace(
				/#{params[:replace]}/,
				(params[:with] or '')
			)
			file.write_file
		end
		only_if { ::File.read(params[:name]) =~ /#{params[:replace]}/ }
		
		# Notify listener
		if params[:notifies]
			notifies params[:notifies][0], params[:notifies][1]
		end
	end

end