require 'bundler'
require 'json'
require 'serialport'

Bundler.require :default, ENV['RACK_ENV'].to_sym

before do
  content_type 'application/json'
end

port_str = '/dev/ttyUSB0'  #may be different for you
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE


get '/status' do
  sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
  serial = sp.gets.chomp
  sp.close
  { arduino: { port: '/dev/ttyUSB0' , serial: "#{serial}" }}.to_json
end