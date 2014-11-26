def inspeqtor_alert_route(options)
  options = options.dup
  channel = options.delete("channel")
  owner   = options.delete("owner")

  first_line = if owner
                 "send alerts to #{owner} via #{channel} with\n"
               else
                 "send alerts via #{channel} with\n"
               end

  first_line + options.sort.map { |k, v| "  #{k} \"#{v}\"" }.join(",\n")
end
