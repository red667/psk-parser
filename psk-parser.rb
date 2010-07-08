require 'open-uri'
require 'rexml/document'

source = "0831717_Qty_400_no_enc.pskc"
content = ""

# get the XML data as a string
open(source) do |s| content = s.read end

# extract event information
doc = REXML::Document.new(content)

serial = []
data  = []
counter = []

doc.elements.each('SecretContainer/Device/DeviceId/SerialNo') do |ele|
   serial << ele.text
end
doc.elements.each('SecretContainer/Device/Secret/Data/Value') do |ele|
   data << ele.text.chop
end
doc.elements.each('SecretContainer/Device/Secret/Usage/Counter') do |ele|
   counter << ele.text
end

# print all
serial.each_with_index do |serial, idx|
   print "#{serial} 0x#{data[idx]}:#{counter[idx]}\n"
end

