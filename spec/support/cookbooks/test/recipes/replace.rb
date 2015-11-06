replace '/test1' do
  replace 'test'
  with 'tested'
end

replace 'test2' do
  path '/test2/path.txt'
  replace /test/
  with 'tested'
end

replace 'test3' do
  action :nothing
end
