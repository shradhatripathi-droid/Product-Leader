#!/usr/bin/env perl
use utf8;
use open qw(:std :utf8);

my @paths = (
  '/Users/bbtripathi/Projects/program-management-leader/index.html',
  '/Users/bbtripathi/Downloads/experience-detail_5.html',
);
my $backup = '/Users/bbtripathi/Projects/program-management-leader/github-backup.html';

open my $bfh, '<:utf8', $backup or die "read backup: $!";
my $backup_text = do { local $/; <$bfh> };
close $bfh;

my ($clean_map_svg) = $backup_text =~ /(<svg viewBox="0 0 1440 940".*?<\/svg>)/s
  or die "map svg not found in backup";

my ($clean_token_svg) = $backup_text =~ /(<svg viewBox="0 0 480 340" xmlns="http:\/\/www\.w3\.org\/2000\/svg"><text x="140\.0" y="150".*?Visa Token Service rollout, QuickBooks Payments<\/text><\/svg>)/s
  or die "token svg not found in backup";

my $EN = "\x{2013}";
my $TIMES = "\x{00D7}";
my $EM = "\x{2014}";

for my $path (@paths) {
  open my $fh, '<:utf8', $path or die "read $path: $!";
  my $text = do { local $/; <$fh> };
  close $fh;

  # Critical: broken script close prevented all JS (sections stayed hidden)
  $text =~ s/\\n<\/script>/\n<\/script>/g;

  # Restore leadership map SVG from clean backup
  $text =~ s/<svg viewBox="0 0 1440 940".*?<\/svg>/$clean_map_svg/s;

  # Restore tokenization chart badge text
  $text =~ s/<svg viewBox="0 0 480 340" xmlns="http:\/\/www\.w3\.org\/2000\/svg"><text x="140\.0" y="150".*?Visa Token Service rollout, QuickBooks Payments<\/text><\/svg>/$clean_token_svg/s;

  # Fallback if JavaScript is disabled
  unless ($text =~ /id="nojs-fallback"/) {
    $text =~ s/(<body>)/$1\n<noscript><style id="nojs-fallback">section.reveal{opacity:1!important;transform:none!important;}.scroll-progress{display:none!important;}<\/style><\/noscript>/s;
  }

  open my $out, '>:utf8', $path or die "write $path: $!";
  print $out $text;
  close $out;
  print "Completed $path\n";
}
