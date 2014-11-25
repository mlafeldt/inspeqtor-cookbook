if node["inspeqtor"]["use_packagecloud_repo"]
  packagecloud_repo "contribsys/inspeqtor"
end

package "inspeqtor"

template "/etc/inspeqtor/inspeqtor.conf" do
  owner    "root"
  group    "root"
  mode     "0600"
  notifies :reload, "service[inspeqtor]"
  variables(
    :cycle_time    => node["inspeqtor"]["cycle_time"],
    :deploy_length => node["inspeqtor"]["deploy_length"],
    :log_level     => node["inspeqtor"]["log_level"],
  )
end

service "inspeqtor" do
  provider Chef::Provider::Service::Upstart
  action   [:enable, :start]
end
