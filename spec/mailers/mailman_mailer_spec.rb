require 'spec_helper'

describe MailmanMailer do
  # assigns @app
  before(:all) do
    mailman_app &MailmanMailer::PROC
  end

  it 'should add a Comment to an Entity' do
    text = 'text from spec'
    msg  = comment_message()
    expect {
      send_message(msg)
    }.to change(Comment,:count).by(1)
  end
end
