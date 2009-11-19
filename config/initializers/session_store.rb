# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bon-appetit_session',
  :secret      => '63b7f5feae1f843ed9e342892f9b99df1c4620736100432c054db945006c8e128a38858604a213b5440d5c725a617372a248f4b8d26ba332f2effd28f6a991a7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
