# Welcome to ShapePicker 👋
![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)

ShapePicker is a simple app to drag shapes around a canvas.

You can create circles, squares and triangles at random places, drag it around and remove them if you want to. You can also see how many shapes you have created, and delete them all in a single step.

And of course, if you make a mistake, you always have the safety of undoing your actions! 😌

## Purpose and decisions 🤓

The idea is to explore best programming practices while implementing a draw canvas exercise. I like to use `MVVM` as default, as it's an efficient way of architecture the project with single responsibilities. It also helps to implement tests.  

Speaking of tests, I think it's a right approach to implement `Unit` and `UI` tests for this exercise. Here I will use the default _Apple frameworks_ for doing that.

One exciting challenge is the `undo` functionality. The `Command` pattern can help us to achieve this accurately.

## To run the project 🏃‍

I'm using `Xcode 9.4.1`, with `iOS 11.4` as platform target. A simple `build and run` should be all needed.

## TODO / Suggestions ✅‍
- Scrollable canvas
- Infinite canvas - grow as you need it!
- Pinch gesture to change size of ShapePicker
- Change colour of shapes - maybe with force touch?
- Performance considerations for a possible big number of UI elements
