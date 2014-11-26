define :inspeqtor_service_check, :action => :create do
  service_name = params[:name]
  service_file = "/etc/inspeqtor/services.d/#{service_name}.inq"

  if params[:action] == :create
    rules = Array(params[:rules])

    with_params = {}
    params.keys.each do |k|
      if k.to_s.start_with?("with_")
        with_params[k.to_s.sub("with_", "")] = params[k]
      end
    end

    template service_file do
      source   "service.inq.erb"
      owner    "root"
      group    "root"
      mode     "0644"
      notifies :reload, "service[inspeqtor]"
      variables(
        :service_name => service_name,
        :with_params  => with_params,
        :rules        => rules,
      )
    end
  elsif params[:action] == :delete
    file service_file do
      action   :delete
      notifies :reload, "service[inspeqtor]"
    end
  end
end
