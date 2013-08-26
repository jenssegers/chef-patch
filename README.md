Chef Filehelper
===============

Some handy Chef definitions for when you want to replace text and lines in files.

file_replace
------------

Search the file line by line and match each line with the given regex if matched, replace the match (all occurances) with the replace parameter.

	file_replace "/etc/sysctl.conf" do
		replace "#net.ipv4.ip_forward=1"
		with    "net.ipv4.ip_forward=1"
	end

file_replace_line
-----------------

Search the file line by line and match each line with the given regex if matched, replace the whole line with the replace parameter.

	file_replace_line "/etc/sysctl.conf" do
		replace "vm.swappiness"
		with    "vm.swappiness=60"
	end

Attributes
----------

Both definitions support the `notifies` attribute:

	file_replace "/etc/sysctl.conf" do
		replace  "#net.ipv4.ip_forward=1"
		with     "net.ipv4.ip_forward=1"
		notifies :restart, "service[networking]"
	end
