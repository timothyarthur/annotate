require 'fileutils'
require 'json'
require 'yaml'
require 'csv'
require 'slugify'
require 'sanitize'
require 'net/http'

require 'byebug'

require 'jekyll'

task :default => [:store_annotations]

task :store_annotations do
  manifests = []

  # create annotations folder for every manifest in iiif folder
  Dir['iiif/*/'].each { | m |
    mkdir_p "annotations/#{File.basename(m, ".*")}"
    manifests << File.basename(m, ".*")
  }

  manifests.each do | manifest |
    puts 'Manifest: ' + manifest
    unstored_canvases = Dir["annotations/" + manifest + "/*.json"].sort!
    unstored_canvases.each do |canvas|
      name = File.basename(canvas, ".*")
      dir = "annotations/" + manifest + "/" + name
      sum_annotations = JSON.parse(File.read(canvas))
      FileUtils::mkdir_p dir # make dir for canvas annotations

      make_anno_list(dir,name,manifest) # write canvas annotation list to file
      store_anno_array(dir,name,manifest,sum_annotations) # write array of canvas annotations to file

      File.delete(canvas) # remove unstored data file
    end

    # TODO also update if manifest is older than clean-manifest
    if !unstored_canvases.empty? || (!File.exist? "iiif/#{manifest}/manifest.json")
      puts "Updating #{manifest}"
      update_manifest_copy(manifest)
    end
  end
  # build jekyll site to get annotations for clippings
  site = Jekyll::Site.new(Jekyll.configuration({
    "source" => ".",
    "destination" => "_site"})).process

  manifests.each do | manifest |
    make_clippings(manifest, site)
  end
end



def make_anno_list(dir,name,manifest)
  listpath = dir + "/" + "list.json"
  if !File.exist?(listpath) # make annotation list if necessary
    puts "creating " + listpath + ".\n"
    File.open(listpath, 'w') do |f|
      # use manifest + '/' + name as canvas label, to ensure uniqueness across all manifests
      f.write("---\nlayout: null\ncanvas: '" + manifest + '/' + name + "'\n---\n" + '{% assign anno_name = page.canvas | append: "-resources" %}{% assign annotations = site.pages | where: "label", anno_name | first %}{"@context": "http://iiif.io/api/presentation/2/context.json","@id": "{{ site.url }}{{ site.baseurl }}/annotations/' + manifest + '/' + name + '/list.json","@type": "sc:AnnotationList","resources": {{ annotations.content }} }')
    end
  end
end

def store_anno_array(dir,name,manifest,sum_annotations)
  annopath = dir +  "/" + name + ".json"
  if !File.exist?(annopath) # if no preexisting annotation file
    puts "creating " + annopath + ".\n"
  else # if preexisting annotation file
    puts "appending new annotations to " + annopath + ".\n"
    old_annotations = JSON.parse(File.read(annopath).gsub(/\A---(.|\n)*?---/, ""))
    sum_annotations = sum_annotations.concat old_annotations # add annotation JSON to array
  end
  File.open(annopath, 'w') { |f| f.write("---\nlayout: null\nlabel: " + manifest + '/' + name + "-resources\n---\n" + sum_annotations.to_json) }
end

def update_manifest_copy(manifest)
  stored_canvases = []
  Dir['annotations/' + manifest + "/*/"].each { | c | stored_canvases << File.basename(c, ".*") }

  puts "adding annotation references for canvases " + manifest + '/' + stored_canvases.to_s + " to manifest copy."

  manifest_json = JSON.parse(File.read("iiif/" + manifest + "/clean-manifest.json").gsub(/\A---(.|\n)*?---/, "").to_s)
  canvases = manifest_json["sequences"][0]["canvases"].select {|c|
    stored_canvases.include? c["@id"].gsub(/.+\$([0-9]+)\/canvas.*/, '\1')
  }
  canvases.each do | canvas |
    annotation_hash = Hash.new { |hash, key| hash[key] = {} }
    this_id = canvas["@id"].gsub(/.+\$([0-9]+)\/canvas.*/, '\1')
    annotation_hash["@id"] = "{{ site.url }}{{ site.baseurl }}/annotations/" + manifest + "/" + this_id + "/list.json"
    annotation_hash["@type"] = "sc:AnnotationList"
    canvas["otherContent"] = Array.new << annotation_hash
  end

  # embed jekyll url and baseurl in manifest id, so that it will match the uri passed to Mirador
  # this is necessary to make the preserveManifestOrder config option take effect
  manifest_json['@id'].gsub!('https://iiif.archivelab.org', '{{ site.url }}{{ site.baseurl }}')

  File.open("iiif/" + manifest + "/manifest.json", 'w+') { |f| f.write("---\nlayout: null\n---\n"+JSON.pretty_generate(manifest_json)) }
end

def make_clippings(manifest, site)

  manifest_file = File.read("iiif/" + manifest + "/manifest.json").gsub(/\A---(.|\n)*?---/, "").to_s
  manifest_json = JSON.parse(manifest_file)

  # select canvases with annotations from manifest
  canvasesWithAnnos = manifest_json['sequences'][0]['canvases']
    .select { |canvas| canvas['otherContent'] }
    .select { |canvas| canvas['otherContent'][0]['@type'] == 'sc:AnnotationList' }

  clippings = []

  canvasesWithAnnos.each do |canvas|
    canvasID = canvas['@id']
    listpath = canvas['otherContent'][0]['@id'].gsub('{{ site.url }}{{ site.baseurl }}/', '')
    puts listpath
    list_file = File.read('_site/'+listpath).to_s

    # parse list file as JSON
    list_json = JSON.parse(list_file)

    list_json['resources'].each do |resource|
      canvasOn = resource['on'][0]['full']
      next 'WTF canvas ID doesn\'t match' unless canvasID == canvasOn
      # get clipping metadata: the tags and text that the user entered, and the selected xywh
      tags = resource['resource'].select { |r| r['@type'] == 'oa:Tag' }
      texts = resource['resource'].select { |r| r['@type'] == 'dctypes:Text' }
      xywh = resource['on'][0]['selector']['default']['value'].gsub('xywh=', '')

      # build label and csv from specified data elements
      labelElements = []
      csvElements = {id: resource['@id'], item: manifest, canvas: canvasID}

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
        # strip html markup
        longfilename = Sanitize.clean(text['chars']).strip
        filename = longfilename.length > 100 ? longfilename[0..99] : longfilename # Edited to shorten further for working in deep paths
        labelElements << filename
        textElements << Sanitize.clean(text['chars']).strip
      end
      csvElements[:texts] = textElements.join('|')

      labelElements << xywh
      csvElements[:xywh] = xywh

      # label ends up like 1-photo-woman-with-film-camera-1235-134-1126-637
      label = labelElements.join(' ').slugify

      imageRoot = canvas['images'][0]['resource']['service']['@id']
      clippingURL = imageRoot + '/' + xywh + '/full/0/default.jpg'
      csvElements[:clippingURL] = clippingURL

      clippingsPath = 'clippings/' + manifest + '/' + canvasNum
      clippingImage = clippingsPath + '/' + label + '.jpg'
      csvElements[:clippingImage] = clippingImage

      FileUtils.mkdir_p clippingsPath
      # fetch clipping image, if not already fetched
      if File.exist?(clippingImage)
        puts "Not fetching #{clippingImage}"
      else
        File.write(clippingImage, Net::HTTP.get(URI.parse(clippingURL)))
        puts "Fetched #{clippingImage} from #{clippingURL}"
      end
      clippings << csvElements
    end
  end

  # output clippings csv file
  if clippings.count > 0
    column_names = clippings.first.keys
    s=CSV.generate do |csv|
      csv << column_names
      clippings.each do |x|
        csv << x.values
      end
    end
    File.write('clippings/' + manifest + '/clippings.csv', s)
  end
end
