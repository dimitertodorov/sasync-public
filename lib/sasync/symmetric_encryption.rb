require 'zlib'
require 'sasync/symmetric_encryption/cipher'
require 'sasync/symmetric_encryption/symmetric_encryption'

module Sasync::SymmetricEncryption
  autoload :Reader, 'sasync/symmetric_encryption/reader'
  autoload :Writer, 'sasync/symmetric_encryption/writer'
end

