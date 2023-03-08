---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: page
title: '1. Select a Manifest'
manifests: ["heresies_01", "heresies_02", "heresies_03", "heresies_04", "heresies_05", "heresies_06", "heresies_07", "heresies_08", "heresies_09", "heresies_10", "heresies_11", "heresies_12", "heresies_13", "heresies_14", "heresies_15", "heresies_16", "heresies_17", "heresies_18", "heresies_19", "heresies_20", "heresies_21", "heresies_22", "heresies_23", "heresies_24", "heresies_25", "heresies_26", "heresies_27", "sinister_wisdom_8" ,"sinister_wisdom_9", "sinister_wisdom_10", "sinister_wisdom_11"]
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

<iframe width="100%" height="500" src="https://www.youtube-nocookie.com/embed/nHbsm8T1BnI?rel=0&showinfo=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe><br><br>

1. Navigate in your terminal to the folder where you have saved the `annotate` folder within the `AdArchive` repository. For example, if you have saved the repository on your desktop, you would type: `cd Desktop/AdArchive/annotate`. (The annotate folder is its own repository within the AdArchive repository, so changes are treated separately).

2. Checkout the `master` branch with the command: `git checkout master`. If this is the first time you are using this branch, you may need to run `git fetch` first.

3. Create a new branch with the name of the issue you are annotating. For example, if you are annotating Sinister Wisdom issue 1, you would type: `git checkout -b sinister_wisdom_1` (this command is a shortcut to both create a new branch and check it out)

4. In the terminal window, serve (ie: run) the Jekyll software by typing in: `bundle exec jekyll serve`.

5. Begin annotating. Under the "#1 Select a Manifest" heading (above), click on the issue that you will be annotating. Be sure to check which annotations have already been done so you are not duplicating your own or someone else’s work.

6. Once you have clicked on the issue that you will be annotating, a new viewer window will appear with multiple page images from that issue. Scroll to the bottom to find the first page of advertisement images, which is usually on the last 3 pages of the magazine issue. Click the first page of advertisement images.

7. Hit the full screen icon in the top right corner of the viewer to make the screen large enough to see the full page of advertisement images so it is big enough to select the annotations. To zoom in and out, place two fingers on your track pad and move fingers up and down.

8. Click on the speech balloons icon in the top left corner of the viewer window to open the annotation tools.

9.  Select the rectangle annotation lasso.

10. Draw rectangle lasso around first annotation and release. When you release the lasso, a text box will pop up.

11. In the text box’s text field, enter who the advertisement is for (e.g.: “Soho 20”). If the advertisement title is different than the item that is being advertised, add the title of the advertisement in a line that follows (e.g.: “Title: Read Soho 20”). Normally the advertisement title and the item advertised are the same thing.

12. In the tag field, tag the item as an advertisement by typing “advertisement” into the text field.

13. Once you are done capturing the information required, hit Save to close window (or hit enter on your keyboard)

14. Follow the same process for all images that are a part of the advertisement. This includes logos and other illustrations. In the text box enter "[Name of advertisement] advertisement image" and in the tag field enter "advertisement_image".

15. Repeat for all remaining advertisements for the issue. Do not include subscription forms, as these are not advertisements.

16. To save annotations, scroll down in the browser window past the viewer window to “#2 Save Annotations”. Click on “view cached annotation JSON’ button. A box will appear with JSON in it, organized in sequential order by page number.

17. At the bottom of this box, click on the “Download [page number] JSON” button.

18. The annotations will be saved to your downloads folder. Ensure that the file names are formatted with just the page number, followed by the ".json" extension, e.g. `0.json` and **not** e.g. `0 (1).json`. If not, rename them.

19. Copy the annotations file (its name will be [page number].json) and navigate to the annotate folder you have saved on your computer.

20. Open the ‘annotations’ folder within the ‘annotate’ folder.

21. Select the issue you’d like to save to.

22. Paste in the folder for the proper issue number.

23. Repeat for subsequent pages.

24. Next, you will need to clear the cached annotations from your browser storage. Scroll down to “#3 Store Annotations” step 6. In Chrome, right click on the page>inspect>application>storage>and then click on “clear site data”.

25. Next, return to the command window to stop the Jekyll serve command by typing: “CTRL-C”.

26. In the command line, store your annotations in subfolders and create a copy of the IIIF manifest by typing: `bundle exec rake`. (Note: If you encounter a problem in the process, or make a mistake, you can restart from scratch with the command `git reset --hard`. This will reset all of your changes to the latest commit.)

27. To commit your changes, type: `git add --all` and then `git commit -m "annotations for sinister_wisdom_1"`

28. To upload your changes, first merge your working branch with the `master` branch by checking out the `master` branch with `git checkout master`. Then run the command `git merge [name of working branch]`. If an error occurs in the merge process, abort the merge with `git merge --abort`, upload your working branch by checking it out and using the command `git push -u origin [branch_name]`, and contact the repository administrator to complete the merge process.

29. If the merge is successful, push your changes to the `master` branch by typing: `git push origin master`.
