# Seashell Generator

A Processing-based application which generates parametric seashells, some found in nature, most not.  The interface allows you to adjust 14 parameters which determine the spirality, orientation, and surface features of a classical mollusk shell. There are about 15 presets which model various [gastropods](http://en.wikipedia.org/wiki/Gastropoda), [bivalves](http://en.wikipedia.org/wiki/Bivalvia), and [cephalopods](http://en.wikipedia.org/wiki/Cephalopod).

The derivation of the shell vertices is found in this [excellent paper by Jorge Picado](http://www.mat.uc.pt/~picado/conchas/eng/article.pdf) and many of the examples are found [here](http://www.mat.uc.pt/~picado/conchas/exemplosindex.html) (in spanish).

## Usage

To run this, you need [Processing](http://www.processing.org) installed. Confirmed working on 1.5.1, untested but probably fine on 2.0.  

It requires [Hemesh](http://hemesh.wblut.com/2011/09/19/he_mesh-a-3d-library-for-processing/) , [PeasyCam](http://mrfeinberg.com/peasycam/) , and [ControlP5](http://www.sojamo.de/libraries/controlP5/) libraries to run, although they are bundled inside the "code" folder so you don't need to install them if you don't already have them.

## Instructions

Load the program and behold the beautiful Precious Wentletrap. Click-dragging the mouse rotates the shell and two finger-scroll zooms. Sliders controlling the parameters are on the left.  For a full explanation of what they do, read the paper. The easiest to use one is "Turns" which controls how many revolutions the spiral makes.

## View and export

"Live" mode continuously generates the mesh in real time as you change parameters, albeit at a lower resolution. "Nomral" mode is higher-resolution, but updates only when you click "update" or spacebar. "Hi-res" is the same but an even higher resolution and slower render.

You can control the color and transparency of the mesh with the color sliders, and view the shell as a wireframe.

The mesh can be exported to an 3d-printer ready STL file, with the export feature on top right. The STL file goes to the export folder. If you want to print it, you first need to [run through this process in MeshLab (free)](http://www.shapeways.com/forum/index.php?t=msg&goto=8163) to thicken the walls of the mesh, and scale it to the right size.

## Screenshots

![http://www.genekogan.com/experiments/seashell-fabrication.html](http://www.genekogan.com/images/seashell-fabrication/generator5_gh.png)
![http://www.genekogan.com/experiments/seashell-fabrication.html](http://www.genekogan.com/images/seashell-fabrication/generator4_gh.png)
![http://www.genekogan.com/experiments/seashell-fabrication.html](http://www.genekogan.com/images/seashell-fabrication/generator3_gh.png)
