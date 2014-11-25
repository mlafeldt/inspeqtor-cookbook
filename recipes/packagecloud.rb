packagecloud_repo "contribsys/inspeqtor"

package "inspeqtor"

service "inspeqtor" do
  provider Chef::Provider::Service::Upstart
  action   [:enable, :start]
end
