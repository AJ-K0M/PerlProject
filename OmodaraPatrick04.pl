use strict;
use warnings;

# Applies a regex to capture the Classes information and prints it.
#
# This script will simulate downloading web source code by reading
# a file and storing the contents of the file in a scalar variable.
#
# The following files are required for this script to run:
#   sp22_ics_availability.html
#
# Ensure the files are in the same folder as this script.
#
# Author: Patrick Omodara

# Die message terminates program when there is more than or less than 1 argument.
my $dieMessage = "Error: Expecting 1 program argument, found " . @ARGV . " instead.\n";
$dieMessage .= "usage: perl OmodaraPatrick04.pl course_number\n";

# Calls the die message
 die $dieMessage if (@ARGV != 1);

# This Scaler represents the courses in the file.
my $courseArg = $ARGV[0];

# This Scaler represents the amount of seats in each course.
my $seatsTotal = 0;

# The name of the file to read in.
my $courseFile = "sp22_ics_availability.html";

# Stores the contents of the file.
my $contents = "";

# Undefine the record separator variable to grab the entire contents
# of the file when using the line-input operator <>
local $/;

# Open a file handle to read sp22_ics_availability.html , terminate the script if unable.
open inFH, "<", $courseFile or die "Unable to open: $courseFile\n";

# Read the file, store the entire contents.
$contents = <inFH>;
# print $contents;

# Done reading the file.
close inFH;

# Ensure no side effects later on in the script,
# re-initialize to newline.
$/ = "\n";

#  Capture the course between the <td> tags
# and output the result.
if ($contents !~ m#<td nowrap="nowrap" CLASS="default">ICS $courseArg</td>#) {
    print "No courses matched";
}else {
  while ($contents =~ m#$courseArg.+?<td class="default" align="center">.+?</td>#s ) {
    $seatsTotal = $seatsTotal + $1;
  }
  print $seatsTotal;
}
