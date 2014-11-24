package "curl"

install_script = ::File.join(Chef::Config[:file_cache_path], "install-inspeqtor.sh")

remote_file install_script do
  source "https://packagecloud.io/install/repositories/contribsys/inspeqtor/script.deb"
end

execute "bash #{install_script}" do
  not_if "which inspeqtor"
end

package "inspeqtor"

service "inspeqtor" do
  provider Chef::Provider::Service::Upstart
  action   [:enable, :start]
end
