require 'fileutils'
require 'mailman'
require 'maildir'

module Mailman::SpecHelpers
  def basic_message
    Mail.new("To: test@example.com\r\nFrom: chunky@bacon.com\r\nCC: testing@example.com\r\nSubject: Hello!\r\n\r\nemail message\r\n")
  end

  def message(*args)
    args    = args.extract_options!

    to      = args[:to]      || "foo@bar.com"
    from    = args[:from]    || "foo@bar.com"
    subject = args[:subject] || "Dummy Subject"
    body    = args[:body]    || "Dummy Body"

    Mail.new("To: #{to}\r\nFrom: #{from}\r\nSubject: #{subject}\r\n\r\n#{body}\r\n")
  end

  def comment_message
    entity = Factory(:entity)

    user   = Factory(:user)
    group  = Factory(:group)
    user.enroll_in(group, :as => :associate)

    entity.stub(:group).and_return(group)

    mail = {
      :to   => "entity-#{entity.to_param}@#{CRM::HOSTPATH}",
      :from => user.email,
      :body => "Entity Comment text from #{__FILE__}"
    }

    message(mail)
  end

  def mailman_app(&block)
    @app = Mailman::Application.new(&block)
  end

  def send_message(message)
    @app.router.route Mail.new(message)
  end

  def email_fixture(*name)
    File.open(File.join(SPEC_ROOT, 'fixtures', name) + '.eml').read
  end

  # def regexp_matcher(pattern)
  #   Mailman::Route::RegexpMatcher.new(pattern)
  # end

  # def string_matcher(pattern)
  #   Mailman::Route::StringMatcher.new(pattern)
  # end

  # def config
  #   Mailman.config
  # end

  # def setup_maildir
  #   maildir_path = File.join(SPEC_ROOT, 'test-maildir')
  #   FileUtils.rm_r(maildir_path) rescue nil
  #   @maildir = Maildir.new(maildir_path)
  #   message = File.new(File.join(maildir_path, 'new', 'message1'), 'w')
  #   message.puts(fixture('example01'))
  #   message.close
  # end

end
