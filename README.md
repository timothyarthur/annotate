# IIIF-Annotate [![Build Status](https://travis-ci.org/mnyrop/annotate.svg?branch=master)](https://travis-ci.org/mnyrop/annotate)   ![Libraries.io for GitHub](https://img.shields.io/librariesio/github/mnyrop/annotate.svg)

Create/store/load static annotations on IIIF manifests via Jekyll

## Getting started

### Requirements
- Ruby >=2.2
- Jekyll >=3.5
- Bundler >=1.12

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
  - note that the rake task needs to look at the annotations as rendered in the site, so you must run ```jekyll build```
    before running the rake task. Otherwise you will see errors like ```error: pathspec 'annotations/heresies_01' did not match any file(s) known to git.```
    If this happens, just run ```jekyll build``` and then run the rake task again. (This requirement will be removed in a future release.)
