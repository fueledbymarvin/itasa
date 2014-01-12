if Rails.env == "production"
	ENV['fb_app_id'] = "153712348172227" 
	ENV['fb_secret'] = "f15c6c55c8f07afd231df242d7a15191"
else
	ENV['fb_app_id'] = '343629322437383'
	ENV['fb_secret'] = '7e510c5b72f620481bf44d5873914161'
end

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['fb_app_id'], ENV['fb_secret'], scope: ENV['fb_permissions'], client_options: { :ssl => { :ca_file => '/usr/lib/ssl/certs/ca-certificates.crt' } }
end