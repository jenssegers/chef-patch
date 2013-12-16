define :file_replace do
  file_path = params[:path] || params[:name]
  replace_regex = Regexp.new(params[:replace])

	ruby_block "#{params[:name]}" do
		block do
			file = Chef::Util::FileEdit.new(file_path)
			file.search_file_replace(
				replace_regex,
				(params[:with] or '')
			)
			file.write_file
		end
		only_if { ::File.read(file_path) =~ replace_regex }
		
		# Notify listener
		if params[:notifies]
			notifies params[:notifies][0], params[:notifies][1]
		end
	end

end