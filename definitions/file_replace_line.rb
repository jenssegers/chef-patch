define :file_replace_line do
  file_path = params[:path] || params[:name]

	ruby_block "#{params[:name]}" do
		block do
			file = Chef::Util::FileEdit.new(file_path)
			file.search_file_replace_line(
				/#{params[:replace]}/,
				(params[:with] or '')
			)
			file.write_file
		end
		only_if { ::File.read(file_path) =~ /#{Regexp.escape(params[:replace]})/ }
		
		# Notify listener
		if params[:notifies]
			notifies params[:notifies][0], params[:notifies][1]
		end
	end

end