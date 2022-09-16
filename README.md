# random-file-list-generator
creates a random list from files in folder to be used with ffmpeg concat 
will make mylist.txt "https://trac.ffmpeg.org/wiki/Concatenate" but will genereate the list in a random way, so everytime its run will create a different mylist.txt

# usage

* just darag and drop a folder or file from the folder, will make mylist.txt next to the script
* will detect the output extension from files in the folder
* if ffmpeg.exe its found next to the script, the scrip will generate output.mp4 from mylist.txt using concat
