Chef Filehelper
===============

Some handy definitions for when you want to replace something in files.

file_replace
------------

Search the file line by line and match each line with the given regex if matched, replace the match (all occurances) with the replace parameter.

	file_replace "/some/file.txt" do
		replace "enabled=FALSE"
		with    "enabled=TRUE"
	end

file_replace_line
-----------------

Search the file line by line and match each line with the given regex if matched, replace the whole line with the replace parameter.

	file_replace_line "/some/file.txt" do
		replace "something"
		with    "new line"
	end
