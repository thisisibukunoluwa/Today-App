



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
Data - DiffableDataSource , Apply the snapshots to the dataSource
Layout - Compositional Layout 
Presentation - list Cell View and Configuration 

Modern collection views automatically animate changes to the state of their data. And they help keep your code organized. UIKit provides diffable data sources, composable layouts, and cell configurations to create and update collection views. 

[how to make a collection list guide](https://developer.apple.com/tutorials/app-dev-training/adopting-collection-views)


Use content configuration to set the cell’s tint and background colors, the text and secondary text font attributes, and the cell accessories.

A diffable data source stores a list of identifiers that represents the identities of the items in the collection view.

## @objc attribute 
The @objc attribute makes this method available to Objective-C code


## Target Action Pair 
Target-action is a design pattern in which an object holds the information necessary to send a message to another object when an event occurs. In the Today app, the touchUpInside event occurs when a user taps the done button, which sends the didPressDoneButton:sender message to the view controller.


## why does the user interface not change? 
the user interface doesn’t update because you haven’t created a new snapshot to represent the change.
When you work with diffable data sources, you apply a snapshot to update your user interface when data changes.


By default, closures create a strong reference to external values that you use inside them. Specifying a weak reference to the view controller prevents a retain cycle.


## note
Interface Builder stores archives of the view controllers you create. A view controller requires an init(coder:) initializer so the system can initialize it using such an archive. If the view controller can’t be decoded and constructed, the initialization fails. When constructing an object using a failable initializer, the result is an optional that contains either the initialized object if it succeeds or nil if the initialization fails.



Diffable data sources that supply UIKit lists with data and styling require that items conform to Hashable. The diffable data source uses hash values to determine which elements have changed between snapshots.


When you override a view controller’s life cycle method, you first give the superclass a chance to perform its own tasks prior to your custom tasks.

    override func viewDidLoad() {
        super.viewDidLoad()
        func performAction()
    }



Dequeueing reusable cells ensures that table views can perform well even when processing large quantities of data.

## Content View 
The primary role of a content view is to display the app’s data. It’s critical that your app’s data and the visual representation of that data stay in sync. As you build a custom content view, you ensure the data and view stay synced by following
these two guidelines:

A content view lays out its child views using the content and styling that its configuration property describes.

A content view applies its configuration when the system first loads it, and it reapplies its configuration any time that the underlying model data changes.


## AutoLayout 
Auto Layout determines a view’s neighbors along the horizontal axis using leading and trailing instead of left and right. This approach allows Auto Layout to automatically correct a view’s appearance in both right-to-left and left-to-right languages.



Content configurations help keep your user interface in sync with the app’s state.


How can you ensure your content view’s visual representation stays in sync with its associated model data?

Include a didSet observer for the configuration property in your content view that reconfigures the view every time the configuration object changes.

Because your configuration object provides the underlying model data, observing the configuration object for changes and reconfiguring the view when changes occur is an effective strategy.


## Escaping Closure 
when you pass a closure as an argument, you need to label it as escaping if it’s called after the function returns.


A UIKit control that uses the delegate pattern doesn’t need to know anything about the model. A control reports to their delegate only that an interaction or event has occurred. The delegate is responsible for responding accordingly.
