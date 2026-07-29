#!/usr/bin/env ruby
# frozen_string_literal: true

PATHS = [
  '/Users/bbtripathi/Projects/program-management-leader/index.html',
  '/Users/bbtripathi/Downloads/experience-detail_5.html'
].freeze

CLEAN_SPRITES = <<~SPRITES.strip
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
SPRITES

def fix_leading_indent(line)
  m = line.match(/\A((?: \u2014 )+)( *)/)
  return line unless m
  groups = m[1]
  trailing = m[2]
  n = groups.scan(' — ').length * 3 + trailing.length
  (' ' * n) + line[m.end(0)..-1]
end

def repair_script(script)
  reps = [
    ['var reduced — ', 'var reduced = '],
    ['var toast — ', 'var toast = '],
    ['var email — ', 'var email = '],
    ['toast.textContent — ', 'toast.textContent = '],
    ['showToast._t — ', 'showToast._t = '],
    ['var progress — ', 'var progress = '],
    ['var — = document.documentElement.scrollHeight — window.innerHeight', 'var h = document.documentElement.scrollHeight - window.innerHeight'],
    ["progress.style.width — (h — 0 — (window.scrollY — h) — 100 — 0) — '%'", "progress.style.width = (h > 0 ? (window.scrollY / h) * 100 : 0) + '%'"],
    ['var navLinks — ', 'var navLinks = '],
    ['var sections — ', 'var sections = '],
    ['var — = window.scrollY — 120', 'var y = window.scrollY + 120'],
    ['var current — ', 'var current = '],
    ['if(s.offsetTop <= y) current — s', 'if(s.offsetTop <= y) current = s'],
    ["=== '#' — current.id", "=== '#' + current.id"],
    ['var menuBtn — ', 'var menuBtn = '],
    ['var nav — ', 'var nav = '],
    ['var themeBtn — ', 'var themeBtn = '],
    ['var savedTheme — ', 'var savedTheme = '],
    ["var next — document.documentElement.getAttribute('data-theme') === 'light' — 'dark' — 'light'", "var next = document.documentElement.getAttribute('data-theme') === 'light' ? 'dark' : 'light'"],
    ["next === 'dark' — '' — 'light'", "next === 'dark' ? '' : 'light'"],
    ['var copyBtn — ', 'var copyBtn = '],
    ['var target — ', 'var target = '],
    ['var prefix — ', 'var prefix = '],
    ['var suffix — ', 'var suffix = '],
    ['el.textContent — prefix — target — suffix', 'el.textContent = prefix + target + suffix'],
    ['var dur — 1400, t0 — null', 'var dur = 1400, t0 = null'],
    ['if(!t0) t0 — ts', 'if(!t0) t0 = ts'],
    ['var — = Math.min((ts — t0) — dur, 1)', 'var p = Math.min((ts - t0) / dur, 1)'],
    ['var eased — 1 — Math.pow(1 — p, 3)', 'var eased = 1 - Math.pow(1 - p, 3)'],
    ['el.textContent — prefix — Math.round(target — eased) — suffix', 'el.textContent = prefix + Math.round(target * eased) + suffix'],
    ['if(p — 1)', 'if(p < 1)'],
    ['var statsObs — ', 'var statsObs = '],
    ['var revealObs — ', 'var revealObs = '],
    ['var arcWidget — ', 'var arcWidget = '],
    ['var arcObs — ', 'var arcObs = '],
    ['var impactFilters — ', 'var impactFilters = '],
    ['var btn — ', 'var btn = '],
    ['var — = btn.getAttribute(\'data-filter\')', 'var f = btn.getAttribute(\'data-filter\')'],
    ["toggle('active', — === btn)", "toggle('active', f === btn)"],
    ["toggle('hidden', — !== 'all'", "toggle('hidden', f !== 'all'"],
    ['var expFilters — ', 'var expFilters = '],
    ['var — = btn.getAttribute(\'data-company\')', 'var f = btn.getAttribute(\'data-company\')'],
    ["toggle('filtered-out', — !== 'all'", "toggle('filtered-out', f !== 'all'"],
    ['var skillChips — ', 'var skillChips = '],
    ['var chip — ', 'var chip = '],
    ['var on — ', 'var on = '],
    ['var metersWrap — ', 'var metersWrap = '],
    ['var meterObs — ', 'var meterObs = ']
  ]
  reps.each { |old, new| script = script.gsub(old, new) }
  script
end

def repair(text)
  lines = text.split("\n").map { |line| fix_leading_indent(line) }
  text = lines.join("\n")

  text = text.sub(/<defs>\s*<symbol id="i-mail".*?<\/defs>/m, "<defs>\n  #{CLEAN_SPRITES}\n</defs>")

  replacements = [
    ['viewBox="0 — 480 340"', 'viewBox="0 0 480 340"'],
    ['viewBox="0 — 1440 940"', 'viewBox="0 0 1440 940"'],
    ['padding:76px — 54px', 'padding:76px 0 54px'],
    ['margin:0 — 12px', 'margin:0 0 12px'],
    ['margin:0 — 28px', 'margin:0 0 28px'],
    ['margin:6px — 0', 'margin:6px 0 0'],
    ['margin:6px — 14px', 'margin:6px 0 14px'],
    ['margin:0 — 10px', 'margin:0 0 10px'],
    ['margin:0 — 8px', 'margin:0 0 8px'],
    ['margin:6px — 0;font-weight:600', 'margin:6px 0 0;font-weight:600'],
    ['h2.sec-title{font-family:var(--font-display);font-size:28px;margin:6px — 0;', 'h2.sec-title{font-family:var(--font-display);font-size:28px;margin:6px 0 0;'],
    ['box-shadow:0 — 0 — ', 'box-shadow:0 0 0 '],
    ['0%{box-shadow:0 — 0 — ', '0%{box-shadow:0 0 0 '],
    ['70%{box-shadow:0 — 0 10px', '70%{box-shadow:0 0 10px'],
    ['100%{box-shadow:0 — 0 — ', '100%{box-shadow:0 0 0 '],
    ['.glance-card — b{', '.glance-card p b{'],
    ['/* ---------- EXPERIENCE AT — GLANCE ---------- */', '/* ---------- EXPERIENCE AT A GLANCE ---------- */'],
    ['/* ---------- METRICS — CHARTS ---------- */', '/* ---------- METRICS & CHARTS ---------- */'],
    ['AI — ML Programs', 'AI / ML Programs'],
    ['owning — payments', 'owning a payments'],
    ['data-suffix="?"', 'data-suffix="×"'],
    ['MIT — Boston', 'MIT · Boston'],
    ['New York — Albany', 'New York · Albany'],
    ['Institute — India', 'Institute · India'],
    ['INTUIT — ', 'INTUIT · '],
    ['AMAZON — ', 'AMAZON · '],
    ['THE HARTFORD — ', 'THE HARTFORD · '],
    ['CSC — ', 'CSC · '],
    ['Shipped — <b>Unified', 'Shipped a <b>Unified'],
    ['Read the announcement —', 'Read the announcement ?'],
    ['2025–311864533', '20250311864533']
  ]
  replacements.each { |old, new| text = text.gsub(old, new) }

  text = text.sub('data-suffix="+"', 'data-suffix="+"') # keep first
  text = text.sub(/data-suffix="\uFFFD"/, 'data-suffix="×"')
  text = text.sub(/data-suffix="\?"/, 'data-suffix="×"')

  text = text.gsub(/(<div class="sec-tag">)(\d{2}) — /, '\1\2 · ')
  text = text.gsub(/(\d{4}) — Present/, '\1–Present')
  text = text.gsub(/(\d{4}) — (\d{4})/, '\1–\2')

  text = text.sub(/<script>\n(.*?)<\/script>/m) do
    "<script>\n#{repair_script(Regexp.last_match(1))}\n</script>"
  end

  text
end

PATHS.each do |path|
  unless File.exist?(path)
    puts "skip missing #{path}"
    next
  end
  original = File.read(path, encoding: 'UTF-8')
  fixed = repair(original)
  File.write(path, fixed, encoding: 'UTF-8')
  remaining = fixed.scan(' — ').length
  questions = fixed.count('?')
  puts "Fixed #{File.basename(path)}: remaining em-dash tokens=#{remaining}, question marks=#{questions}"
end
