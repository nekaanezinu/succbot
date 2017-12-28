require 'rubygems'
require 'net/http'
require 'builder'

class Net::HTTP
	  alias_method :old_initialize, :initialize
	    def initialize(*args)
		        old_initialize(*args)
			    @ssl_context = OpenSSL::SSL::SSLContext.new
			        @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
				  end
end


res = Net::HTTP.get(
	    :url => 'http://www.google.com.tw/search?hl=zh-TW&q=tam%20kruize'
)

resp = res.body

if resp =~ /<span\s+class=spell\s+style="color:#000000">.*?<\/span>(<a .*?><\/a>)/
	    puts $~
	        puts $1
		    puts $2
end
