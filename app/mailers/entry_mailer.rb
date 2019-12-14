class EntryMailer < ApplicationMailer
	def notification_email(data)
		@data = data
		@stacktrace = data["STACK_TRACE"]
	    mail(to: ENV["EMAIL_TO"], subject: ENV["EMAIL_SUBJECT"])
	end
end
