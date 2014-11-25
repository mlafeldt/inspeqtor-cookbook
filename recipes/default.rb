if node["inspeqtor"]["use_packagecloud_repo"]
  packagecloud_repo "contribsys/inspeqtor"
end

package "inspeqtor"

service "inspeqtor" do
  provider Chef::Provider::Service::Upstart
  action   [:enable, :start]
end
