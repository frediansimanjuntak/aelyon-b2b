Devise.secret_key = "fffe053587902725ee0c38391a6368fd97697fe2d4038ae682e1d860cf603e3029dc324fe3235c80a35cdbca6f6e5a10361e"
Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
end