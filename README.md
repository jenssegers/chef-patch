# Patch Cookbook

[![Build Status](https://img.shields.io/cookbook/v/patch.svg)](https://supermarket.chef.io/cookbooks/patch) [![Build Status](https://travis-ci.org/jenssegers/chef-patch.svg?branch=master)](https://travis-ci.org/jenssegers/chef-patch)

Some handy Chef resources for when you want to append, replace or delete and lines in files.

## Requirements

### Platforms

- All platforms supported by Chef

### Chef

- Chef 12.5+

### Cookbooks

- none

## Resources

### replace

Search the file line by line and match each line with the given regex if matched, replace the match (all occurances) with the replace parameter.

```ruby
replace "/etc/sysctl.conf" do
  replace "#net.ipv4.ip_forward=1"
  with    "net.ipv4.ip_forward=1"
end
```

Or with a regex:

```ruby
replace "/etc/sysctl.conf" do
  replace /^.*ip_forward=.*$/
  with    "net.ipv4.ip_forward=1"
end
```

## replace_line

Search the file line by line and match each line with the given regex if matched, replace the whole line with the replace parameter.

```ruby
replace_line "/etc/sysctl.conf" do
  replace "vm.swappiness"
  with    "vm.swappiness=60"
end
```

Or with a regex:

```ruby
replace_line "/etc/sysctl.conf" do
  replace /.*vm.swappiness.*/
  with    "vm.swappiness=60"
end
```

### append_line

Append a line to a file. It will not append the line if it is in the file already.

```ruby
append_line "/etc/sysctl.conf" do
  line "vm.swappiness=60"
end
```

### insert_line_after

Append a line to a file. It will not append the line if it is in the file already.

```ruby
insert_line_after "/etc/sysctl.conf" do
  line "vm.swappiness=60"
  insert "net.ipv4.ip_forward = 1"
end
```

### delete_line

Delete a line from a file.

```ruby
delete_line "/etc/sysctl.conf" do
  line "vm.swappiness=60"
end
```

Or with a regex:

```ruby
delete_line "/etc/sysctl.conf" do
  line /.*vm.swappiness.*/
end
```

## Resource Propeties

All resources support a `path` property to specify the location of the file if you have to do multiple operations on a file:

```ruby
replace_line "unique_resource_name" do
  replace  "#net.ipv4.ip_forward=1"
  with     "net.ipv4.ip_forward=1"
  path     "/etc/sysctl.conf"
end
```

## License & Authors

```
The MIT License (MIT)

Copyright (c) Jens Segers

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
