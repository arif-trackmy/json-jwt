require 'spec_helper'

describe JSON::JWK::Set::Fetcher::Debugger::RequestFilter do
  let(:resource_endpoint) { 'https://example.com/resources' }
  let(:request) { HTTP::Message.new_request(:get, URI.parse(resource_endpoint)) }
  let(:response) { HTTP::Message.new_response({hello: 'world'}.to_json) }
  let(:request_filter) { JSON::JWK::Set::Fetcher::Debugger::RequestFilter.new }

  describe '#filter_request' do
    it 'should log request' do
      [
        "======= [JSON::JWK::Set::Fetcher] HTTP REQUEST STARTED =======",
        request.dump
      ].each do |output|
        expect(JSON::JWK::Set::Fetcher.logger).to receive(:info).with output
      end
      request_filter.filter_request(request)
    end
  end

  describe '#filter_response' do
    it 'should log response' do
      [
        "--------------------------------------------------",
        response.dump,
        "======= [JSON::JWK::Set::Fetcher] HTTP REQUEST FINISHED ======="
      ].each do |output|
        expect(JSON::JWK::Set::Fetcher.logger).to receive(:info).with output
      end
      request_filter.filter_response(request, response)
    end
  end
end