#!/usr/bin/env perl
use utf8;
use open qw(:std :utf8);
binmode STDOUT, ':utf8';

my $EM = "\x{2014}";
my $EN = "\x{2013}";
my $MID = "\x{00B7}";
my $TIMES = "\x{00D7}";
my $CORRUPT = " $EM ";

my @paths = (
  '/Users/bbtripathi/Projects/program-management-leader/index.html',
  '/Users/bbtripathi/Downloads/experience-detail_5.html',
);

my $sprites = q{
  <symbol id="i-mail" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></symbol>
  <symbol id="i-pin" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 21s7-7.2 7-12a7 7 0 10-14 0c0 4.8 7 12 7 12z"/><circle cx="12" cy="9" r="2.4"/></symbol>
  <symbol id="i-phone" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M5 4h4l2 5-2.5 1.5a11 11 0 005 5L15 13l5 2v4a2 2 0 01-2 2C9.5 21 3 14.5 3 6a2 2 0 012-2z"/></symbol>
  <symbol id="i-growth" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 17l6-6 4 4 8-8"/><path d="M15 7h6v6"/></symbol>
  <symbol id="i-save" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="M9 12h6M12 9v6"/></symbol>
  <symbol id="i-launch" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M5 15l4 4L21 7l-2-2L7 17z"/><path d="M14 4l6 6M3 21l4-1-3-3-1 4z"/></symbol>
  <symbol id="i-team" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="9" cy="8" r="3"/><path d="M2 21v-1a6 6 0 016-6h2a6 6 0 016 6v1"/><circle cx="18" cy="8" r="2.4"/><path d="M16 13.2A5 5 0 0122 18v1"/></symbol>
  <symbol id="i-shield" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 3l7 3v6c0 4.5-3 7.5-7 9-4-1.5-7-4.5-7-9V6l7-3z"/></symbol>
  <symbol id="i-hand" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M2 13l4-4 5 2 6-4 5 3-8 8-6-2z"/><path d="M6 9l4 4"/></symbol>
  <symbol id="i-compass" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="M15 9l-2 6-6 2 2-6 6-2z"/></symbol>
  <symbol id="i-target" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="8"/><circle cx="12" cy="12" r="4"/><circle cx="12" cy="12" r="0.6" fill="currentColor"/></symbol>
  <symbol id="i-cap" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M2 9l10-5 10 5-10 5-10-5z"/><path d="M6 11v5c0 1.5 3 3 6 3s6-1.5 6-3v-5"/></symbol>
  <symbol id="i-book" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M4 5a2 2 0 012-2h11v16H6a2 2 0 00-2 2z"/><path d="M17 3v16"/></symbol>
  <symbol id="i-belt" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="8" r="5"/><path d="M9 12l-2 9 5-2 5 2-2-9"/></symbol>
  <symbol id="i-api" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="6" cy="12" r="3"/><circle cx="18" cy="6" r="3"/><circle cx="18" cy="18" r="3"/><path d="M8.6 10.7L15.4 7.3M8.6 13.3l6.8 3.4"/></symbol>
  <symbol id="i-pay" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="6" width="20" height="13" rx="2"/><path d="M2 10h20M6 15h4"/></symbol>
  <symbol id="i-lock" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="4" y="10" width="16" height="10" rx="2"/><path d="M8 10V7a4 4 0 018 0v3"/></symbol>
  <symbol id="i-flag" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M5 21V4"/><path d="M5 4h13l-3 4 3 4H5"/></symbol>
  <symbol id="i-github" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.009-.868-.014-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 1.84.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/></symbol>
  <symbol id="i-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M4.93 19.07l1.41-1.41M17.66 6.34l1.41-1.41"/></symbol>
  <symbol id="i-menu" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M4 7h16M4 12h16M4 17h16"/></symbol>
  <symbol id="i-copy" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="8" y="8" width="12" height="12" rx="2"/><path d="M16 8V6a2 2 0 00-2-2H6a2 2 0 00-2 2v8a2 2 0 002 2h2"/></symbol>
};

sub fix_leading_indent {
  my ($line) = @_;
  if ($line =~ /^((?:\Q$CORRUPT\E)+)( *)(.*)$/s) {
    my ($groups, $trail, $rest) = ($1, $2, $3);
    my $n = () = $groups =~ /\Q$CORRUPT\E/g;
    return (' ' x ($n * 3 + length($trail))) . $rest;
  }
  return $line;
}

sub repair_script {
  my ($s) = @_;
  my @reps = (
    [ 'var reduced' . $CORRUPT, 'var reduced = ' ],
    [ 'var toast' . $CORRUPT, 'var toast = ' ],
    [ 'var email' . $CORRUPT, 'var email = ' ],
    [ 'toast.textContent' . $CORRUPT, 'toast.textContent = ' ],
    [ 'showToast._t' . $CORRUPT, 'showToast._t = ' ],
    [ 'var progress' . $CORRUPT, 'var progress = ' ],
    [ 'var' . $CORRUPT . '= document.documentElement.scrollHeight' . $CORRUPT . 'window.innerHeight', 'var h = document.documentElement.scrollHeight - window.innerHeight' ],
    [ "progress.style.width$CORRUPT(h$CORRUPT" . '0' . "$CORRUPT(window.scrollY$CORRUPT" . 'h)' . "$CORRUPT" . '100' . "$CORRUPT" . '0)' . "$CORRUPT" . "'%'", "progress.style.width = (h > 0 ? (window.scrollY / h) * 100 : 0) + '%'" ],
    [ 'var navLinks' . $CORRUPT, 'var navLinks = ' ],
    [ 'var sections' . $CORRUPT, 'var sections = ' ],
    [ 'var' . $CORRUPT . '= window.scrollY' . $CORRUPT . '120', 'var y = window.scrollY + 120' ],
    [ 'var current' . $CORRUPT, 'var current = ' ],
    [ 'current' . $CORRUPT . 's', 'current = s' ],
    [ "=== '#'" . $CORRUPT . 'current.id', "=== '#' + current.id" ],
    [ 'var menuBtn' . $CORRUPT, 'var menuBtn = ' ],
    [ 'var nav' . $CORRUPT, 'var nav = ' ],
    [ 'var themeBtn' . $CORRUPT, 'var themeBtn = ' ],
    [ 'var savedTheme' . $CORRUPT, 'var savedTheme = ' ],
    [ "var next$CORRUPT" . q{document.documentElement.getAttribute('data-theme') === 'light'} . "$CORRUPT" . "'dark'" . "$CORRUPT" . "'light'", "var next = document.documentElement.getAttribute('data-theme') === 'light' ? 'dark' : 'light'" ],
    [ "next === 'dark'$CORRUPT''$CORRUPT'light'", "next === 'dark' ? '' : 'light'" ],
    [ 'var copyBtn' . $CORRUPT, 'var copyBtn = ' ],
    [ 'var target' . $CORRUPT, 'var target = ' ],
    [ 'var prefix' . $CORRUPT, 'var prefix = ' ],
    [ 'var suffix' . $CORRUPT, 'var suffix = ' ],
    [ 'el.textContent' . $CORRUPT . 'prefix' . $CORRUPT . 'target' . $CORRUPT . 'suffix', 'el.textContent = prefix + target + suffix' ],
    [ 'var dur' . $CORRUPT . '1400, t0' . $CORRUPT . 'null', 'var dur = 1400, t0 = null' ],
    [ 't0' . $CORRUPT . 'ts', 't0 = ts' ],
    [ 'var' . $CORRUPT . '= Math.min((ts' . $CORRUPT . 't0)' . $CORRUPT . 'dur, 1)', 'var p = Math.min((ts - t0) / dur, 1)' ],
    [ 'var eased' . $CORRUPT . '1' . $CORRUPT . 'Math.pow(1' . $CORRUPT . 'p, 3)', 'var eased = 1 - Math.pow(1 - p, 3)' ],
    [ 'el.textContent' . $CORRUPT . 'prefix' . $CORRUPT . 'Math.round(target' . $CORRUPT . 'eased)' . $CORRUPT . 'suffix', 'el.textContent = prefix + Math.round(target * eased) + suffix' ],
    [ 'if(p' . $CORRUPT . '1)', 'if(p < 1)' ],
    [ 'var statsObs' . $CORRUPT, 'var statsObs = ' ],
    [ 'var revealObs' . $CORRUPT, 'var revealObs = ' ],
    [ 'var arcWidget' . $CORRUPT, 'var arcWidget = ' ],
    [ 'var arcObs' . $CORRUPT, 'var arcObs = ' ],
    [ 'var impactFilters' . $CORRUPT, 'var impactFilters = ' ],
    [ 'var btn' . $CORRUPT, 'var btn = ' ],
    [ q{var} . $CORRUPT . q{= btn.getAttribute('data-filter')}, q{var f = btn.getAttribute('data-filter')} ],
    [ "toggle('active',$CORRUPT=== btn)", "toggle('active', f === btn)" ],
    [ "toggle('hidden', $CORRUPT!== 'all'", "toggle('hidden', f !== 'all'" ],
    [ 'var expFilters' . $CORRUPT, 'var expFilters = ' ],
    [ q{var} . $CORRUPT . q{= btn.getAttribute('data-company')}, q{var f = btn.getAttribute('data-company')} ],
    [ "toggle('filtered-out', $CORRUPT!== 'all'", "toggle('filtered-out', f !== 'all'" ],
    [ 'var skillChips' . $CORRUPT, 'var skillChips = ' ],
    [ 'var chip' . $CORRUPT, 'var chip = ' ],
    [ 'var on' . $CORRUPT, 'var on = ' ],
    [ 'var metersWrap' . $CORRUPT, 'var metersWrap = ' ],
    [ 'var meterObs' . $CORRUPT, 'var meterObs = ' ],
  );
  for my $pair (@reps) {
    my ($old, $new) = @$pair;
    $s =~ s/\Q$old\E/$new/g;
  }
  return $s;
}

sub repair {
  my ($text) = @_;
  my @lines = map { fix_leading_indent($_) } split /\n/, $text;
  $text = join "\n", @lines;

  $text =~ s/<defs>\s*<symbol id="i-mail".*?<\/defs>/<defs>\n$sprites\n<\/defs>/s;

  my @reps = (
    [ 'viewBox="0' . $CORRUPT . '480 340"', 'viewBox="0 0 480 340"' ],
    [ 'viewBox="0' . $CORRUPT . '1440 940"', 'viewBox="0 0 1440 940"' ],
    [ 'padding:76px' . $CORRUPT . '54px', 'padding:76px 0 54px' ],
    [ 'margin:0' . $CORRUPT . '12px', 'margin:0 0 12px' ],
    [ 'margin:0' . $CORRUPT . '28px', 'margin:0 0 28px' ],
    [ 'margin:6px' . $CORRUPT . '0', 'margin:6px 0 0' ],
    [ 'margin:6px' . $CORRUPT . '14px', 'margin:6px 0 14px' ],
    [ 'margin:0' . $CORRUPT . '10px', 'margin:0 0 10px' ],
    [ 'margin:0' . $CORRUPT . '8px', 'margin:0 0 8px' ],
    [ 'margin:6px' . $CORRUPT . '0;font-weight:600', 'margin:6px 0 0;font-weight:600' ],
    [ 'margin:6px' . $CORRUPT . '0;font-weight:600', 'margin:6px 0 0;font-weight:600' ],
    [ 'box-shadow:0' . $CORRUPT . '0' . $CORRUPT, 'box-shadow:0 0 0 ' ],
    [ '0%{box-shadow:0' . $CORRUPT . '0' . $CORRUPT, '0%{box-shadow:0 0 0 ' ],
    [ '70%{box-shadow:0' . $CORRUPT . '0 10px', '70%{box-shadow:0 0 10px' ],
    [ '100%{box-shadow:0' . $CORRUPT . '0' . $CORRUPT, '100%{box-shadow:0 0 0 ' ],
    [ '.glance-card' . $CORRUPT . 'b{', '.glance-card p b{' ],
    [ '/* ---------- EXPERIENCE AT' . $CORRUPT . 'GLANCE ---------- */', '/* ---------- EXPERIENCE AT A GLANCE ---------- */' ],
    [ '/* ---------- METRICS' . $CORRUPT . 'CHARTS ---------- */', '/* ---------- METRICS & CHARTS ---------- */' ],
    [ 'AI' . $CORRUPT . 'ML Programs', 'AI / ML Programs' ],
    [ 'owning' . $CORRUPT . 'payments', 'owning a payments' ],
    [ 'MIT' . $CORRUPT . 'Boston', "MIT $MID Boston" ],
    [ 'New York' . $CORRUPT . 'Albany', "New York $MID Albany" ],
    [ 'Institute' . $CORRUPT . 'India', "Institute $MID India" ],
    [ 'INTUIT' . $CORRUPT, "INTUIT $MID " ],
    [ 'AMAZON' . $CORRUPT, "AMAZON $MID " ],
    [ 'THE HARTFORD' . $CORRUPT, "THE HARTFORD $MID " ],
    [ 'CSC' . $CORRUPT, "CSC $MID " ],
    [ 'Shipped' . $CORRUPT . '<b>Unified', 'Shipped a <b>Unified' ],
    [ 'Read the announcement' . $CORRUPT, 'Read the announcement ?' ],
    [ '2025' . $EN . '311864533', '20250311864533' ],
  );
  for my $pair (@reps) {
    my ($old, $new) = @$pair;
    $text =~ s/\Q$old\E/$new/g;
  }

  $text =~ s/data-suffix="\x{FFFD}"/data-suffix="$TIMES"/g;
  $text =~ s/data-suffix="\?"/data-suffix="$TIMES"/g;

  $text =~ s/(<div class="sec-tag">)(\d{2})$CORRUPT/$1$2 $MID /g;
  $text =~ s/(\d{4})$CORRUPT Present/$1${EN}Present/g;
  $text =~ s/(\d{4})$CORRUPT (\d{4})/$1${EN}$2/g;

  $text =~ s/<script>\n(.*?)<\/script>/'<script>\n'.repair_script($1).'\n<\/script>'/se;

  $text = repair_pass2($text);
  $text = repair_pass3($text);

  return $text;
}

sub repair_pass2 {
  my ($text) = @_;
  my @reps = (
    [ '0' . $CORRUPT . '0 2px', '0 0 0 2px' ],
    [ '0' . $CORRUPT . '0 3px', '0 0 0 3px' ],
    [ ',0' . $CORRUPT . '18px', ',0 0 18px' ],
    [ ',0' . $CORRUPT . '20px', ',0 0 20px' ],
    [ 'margin:0' . $CORRUPT . '14px', 'margin:0 0 14px' ],
    [ 'margin:0' . $CORRUPT . '6px', 'margin:0 0 6px' ],
    [ 'padding:40px' . $CORRUPT . '60px', 'padding:40px 0 60px' ],
    [ '100%' . $CORRUPT . '4px', '100% + 4px' ],
    [ 'viewBox="0' . $CORRUPT . '420 340"', 'viewBox="0 0 420 340"' ],
    [ 'viewBox="0' . $CORRUPT . '480 280"', 'viewBox="0 0 480 280"' ],
    [ 'Experience at' . $CORRUPT . 'glance', 'Experience at a glance' ],
    [ 'Every line,' . $CORRUPT . 'delivered result', 'Every line, a delivered result' ],
    [ 'What' . $CORRUPT . 'build with', 'What I build with' ],
    [ 'Agile' . $CORRUPT . 'Scrum at Scale', 'Agile / Scrum at Scale' ],
    [ 'Staff PM, Technical' . $CORRUPT . '2022', "Staff PM, Technical $MID 2022" ],
    [ 'Sr. Technical PM' . $CORRUPT . '2017', "Sr. Technical PM $MID 2017" ],
    [ 'At Intuit,' . $CORRUPT . 'scaled', 'At Intuit, I scaled' ],
    [ 'transactions' . $CORRUPT . 'month', 'transactions a month' ],
    [ ',' . $CORRUPT . ' $639K', ', a $639K' ],
    [ 'proposals' . $CORRUPT . 'structured', 'proposals I structured' ],
    [ 'At Amazon,' . $CORRUPT . 'built and ran' . $CORRUPT, 'At Amazon, I built and ran a' ],
    [ 'driving' . $CORRUPT . '<b>20%', 'driving a <b>20%' ],
    [ '. ' . $CORRUPT . 'also launched', '. I also launched' ],
    [ 'led' . $CORRUPT . 'global', 'led a global' ],
    [ 'Career' . $CORRUPT . 'Impact Mix', 'Career $ Impact Mix' ],
    [ 'CAREER' . $CORRUPT . 'IMPACT', 'CAREER $ IMPACT' ],
    [ 'Pilot' . $CORRUPT . 'txns/month', "Pilot $MID txns/month" ],
    [ 'Current' . $CORRUPT . 'txns/month', "Current $MID txns/month" ],
    [ 'programs' . $CORRUPT . 'Intuit', "programs $MID Intuit" ],
    [ 'Years in role' . $CORRUPT . 'Intuit', "Years in role $MID Intuit" ],
    [ 'budget owned for' . $CORRUPT . 'enterprise', 'budget owned for 3 enterprise' ],
    [ '$20M+ revenue' . $CORRUPT . 'contactless', '$20M+ revenue from contactless' ],
    [ 'txns/mo' . $CORRUPT . '97.3%', "txns/mo $MID 97.3%" ],
    [ 'YoY savings' . $CORRUPT . 'ASR/NLU', "YoY savings $MID ASR/NLU" ],
    [ 'sale target' . $CORRUPT . '30%+', "sale target $MID 30%+" ],
    [ 'AI' . $CORRUPT . 'ML', 'AI / ML' ],
    [ '91' . "\x{FFFD}" . ' scale', "91$TIMES scale" ],
    [ 'delivering' . $CORRUPT . 'personalized', 'delivering a personalized' ],
    [ 'Built' . $CORRUPT . '<b>150-person', 'Built a <b>150-person' ],
    [ 'Defined and led' . $CORRUPT . 'global', 'Defined and led a global' ],
    [ 'standing up' . $CORRUPT . '20-member', 'standing up a 20-member' ],
    [ 'Built' . $CORRUPT . '45-person', 'Built a 45-person' ],
    [ 'driving' . $CORRUPT . '<b>150%+ improvement', 'driving a <b>150%+ improvement' ],
    [ 'Led' . $CORRUPT . '10-analyst', 'Led a 10-analyst' ],
    [ 'managing' . $CORRUPT . '<b>$250M', 'managing a <b>$250M' ],
    [ 'across the' . $CORRUPT . 'centers', 'across the 3 centers' ],
    [ 'data-suffix="' . "\x{FFFD}" . '"', "data-suffix=\"$TIMES\"" ],
    [ '<span class="pill">2022' . $CORRUPT . 'Present</span>', "<span class=\"pill\">2022 $EN Present</span>" ],
    [ '<span class="pill">2017' . $CORRUPT . '2022</span>', "<span class=\"pill\">2017 $EN 2022</span>" ],
    [ '<span class="pill">2014' . $CORRUPT . '2017</span>', "<span class=\"pill\">2014 $EN 2017</span>" ],
    [ '<span class="pill">2011' . $CORRUPT . '2014</span>', "<span class=\"pill\">2011 $EN 2014</span>" ],
    [ '<span class="pill">2008' . $CORRUPT . '2010</span>', "<span class=\"pill\">2008 $EN 2010</span>" ],
    [ '<span class="pill">2003' . $CORRUPT . '2005</span>', "<span class=\"pill\">2003 $EN 2005</span>" ],
  );
  for my $pair (@reps) {
    my ($old, $new) = @$pair;
    $text =~ s/\Q$old\E/$new/g;
  }
  return $text;
}

sub repair_pass3 {
  my ($text) = @_;
  my @reps = (
    [ 'savings,' . $CORRUPT . '$639K', 'savings, a $639K' ],
    [ 'ran a<b>150-person', 'ran a <b>150-person' ],
    [ '</b>.' . $CORRUPT . 'also launched', '</b>. I also launched' ],
    [ 'career impact' . $CORRUPT . '91' . "\x{FFFD}" . ' scale', "career impact $MID 91$TIMES scale" ],
    [ 'margin:0' . $CORRUPT . '16px', 'margin:0 0 16px' ],
    [ 'Shift4' . $CORRUPT . 'Chase' . $CORRUPT . 'FIS' . $CORRUPT . 'Apple' . $CORRUPT . 'AWS Cryptography', "Shift4 $MID Chase $MID FIS $MID Apple $MID AWS Cryptography" ],
    [ "next === 'dark'$CORRUPT''$CORRUPT'light'", "next === 'dark' ? '' : 'light'" ],
    [ "toggle('hidden', $CORRUPT!== 'all'", "toggle('hidden', f !== 'all'" ],
    [ "toggle('filtered-out', $CORRUPT!== 'all'", "toggle('filtered-out', f !== 'all'" ],
    [ 'data-suffix="' . "\x{FFFD}" . '"', "data-suffix=\"$TIMES\"" ],
  );
  for my $pair (@reps) {
    my ($old, $new) = @$pair;
    $text =~ s/\Q$old\E/$new/g;
  }
  return $text;
}

for my $path (@paths) {
  open my $fh, '<:utf8', $path or die "read $path: $!";
  my $text = do { local $/; <$fh> };
  close $fh;
  my $fixed = repair($text);
  open my $out, '>:utf8', $path or die "write $path: $!";
  print $out $fixed;
  close $out;
  my $remain = () = $fixed =~ /\Q$CORRUPT\E/g;
  my $q = () = $fixed =~ /\?/g;
  print "Fixed $path: remaining tokens=$remain, question marks=$q\n";
}
