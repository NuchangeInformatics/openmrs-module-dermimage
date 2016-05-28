# Clinical Image Module for OpenMRS (openmrs-module-dermimage)

![OpenMRS DermImage Module](https://raw.github.com/dermatologist/openmrs-module-dermimage/master/docs/dermimage.png)

[![Build Status](https://travis-ci.org/dermatologist/openmrs-module-dermimage.svg)](https://travis-ci.org/dermatologist/openmrs-module-dermimage)

## What is openMRS?

openMRS is a highly customizable EMR platform that can be extended and customized by user-contributed modules. 

More details here: [http://openmrs.org](http://openmrs.org)

## What is openmrs-module-dermimage

Organizing and visualizing clinical images is an important aspect of certain medical specialties such as dermatology. This module lets you upload images from file or webcam and visualize them in the patient chart. This module works with OpenMRS 2.x UI only.

Please check out [skinhelpdesk module here](https://github.com/dermatologist/openmrs-module-skinhelpdesk). In the future, skinhelpdesk module will be made aware of this plugin allowing it to import images from dermimage for easy annotation.

In the future releases, expect the [image tagging](http://docpg.co.in/estore/downloads/dermatology-image-tagger/) and [skin tone](http://gulfdoctor.net/charm/) analysis option. 

## How do I install and use this module?
- [Download latest release](https://github.com/dermatologist/openmrs-module-dermimage/releases). Upload omod to OpenMRS.
- Watch this video: [http://nuchange.ca/openmrs-module-dermimage-video](http://nuchange.ca/openmrs-module-dermimage-video)

## Issues
* The webcam interface uploads a blank image initially. Hence, please capture multiple images before refresh.
* HTML5 canvas interface was not considered since latest chrome browser does not allow non-secure HTML5 capture.

## Credits
* This module borrows heavily from the [openmrs-module-patientimage](https://wiki.openmrs.org/display/docs/Patient+Image+Module)
* [jQery webcam plugin](http://www.xarg.org/project/jquery-webcam-plugin/) 

## Contact Me
Visit [my blog](http://nuchange.ca).
