#!/usr/bin/env perl
use utf8;
binmode(STDOUT, ':utf8');

my $EM = "\x{2014}";
my $EN = "\x{2013}";
my $MID = "\x{00B7}";
my $ARR = "\x{2192}";
my $TIMES = "\x{00D7}";

my @paths = (
  '/Users/bbtripathi/Projects/program-management-leader/index.html',
  '/Users/bbtripathi/Downloads/experience-detail_5.html',
);

for my $path (@paths) {
  open my $fh, '<:utf8', $path or die "read $path: $!";
  my $text = do { local $/; <$fh> };
  close $fh;

  my @lines = split /\n/, $text, -1;
  for my $line (@lines) {
    my $prefix = " $EM ";
    while ($line =~ s/^\Q$prefix\E/  /) { }
  }
  $text = join "\n", @lines;

  my %fix = (
    "100% $EM 4px" => '100% + 4px',
    "0 $EM 0" => '0 0 0',
    ":0 $EM " => ':0 0 ',
    "gap:10px $EM 14px" => 'gap:10px 14px',
    "margin:6px $EM 0" => 'margin:6px 0 0',
    "2025${EN}311864533" => '20250311864533',
    "Leader $EM Fintech" => "Leader $MID Fintech",
    "Staff PM $EM Technical" => "Staff PM $MID Technical",
    "AI $EM ML" => 'AI / ML',
    "owning $EM payments" => 'owning a payments',
    "Shipped $EM <b>Unified" => 'Shipped a <b>Unified',
    "&nbsp;${EM}&nbsp;" => "&nbsp;${MID}&nbsp;",
    '20 ? 1.9M' => "20 $ARR 1.9M",
    'Read the announcement ?' => "Read the announcement $ARR",
  );
  $fix{"INTUIT $EM "} = "INTUIT $MID ";
  $fix{"AMAZON $EM "} = "AMAZON $MID ";
  $fix{"THE HARTFORD $EM "} = "THE HARTFORD $MID ";
  $fix{"CSC $EM "} = "CSC $MID ";

  for my $i (1..9) {
    my $n = sprintf('%02d', $i);
    $text =~ s/\Q$n $EM \E/$n $MID /g;
  }

  for my $from (keys %fix) {
    my $to = $fix{$from};
    $text =~ s/\Q$from\E/$to/g;
  }

  $text =~ s/\(\+91.\)/(+$TIMES)/g;
  $text =~ s/\$8.10M/\$8${EN}10M/g;
  $text =~ s/2022.Present/2022${EN}Present/g;
  $text =~ s/data-suffix=".\""/data-suffix=\"$TIMES\"/g;
  $text =~ s/(\d{4})$EM(\d{4})/$1$EN$2/g;
  $text =~ s/(\d{4})$EM Present/$1$EN Present/g;
  $text =~ s/(INTUIT|AMAZON|THE HARTFORD|CSC) $EM /$1 $MID /g;

  open my $out, '>:utf8', $path or die "write $path: $!";
  print $out $text;
  close $out;
  print "Fixed $path\n";
}
