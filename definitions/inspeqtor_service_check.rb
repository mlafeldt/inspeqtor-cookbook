define :inspeqtor_service_check do
  params[:action] ||= :create
  service_name = params[:name]
  service_file = "/etc/inspeqtor/services.d/#{service_name}.inq"

  case params[:action].to_sym
  when :create
    with_params = params[:with] || {}
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
        :rules        => Array(params[:rules]),
      )
    end
  when :delete
    file service_file do
      action   :delete
      notifies :reload, "service[inspeqtor]"
    end
  end
end
