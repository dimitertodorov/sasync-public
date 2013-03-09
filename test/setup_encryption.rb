require 'java'
require 'rubygems'
require 'lib/sasync'
#Run this script to generate new keys based on the definitions specified in the config file.

Sasync::SymmetricEncryption.generate_symmetric_key_files('config/symmetric_encryption.yml', 'production')
Sasync.initialize_encryption!