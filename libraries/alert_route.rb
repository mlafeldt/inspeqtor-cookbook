def inspeqtor_alert_route(options)
  options = options.dup
  channel = options.delete("channel") { "mail" }
  "send alerts via #{channel} with\n" +
    options.sort.map { |k, v| "  #{k} \"#{v}\"" }.join(",\n")
end
