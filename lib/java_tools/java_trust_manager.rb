require 'java'

class JavaTrustManager
  include javax.net.ssl.X509TrustManager
  include javax.net.ssl.HostnameVerifier

  # implementation of X509TrustManager
  def check_client_trusted(a, b); end
  def check_server_trusted(a, b); end
  def accepted_issuers
    return nil
  end

  # implementation of HostnameVerifier
  def verify(a,b)
    return true
  end

  def self.trust_everything
    sc = javax.net.ssl.SSLContext.getInstance("SSL")
    inst = new()
    trust_managers = [inst]
    sc.init(nil, trust_managers, java.security.SecureRandom.new)
    javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory())
    javax.net.ssl.HttpsURLConnection.setDefaultHostnameVerifier(inst);
  end
end

JavaTrustManager.trust_everything
