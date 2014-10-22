require 'spec_helper'

describe Message do

#valid test

 	before do
		@message = Message.new(title: "Message Title", text: "Here is a single test message",
 									sender_id: "123", project_id: "1234")
	end


	subject { @message }

	it { should respond_to(:title) }
	it { should respond_to(:text) }
	it { should respond_to(:sender_id) }
	it { should respond_to(:project_id) }
	it { should respond_to(:recipient_id) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }
	it { should respond_to(:user_id) }


end