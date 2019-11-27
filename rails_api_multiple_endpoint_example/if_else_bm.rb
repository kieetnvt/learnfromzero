require "benchmark/ips"

def if_else
  s = "3"
  if s == "1"
  elsif s == "2"
  elsif s == "3"
  end
end

def case_when
  s = "3"
  case s
  when "1"
  when "2"
  when "3"
  end
end

Benchmark.ips do |x|
  x.report("if_else code description") { if_else }
  x.report("case_when code description") { case_when }
  x.compare!
end
