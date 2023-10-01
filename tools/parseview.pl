#!/usr/bin/perl -w
# SPDX-License-Identifier: GPL-2.0-only
# zypper -n in perl-XML-Bare perl-JSON-XS

use strict;
use XML::Bare;
use JSON::XS;
my $xmlfile = shift;
my $xml = `cat $xmlfile`;
my $ref = new XML::Bare(text => $xml) ->parse();
my $coder = JSON::XS->new->pretty->canonical;
#die $coder->encode($ref);


#{package}{value}
my $pkgs = $ref->{sourceinfolist}{sourceinfo};
my %extract=();
foreach my $pkg (@$pkgs) {
  #print("$pkg->{name}{value} $pkg->{version}{ver}{value} $pkg->{version}{rel}{value} $pkg->{location}{href}{value} $pkg->{format}{'rpm:sourcerpm'}{value} $pkg->{time}{file}{value}\n");
  #die;
  $extract{$pkg->{package}{value}} = {
    md5 => $pkg->{verifymd5}{value},
  }; 
}

print $coder->encode(\%extract);
