---
layout: page
title: '1. Select a Manifest'
manifests: ["heresies_01", "heresies_02", "heresies_03", "heresies_04", "heresies_05", "heresies_06", "heresies_07", "heresies_08", "heresies_09", "heresies_10", "heresies_11", "heresies_12", "heresies_13", "heresies_14", "heresies_15", "heresies_16", "heresies_17", "heresies_18", "heresies_19", "heresies_20", "heresies_21", "heresies_22", "heresies_23", "heresies_24", "heresies_25", "heresies_26", "heresies_27"]
loaded_manifest: heresies_01
---
<script src="https://use.fontawesome.com/884e80fbb8.js"></script>
<div id="1" style="position:absolute;top:0px;"></div>

Sample pre-loaded annotations can be viewed by toggling the <i class="fa fa-comments" aria-hidden="true"></i> button on the top left of the viewer.

{% include iiif_presentation.html %}

Switch between objects by clicking <i class="fa fa-th-large"></i> in the top left corner, followed by Replace Object <i class="fa fa-refresh"></i>.

<div id="2"></div>
<h1 class="h0">2. Add Annotations</h1>
<br>
<div class="col-4 sm-width-full border-top-thin"></div>
<br>

Make sure you are on Image View <i class="fa fa-photo"></i> then toggle the Annotation <i class="fa fa-comments"></i> panel.

Add one or more annotations to one or more pages. Then click the 'view cached annotation JSON' button below.

**\*Note:** This will only include *new* annotations added in the browser.

<br>

{% include annotation_to_json.html %}

<div id="3"></div>
<h1 class="h0">3. Store Annotations</h1>
<br>
<div class="col-4 sm-width-full border-top-thin"></div>
<br>

<iframe width="100%" height="500" src="https://www.youtube-nocookie.com/embed/nHbsm8T1BnI?rel=0&amp;showinfo=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe><br><br>

__1.__ Under the “#1 Add Annotations” heading (above), click on the Heresies issue that you will be annotating. Be sure to check which annotations have already been done so you are not duplicating your own or someone else’s work.

__2.__ Once you have clicked on the Heresies issue that you will be annotating, a new viewer window will appear with multiple page images from that issue. Scroll to the bottom to find the first page of advertisement images, which is usually on the last 3 pages of the magazine issue. Click the first page of advertisement images.

__3.__ Hit the full screen icon in the top right corner of the viewer to make the screen large enough to see the full page of advertisement images so it is big enough to select the annotations. To zoom in and out, place two fingers on your track pad and move fingers up and down.

__4.__ Click on the speech balloons icon in the top left corner of the viewer window to open the annotation tools.

__5.__ Select the rectangle annotation lasso.

__6.__ Draw rectangle lasso around first annotation and release. When you release the lasso, a text box will pop up.

__7.__ In the text box’s text field, enter who the advertisement is for (ie: “Soho 20”). If the advertisement title is different than the item that is being advertised, add the title of the advertisement in a line that follows (ie: “Title: Read Soho 20”). Normally the advertisement title and the item advertised are the same thing.

__8.__ In the tag field, tag the item as an advertisement by typing “advertisement” into the text field.

__9.__ Once you are done capturing the information required, hit Save to close window (or hit enter on your keyboard)

__10.__ Repeat for all remaining advertisements for the issue. Do not include subscription forms, as these are not advertisements.

__11.__ To save annotations, scroll down in the browser window past the viewer window to “#2 Add Annotations”. Click on “view cached annotation JSON’ button. A box will appear with JSON in it, organized in sequential order by page number.

__12.__ At the bottom of this box, click on the “Download [page number] JSON” button.

__13.__ The annotations will be saved to your downloads folder. Copy the annotations file (its name will be [page number].json) and navigate to the annotate folder you have saved on your computer.

__14.__ Open the ‘annotations’ folder within the ‘annotate’ folder.

__15.__ Select the issue you’d like to save to.

__16.__ Paste in the folder for the proper issue number.

__17.__ Repeat for subsequent pages.

__18.__ Next, you will need to clear the cached annotations from your browser storage. Scroll down to “#3 Store Annotations” step 6. In Chrome, right click on the page>inspect>application>storage>and then click on “clear site data”.

__19.__ Next, return to the command window to stop the Jekyll serve command by typing: “CTRL-C”.

__20.__ In the command line, store your annotations in subfolders and create a copy of the IIIF manifest by typing: “bundle exec jekyll build”.

__21.__ Once this command has run, then type: “bundle exec rake”. 

__22.__ Your annotations and subfolders should now be created and saved.

__23.__ To confirm your work is there and saved, in the command line, open the application again by typing “bundle exec jekyll serve”.

__24.__ Return to your Browser and refresh the page. (or if you have closed the page, go to “localhost:4000/annotate/”). 

__25.__ Select the issue you’ve completed, then select the page of advertisements. Click on the speech bubbles to see your content and confirm your annotations exist. (Note: If the annotations do not appear, try repeating from step 19.)
