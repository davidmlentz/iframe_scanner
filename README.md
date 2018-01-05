# iframe scanner
This script scans web pages to see if they include iframes. 

The `sites` subdirectory contains lists of URLs. Each file there represents a site to be scanned, and each line in the file contains a URL.

The output of the script is a CSV that lists the output of the scan, identifying pages that contain iframes that should be modified. The only iframes to ignore are those created by:
* Google Doc Embedder
* oEmbed from another WP site
* Google Tag Manager
* Properly embedded YouTube videos (See webguide.boisestate.edu)
* Vimeo content
* Soundcloud content

Call the loop_script.sh script, passing a site name as the only argument:
`./loop_script.sh webguide`
