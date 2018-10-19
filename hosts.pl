#!/usr/bin/perl

open (FD,"terraform.tfstate") or die "cannot open file";

while (<FD>) {
	our @ip;
	push (@ip,$1) if /.*assigned_nat_ip.*\"(\d+\.\d+\.\d+\.\d+).*/;
	#print "$1\n";
};

print "{ \"hosts\": [ \"$ip[0]\", \"$ip[1]\", \"$ip[2]\" ] }\n";

close FD;
