GraphiteKit
===========

GraphiteKit is an Objective-C wrapper for OS X around the Graphite (http://graphite.sil.org) text shaping library.

In order to build this library, you need the latest source tarball for graphite.

1.  Download the src tarball from http://projects.palaso.org/projects/graphitedev/files
2.  Extract into the directory next to GraphiteKit.  It will most likely have a version number in the directory.
3.  In Terminal, go to the GraphiteKit directory and create a soft link from the extracted graphite directory to a directory named 'graphite' (e.x. `ln -s ../graphite2-1.2.3 graphite2`)
Note: Don't make an alias from within the Finder.  Xcode will not be able to fund the header.
