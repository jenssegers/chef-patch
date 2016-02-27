Patch
=====

[![Build Status](https://img.shields.io/cookbook/v/patch.svg)](https://supermarket.chef.io/cookbooks/patch) [![Build Status](https://travis-ci.org/jenssegers/chef-patch.svg?branch=master)](https://travis-ci.org/jenssegers/chef-patch)

Some handy Chef resources for when you want to append, replace or delete and lines in files.

**WARNING**: Minimum Chef version required is 12.5

replace
-------

Search the file line by line and match each line with the given regex if matched, replace the match (all occurances) with the replace parameter.

	replace "/etc/sysctl.conf" do
		replace "#net.ipv4.ip_forward=1"
		with    "net.ipv4.ip_forward=1"
	end

Or with a regex:

	replace "/etc/sysctl.conf" do
		replace /^.*ip_forward=.*$/
		with    "net.ipv4.ip_forward=1"
	end

replace_line
------------

Search the file line by line and match each line with the given regex if matched, replace the whole line with the replace parameter.

	replace_line "/etc/sysctl.conf" do
		replace "vm.swappiness"
		with    "vm.swappiness=60"
	end

Or with a regex:

	replace_line "/etc/sysctl.conf" do
		replace /.*vm.swappiness.*/
		with    "vm.swappiness=60"
	end

append_line
-----------

Append a line to a file. It will not append the line if it is in the file already.

	append_line "/etc/sysctl.conf" do
		line "vm.swappiness=60"
	end

inser_line_after
-----------

Append a line to a file. It will not append the line if it is in the file already.

	insert_line_after "/etc/sysctl.conf" do
		line "vm.swappiness=60"
		insert "net.ipv4.ip_forward = 1"
	end

delete_line
-----------

Delete a line from a file.

	delete_line "/etc/sysctl.conf" do
		line "vm.swappiness=60"
	end

Or with a regex:

	delete_line "/etc/sysctl.conf" do
		line /.*vm.swappiness.*/
	end

Attributes
----------

All resources support a `path` attribute to specify the location of the file if you have to do multiple operations on a file:

	replace_line "unique_resource_name" do
		replace  "#net.ipv4.ip_forward=1"
		with     "net.ipv4.ip_forward=1"
		path     "/etc/sysctl.conf"
	end

Testing
-------

Basic chefspec testing has been added.  Please include tests with your pull requests.

`bundle install`
`rspec`
