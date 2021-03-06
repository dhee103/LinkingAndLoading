#!/usr/bin/ruby
# simple.rb

#read in input
targetPath = ARGV[0]

# check if argument given; if not then set the target path as current directory
if ARGV.empty?
  targetPath = `pwd`
end

# check if targetPath is valid; if not [TODO] return appropriate message & non-zero exit code
if ARGV.length > 1 || !File.directory?(targetPath.strip)
  puts "you dun goofed son"
  exit 1
end

# check targetDirectory structure that have not been checked into git and split
# into two different arrays using git ls-files
# Using split (on new lines) I then convert the strings into arrays
inGit = `git ls-files`.split(/\n+/)
notInGit = `git ls-files --other`.split(/\n+/)

# parse appropriate data for files under version control and store this data in their appropriate arrays
dates = inGit.map{ |x| `git log --no-merges -n 1 --date=iso-strict --format=%ad -- #{x}`.strip}
revIDs = inGit.map{ |x| `git log --no-merges -n 1 --format=%h -- #{x} | cut -c1-5`.strip}
authors = inGit.map{ |x| `git log --no-merges -n 1 --format=%an -- #{x}`.strip}

# find the longest filepath and then pad appropriately
longest = inGit.max_by(&:length).length
inGit.map!{|x| x.ljust(longest)}

# initialise a 2d array containing arrays of information about target files
underVC = Array.new(inGit.length - 1){Array.new(4)}
for i in 0..inGit.length - 1
  underVC[i] = [dates[i], revIDs[i], inGit[i], authors[i]]
end

# puts "#{underVC}\n\n\n\n\n\n\n"

#sort underVC 2d array by date which gives us an array with arrays containing the files information all sorted by datetime
underVC.sort!{|a,b| b[0] <=> a[0]}

# puts "#{underVC}"

# output the files under version control
for i in 0..inGit.length - 1
  puts "#{underVC[i][0]} [#{underVC[i][1]}]: #{underVC[i][2]}(#{underVC[i][3]}) "
end

# output the files not under version control
for i in 0..notInGit.length
  puts "[***not under version control***]: #{notInGit[i]}"
end
