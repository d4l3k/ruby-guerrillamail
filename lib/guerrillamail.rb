require 'mechanize'
require 'multi_json'
require 'pry'

class GuerrillaMail
    def initialize
        @agent = Mechanize.new
        @url_base = 'http://api.guerrillamail.com/ajax.php?'
        @agent_string = "GuerrillaMailGem"
        @ip_addr = "127.0.0.1"
        get_email_address
    end
    def get_email_address
        data = request "get_email_address"
        @email = data["email_addr"]
    end
    def set_email_user new_email
        data = request "set_email_user", "&email_user=#{new_email}&lang=en"
        @email = data["email_addr"]
    end
    def send_email target, subject, body
        @agent.post "#{@url_base}f=send_mail", {from:@email,to:target,subject:subject,body:body}
    end
    def request function, args=""
        MultiJson.load(@agent.get("#{@url_base}f=#{function}&agent=#{@agent_string}&ip=#{@ip_addr}#{args}").body)
    end
end
