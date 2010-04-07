require "rexml/document"
include REXML
doc = Document.new File.new("blob.xml")
doc.elements.each("inventory/section/item/name") { |element| puts element.text }