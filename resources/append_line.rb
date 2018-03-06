resource_name 'append_line'

property :file, String
property :path, String
property :line, String, required: true

action :run do
  file_path = new_resource.file || new_resource.path || new_resource.name

  # Line matching regex
  regex = /^#{Regexp.escape(line)}$/

  # Check if file matches the regex
  if ::File.read(file_path) !~ regex
    # Calculate file hash before changes
    before = Digest::SHA256.file(file_path).hexdigest

    # Do changes
    file = Chef::Util::FileEdit.new(file_path)
    file.insert_line_if_no_match(regex, line)
    file.write_file

    # Notify file changes
    if Digest::SHA256.file(file_path).hexdigest != before
      Chef::Log.info "+ #{line}"
      updated_by_last_action(true)
    end

    # Remove backup file
    ::File.delete(file_path + '.old') if ::File.exist?(file_path + '.old')
  end
end
