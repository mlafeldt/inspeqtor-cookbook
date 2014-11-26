if node["inspeqtor"]["use_packagecloud_repo"]
  packagecloud_repo "contribsys/inspeqtor"
end

package "inspeqtor"

service "inspeqtor" do
  provider Chef::Provider::Service::Upstart
  action   [:enable, :start]
end

template "#{node["inspeqtor"]["conf_dir"]}/inspeqtor.conf" do
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
  directory node["inspeqtor"]["services_dir"] do
    action    :delete
    recursive true
    notifies  :reload, "service[inspeqtor]"
  end
end

unless node["inspeqtor"]["services"].nil?
  node["inspeqtor"]["services"].each do |s|
    inspeqtor_service s["name"] do
      with   s["with"]
      rules  s["rules"]
      action s["action"]
    end
  end
end
