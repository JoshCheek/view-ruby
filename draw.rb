require 'json'
calls = File.readlines('recorded.json').map { |l| JSON.parse l }

lines = []
lines << "digraph App {"
calls.uniq.each do |sender, message, receiver|
  lines << "#{sender} -> #{receiver}[label=\"#{message}\"];"
end
lines << "}"

File.write "graph.graphviz", lines.join("\n")

`dot -Tpng graph.graphviz > graph.png`
