class MailmanMailer
  #todo hmm...
  hostpath = defined?(CRM) ? CRM::HOSTPATH : 'appname.com'

  PROC = Proc.new do
    to("entity-%entity_id%@#{hostpath}") do
      Comment.create(:entity_id => params[:entity_id], :text => message.body.decoded)
    end
  end
end
