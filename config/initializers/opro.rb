Opro.setup do |config|
  ## Configure the auth_strategy or use set :login_method, :logout_method, & :authenticate_user_method
  config.auth_strategy = :devise

  ## Add or remove application permissions
  # Read permission (any request with [GET]) is turned on by default
  # Write permission (any request other than [GET]) is requestable by default
  # Custom permissions can be configured by adding them to `config.request_permissions`
  # You can then require that permission on individual actions by calling
  # `require_oauth_permissions` in the controller
  config.request_permissions = [:write]

  ## Refresh Token config
  # uncomment `config.require_refresh_within` to require refresh tokens
  # this will expire tokens within the given time duration
  # config.require_refresh_within = 1.month


  config.password_exchange_enabled = true

  config.find_user_for_auth do |controller, params|
    return false if params[:password].blank?
    find_params = params.each_with_object({}) {|(key,value), hash| hash[key] = value if Devise.authentication_keys.include?(key.to_sym) }
    # Try to get fancy, some clients have :username hardcoded, if we have nothing in our find hash
    # we can make an educated guess here
    if find_params.blank? && params[:username].present?
      find_params = { Devise.authentication_keys.first => params[:username] }
    end
    user = User.where(find_params).first if find_params.present?
    return false unless user.present?
    return false unless user.valid_password?(params[:password])
    user
  end

end