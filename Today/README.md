



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

## Diffable Data Source 
A diffable data source updates and animates the user interface when the data changes.

## Cell Registration 
Cell registration specifies how to configure the content and appearance of a cell.

## Optional value 
Use implicitly unwrapped optionals only when you know that the optional will have a value. Otherwise, you risk triggering a runtime error that immediately terminates the app. You’ll initialize the data source in the next step to guarantee that the optional has a value.


UIKit provides a UICollectionView class that efficiently displays related items as cells in a scrollable view.
Modern collection views automatically animate changes to the state of their data. And they help keep your code organized. UIKit provides diffable data sources, composable layouts, and cell configurations to create and update collection views. 

Separation Of concerns 
Data - DiffableDataSource 
Layout - Compositional Layout 
Presentation - list Cell View and Configuration 

Modern collection views automatically animate changes to the state of their data. And they help keep your code organized. UIKit provides diffable data sources, composable layouts, and cell configurations to create and update collection views. 

[how to make a collection list guide](https://developer.apple.com/tutorials/app-dev-training/adopting-collection-views)


Use content configuration to set the cell’s tint and background colors, the text and secondary text font attributes, and the cell accessories.

A diffable data source stores a list of identifiers that represents the identities of the items in the collection view.


