require 'json'
calls = $stdin.readlines.map { |l| JSON.parse l }

lines = []
lines << "digraph App {"
calls.uniq.each do |sender, message, receiver|
  lines << "#{sender} -> #{receiver}[label=\"#{message}\"];"
end
lines << "}"

File.write "graph.graphviz", lines.join("\n")

exec 'dot', '-Tpng', 'graph.graphviz'
