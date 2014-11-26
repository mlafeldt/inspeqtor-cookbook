if node["inspeqtor"]["use_packagecloud_repo"]
  packagecloud_repo "contribsys/inspeqtor"
end

package "inspeqtor"

service "inspeqtor" do
  provider Chef::Provider::Service::Upstart
  action   [:enable, :start]
end

template "/etc/inspeqtor/inspeqtor.conf" do
  owner    "root"
  group    "root"
  mode     "0600"
  notifies :reload, "service[inspeqtor]"
  variables(
    :cycle_time    => node["inspeqtor"]["cycle_time"],
    :deploy_length => node["inspeqtor"]["deploy_length"],
    :log_level     => node["inspeqtor"]["log_level"],
    :alert_routes  => node["inspeqtor"]["alert_routes"],
  )
end

if node["inspeqtor"]["purge_services"]
  directory "/etc/inspeqtor/services.d" do
    action    :delete
    recursive true
  end
end

unless node["inspeqtor"]["service_checks"].nil?
  node["inspeqtor"]["service_checks"].each do |check|
    inspeqtor_service_check check["name"] do
      with   check["with"]
      rules  check["rules"]
      action check["action"]
    end
  end
end
