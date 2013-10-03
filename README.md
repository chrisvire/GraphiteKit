GraphiteKit
===========

GraphiteKit is an Objective-C wrapper for OS X around the Graphite (http://graphite.sil.org) text shaping library.

In order to build this library, you need the latest source tarball for graphite.

1.  Download the src tarball from http://projects.palaso.org/projects/graphitedev/files
2.  Extract into the directory next to GraphiteKit.  It will most likely have a version number in the directory.
3.  In Terminal, go to the GraphiteKit directory and create a soft link from the extracted graphite directory to a directory named 'graphite' (e.x. `ln -s ../graphite2-1.2.3 graphite2`)
Note: Don't make an alias from within the Finder.  Xcode will not be able to fund the header.

In order to use the Framework from your code, then do the following to your EXE project:

1.  Add the location of the GraphiteKit.framework to your project.  TODO: figure out debug/release
2.  In the Build Settings, set "Runpath Search Paths" to @loader_path/../Frameworks
3.  In Summary, Add GraphiteKit.framework to "Linked Frameworks and Libraries"
4.  In Build Phases, Add a "Copy Files" buid phase, set the destination to Frameworks and add GrpahiteKit.framework to be copied
