require 'spec_helper'

describe Lita::Handlers::OnewheelDoc, lita_handler: true do
  it 'sets a document' do
    send_command 'doc one http://one'
    expect(replies.last).to eq('Documented one as http://one')
  end
end
