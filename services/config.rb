coreo_agent_selector_rule 'check-nginx' do
    action :define
    timeout 30
    control 'check-nginx' do
        describe command('nginx') do
            it { should exist }
        end
    end
end

coreo_agent_audit_profile 'nginx-baseline' do
    action :define
    selectors ['check-nginx']
    profile 'https://github.com/dev-sec/nginx-baseline/archive/master.zip'
    timeout 120
end

coreo_agent_rule_runner 'audit-nginx-profiles' do
    action :run
    profiles ${AUDIT_NGINX_PROFILES_ALERT_LIST}
    filter(${FILTERED_OBJECTS}) if ${FILTERED_OBJECTS}
end
  