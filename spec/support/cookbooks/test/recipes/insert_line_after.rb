insert_line_after '/test1' do
  line 'test'
  insert 'tested'
end

insert_line_after 'test2' do
  path '/test2/path.txt'
  line '/test/'
  insert 'tested'
end

insert_line_after 'test3' do
  action :nothing
end
