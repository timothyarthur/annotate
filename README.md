# IIIF-Annotate for AdArchive

Create/store/load static annotations on IIIF manifests via Jekyll

## Getting started

### Requirements
- Ruby >=2.2<=3.1
- Jekyll >=3.5<=3.9
- Bundler >=1.12<=2.4

### Installing
- Clone this repository and navigate into it:<br>
  `$ git clone https://github.com/mnyrop/annotate.git && cd annotate`
- Install dependencies:<br>
  `$ bundle install`

### Enhancements for creating clippings (pbinkley)

The rake task ```store_annotations``` has more functions:

- it processes new annotations, as in the original ```annotate```
- it also interprets annotations to create clippings:
  - in subdirectory ```clippings``` it creates a directory structure ```[manifest]/[page]```
    within which it stores clipping images, with names like ```1-photo-woman-with-film-camera-1235-134-1126-637.jpg```
    (page number, tag, title, xywh)
  - within the ```clippings/[manifest]``` directory, it creates ```clippings.csv```, with a
    dump of data about all the clippings from that manifest: ```id,item,canvas,canvasNum,tags,texts,xywh,clippingURL,clippingImage```.
    The ```id``` is a uuid; ```clippingURL``` can be used to retrieve the clipping image at its highest resolution,
    and can serve as the URI for the clipping; ```clippingImage``` contains the local path and filename of the clipping image.
  - these functions are idempotent: clipping images will only be fetched if they are not already present
    (otherwise it will output "No fetching [image]"),
    and the clippings.csv will always be regenerated from all the annotations, regardless of whether they are old or new.

### Further enhancements (timothyarthur)
- Updated with rake function for adding new manifests from files named `/iiif/[manifest]/[manifest].json'
- Debugged Rakefile
- This branch made compatible with GitHub pages
