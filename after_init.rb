RedmineExtensions::Reloader.to_prepare do

  require 'redmine_social_sign_in/hooks'

end

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :google_oauth2, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['google_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['google_app_secret']
  }, scope:                       'email,profile', path_prefix: '/social_sign_in'

  provider :facebook, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['facebook_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['facebook_app_secret']
  }, scope:                  'email,public_profile', path_prefix: '/social_sign_in'

  provider :linkedin, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['linkedin_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['linkedin_app_secret']
  }, path_prefix:            '/social_sign_in'

  provider :twitter, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['twitter_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['twitter_app_secret']
  }, path_prefix:           '/social_sign_in'

  provider :qq_connect, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['qq_connect_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['qq_connect_app_secret']
  }, scope:                    'get_user_info', path_prefix: '/social_sign_in'

  provider :wechat, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['wechat_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['wechat_app_secret']
  }, scope:                'snsapi_userinfo', path_prefix: '/social_sign_in'

  provider :oauth2_generic, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['oauth2_generic_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['oauth2_generic_app_secret']
  }, client_options: {
    'site' => Setting.plugin_redmine_social_sign_in['oauth2_generic_site'],
    'authorize_url' => Setting.plugin_redmine_social_sign_in['oauth2_generic_site']+'/oauth/authorize',
    'token_url' => Setting.plugin_redmine_social_sign_in['oauth2_generic_site']+'/oauth/access_token',
    'user_info_url' => Setting.plugin_redmine_social_sign_in['oauth2_generic_site']+'/api/v4/users/me'
  }, user_response_structure: {
    root_path: [],
    attributes: { name: 'first_name'+'last_name',
                  first_name: 'first_name',
                  last_name: 'last_name',
                  username: 'username',
                  email: 'email'
    }
  }, path_prefix:            '/social_sign_in'
end

