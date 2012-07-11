# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nopintasnada_session',
  :secret      => '70f1351aeda0842c8c2d9f8cab4489544dc89120239b99351bb2cbc61d4291a5d90a8028936f85c978879892f8695613a287774c107b240993b98261d086cc4e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
