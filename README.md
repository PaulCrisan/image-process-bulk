## Helper for bulk process images with ImageMagick.

https://imagemagick.org.

##### Usage:

Check if you have ImageMagick installed

</br>

```
mogrigy --version
```

Clone or copy script from repo and cd where imgproc.sh is.
Make it executable:

```
chmode +x imgproc.sh
```

Have it available from any place:

```
 export PATH=$PATH:~/imgproc.sh
```

Syntax:

script-name [absolute/path/to/file]&nbsp;&nbsp;[no args | -default|-d | -test|-t | -width|-w]
</br>
[absolute/path/to/file] &nbsp;&nbsp; --absolute path to a target directory where image files, or sub-directories containing image files that need to be processed, are located. Process file types: JPEG ,jpeg, JPG, jpg, PNG, png.
</br>
script-name [-help] &nbsp;&nbsp; --show help

</br>

Options:
| | |
|--|--|
| no args | Follow prompts to set custom max-width and quality percentage to process. ALL target file images will be processed. Bonus: get prompted with a joke to light up your day |
|‑default/‑d| Process all images at max-width: 1024 and quality: 75%. ALL target file images will be processed |
|‑test/‑t| Process all images at custom max-width. ALL target file images will be processed |
| ‑test/‑t| Process all images in temporary folder. Follow prompts to set custom max-width and quality percentage. NO TARGET file images will be processed. Size of total processed images shown at end.
