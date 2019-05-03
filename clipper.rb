#!/usr/bin/env ruby

require 'json'
require 'csv'
require 'slugify'
require 'fileutils'
require 'sanitize'
require 'net/http'

require 'byebug'

manifest = 'heresies_16'
manifest_json = JSON.parse(File.read("iiif/" + manifest + "/manifest.json").gsub(/\A---(.|\n)*?---/, "").to_s)

canvasesWithAnnos = manifest_json['sequences'][0]['canvases'].select { 
  |c| c['otherContent'] }.select { 
    |c| c['otherContent'][0]['@type'] == 'sc:AnnotationList' 
  
}

clippings = []

canvasesWithAnnos.each do |canvas|
  canvasID = canvas['@id']
  listpath = canvas['otherContent'][0]['@id'].gsub('{{ site.url }}{{ site.baseurl }}/', '')
  list_json = JSON.parse(File.read('_site/' + listpath).to_s)

  resource = list_json['resources'][0]
  canvasOn = resource['on'][0]['full']
  next 'WTF canvas ID doesn\'t match' unless canvasID == canvasOn
  tags = resource['resource'].select { |r| r['@type'] == 'oa:Tag' }
  texts = resource['resource'].select { |r| r['@type'] == 'dctypes:Text' }
  xywh = resource['on'][0]['selector']['default']['value'].gsub('xywh=', '')

  labelElements = []
  csvElements = {id: resource['id'], item: manifest, canvas: canvasID}

  canvasNum = canvasID.gsub(/.+\$([0-9]+)\/canvas.*/, '\1')
  labelElements << canvasNum
  csvElements[:canvasNum] = canvasNum

  tagElements = []
  tags.each do |tag|
    labelElements << tag['chars']
    tagElements << tag['chars']
  end
  csvElements[:tags] = tagElements.join('|')

  textElements = []
  texts.each do |text|
    labelElements << Sanitize.clean(text['chars']).strip
    tagElements << Sanitize.clean(text['chars']).strip
  end
  csvElements[:tags] = textElements.join('|')

  labelElements << xywh
  csvElements[:xywh] = xywh

  label = labelElements.join(' ').slugify

  imageRoot = canvas['images'][0]['resource']['service']['@id']
  clippingURL = imageRoot + '/' + xywh + '/full/0/default.jpg'
  csvElements[:clippingURL] = clippingURL

  clippingsPath = 'clippings/' + manifest + '/' + canvasNum
  clippingImage = clippingsPath + '/' + label + '.jpg'
  csvElements[:clippingImage] = clippingImage

  FileUtils.mkdir_p clippingsPath
  File.write(clippingImage, Net::HTTP.get(URI.parse(clippingURL)))

  clippings << csvElements
end

column_names = clippings.first.keys
s=CSV.generate do |csv|
  csv << column_names
  clippings.each do |x|
    csv << x.values
  end
end
File.write('clippings/' + manifest + '/clippings.csv', s)
