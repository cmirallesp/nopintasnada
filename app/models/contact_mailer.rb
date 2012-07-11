class ContactMailer < ActionMailer::Base
  def new_contact(contact)
    recipients ["info@nopintasnada.com", "nopintasweb@gmail.com"]
    from   contact[:email] 
    subject "CONTACTO: #{contact[:nombre]}"  
    sent_on Time.now 
    body  "#{contact[:xml]}"     
  end  

end
