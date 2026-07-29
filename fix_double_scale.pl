#!/usr/bin/env perl
use utf8;
use open qw(:std :utf8);
my @paths = (
  '/Users/bbtripathi/Projects/program-management-leader/index.html',
  '/Users/bbtripathi/Downloads/experience-detail_5.html',
);
for my $path (@paths) {
  open my $fh, '<:utf8', $path or die $!;
  my $text = do { local $/; <$fh> };
  close $fh;
  $text =~ s/91\x{00D7} scale scale/91\x{00D7} scale/g;
  open my $out, '>:utf8', $path or die $!;
  print $out $text;
  close $out;
}
