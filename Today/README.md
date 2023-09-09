



##UIKit is a graphical framework for building apps on Apple platforms. Use UIKit to define and manage your app’s interface using a comprehensive library of standard components

##View Controllers 
 View controllers act as a bridge between views and your data models. Each view controller is responsible for managing a view hierarchy, updating the content in views, and responding to events in the user interface.

You’ll use Interface Builder to create a collection view controller. Collection views can display cells in grids, columns, rows, or tables.

## Is initial ViewController
You select the Is Initial View Controller checkbox to set the scene as the storyboard entry point.

The initial view controller value determines which view controller loads when the app loads the storyboard.

Note:
Apps may have multiple storyboards. The Main Interface setting in the app’s project file determines which storyboard the app loads when it launches.


## MVC
the Model-View-Controller (MVC) design pattern, is a common design pattern for UIKit apps. View objects provide visual representations of your data. Model objects manage the app’s data and business logic.

You’ve created the view controller that ensures that the model doesn’t directly modify a view and that a view doesn’t directly affect a model.


## if directive 

The #if DEBUG flag is a compilation directive that prevents the enclosed code from compiling when you build the app for release. You can use this flag for testing code in debug builds—or for providing sample test data, like you’ll do in the next step.


## Compositional Layout 
Compositional layout lets you construct views by combining different components: sections, groups, and items. A section represents the outer container view that surrounds a group of items.


