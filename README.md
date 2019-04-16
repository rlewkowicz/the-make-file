# the-make-file
### TLDR:

* Environment vars in .env - see `AGE` - can do interp

* Files lose the .template extension and maintain their secondary extension.

* Run `./make`

* Run `bash example-dir/basename.sh && cat example-dir/example-dir2/person.json`

Any .template will lose that extension and any var in a template file like %VAR1% will get replaced.

### Why?

So I wanted a way to template files through a standard bash interface. You may ask "Ryan, why not use standard interp e.g. ${VAR1}?"

Two reasons. I'll give the short then the long.

1. Approachability

2. Templatization of non shell assets.  


On one go look at a repo like this:
https://github.com/pivotal-cf/pcf-pipelines/tree/master/install-pcf/vsphere/tasks

Fairly gnarly bash scripts that are all intended to be run via concourse. Well that's great if you worked with cloud foundry for x amount of years and know exactly what all the intermittent bits and bobs do, but if you don't know all the moving parts, whats the first thing you want to do? Break it down into its parts and see how they work. With the prior I have a bunch stuff I have to manually go interpolate and try to pull out and understand. Not Fun.

The other thing is if I just want to go grab a bit of a script now I can (you can also have a nice global functions file for that sorta thing if you do it a lot).

Finally, it's bash (4+). That's it. If on mac you just need `brew install gnu-sed` and `brew install bash`.

On two, you can do templatization of json/yaml/whatever assets.
