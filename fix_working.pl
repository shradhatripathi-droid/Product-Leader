#!/usr/bin/env perl
use utf8;
use open qw(:std :utf8);

my @paths = (
  '/Users/bbtripathi/Projects/program-management-leader/index.html',
  '/Users/bbtripathi/Downloads/experience-detail_5.html',
);

my $EN = "\x{2013}";

for my $path (@paths) {
  open my $fh, '<:utf8', $path or die "read $path: $!";
  my $text = do { local $/; <$fh> };
  close $fh;

  # Broken script opener from earlier repair (literal backslash-n breaks all JS)
  $text =~ s/<script>\\n\(function\(\)\{/<script>\n(function(){/g;
  $text =~ s/\\n<\/script>/\n<\/script>/g;

  # Arc era date ranges
  my %eras = (
    '2003' . "\x{FFFD}" . '07' => "2003$EN" . '07',
    '2008' . "\x{FFFD}" . '10' => "2008$EN" . '10',
    '2011' . "\x{FFFD}" . '17' => "2011$EN" . '17',
    '2017' . "\x{FFFD}" . '22' => "2017$EN" . '22',
    '2022' . "\x{FFFD}" . 'now' => "2022$EN" . 'now',
  );
  for my $from (keys %eras) {
    my $to = $eras{$from};
    $text =~ s/\Q$from\E/$to/g;
  }

  # Show all content by default; animate only when JS runs
  my $old_reveal_css = '  section.reveal{opacity:0;transform:translateY(24px);transition:opacity .6s ease,transform .6s ease;}
  section.reveal.is-visible{opacity:1;transform:none;}';
  my $new_reveal_css = '  section.reveal{opacity:1;transform:none;}
  html.js section.reveal{opacity:0;transform:translateY(24px);transition:opacity .6s ease,transform .6s ease;}
  html.js section.reveal.is-visible{opacity:1;transform:none;}';
  $text =~ s/\Q$old_reveal_css\E/$new_reveal_css/s;

  unless ($text =~ /documentElement\.classList\.add\('js'\)/) {
    $text =~ s/\(function\(\)\{\n  var reduced/(function(){\n  document.documentElement.classList.add('js');\n  var reduced/;
  }

  open my $out, '>:utf8', $path or die "write $path: $!";
  print $out $text;
  close $out;
  print "Fixed $path\n";
}
