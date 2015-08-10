require 'spec_helper'

describe Lita::Handlers::OnewheelDoc, lita_handler: true do
  it 'sets a document' do
    send_command 'doc one http://one'
    expect(replies.last).to eq('Documented one as http://one')
  end
  it 'gets a document' do
    send_command 'doc one http://one'
    send_command 'doc one'
    expect(replies.last).to eq('http://one')
  end
  it 'lists documents' do
    send_command 'doc one http://one'
    send_command 'doc two http://two'
    send_command 'doc'
    expect(replies.last).to eq("one: http://one\ntwo: http://two")
  end
end
