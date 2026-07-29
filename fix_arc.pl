#!/usr/bin/env perl
use utf8;
use open qw(:std :utf8);
my @paths = (
  '/Users/bbtripathi/Projects/program-management-leader/index.html',
  '/Users/bbtripathi/Downloads/experience-detail_5.html',
);
my $EM = "\x{2014}";
my $MID = "\x{00B7}";
my $TIMES = "\x{00D7}";
for my $path (@paths) {
  open my $fh, '<:utf8', $path or die $!;
  my $text = do { local $/; <$fh> };
  close $fh;
  $text =~ s/\$220M\+ career impact $EM 91./\$220M+ career impact $MID 91$TIMES scale/;
  open my $out, '>:utf8', $path or die $!;
  print $out $text;
  close $out;
}
