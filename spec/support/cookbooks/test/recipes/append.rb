append_line '/test1' do
  line 'test'
end

append_line 'test2' do
  path '/test2/path.txt'
  line '/test/'
end

append_line 'test3' do
  action :nothing
end
