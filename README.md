blocs package will hold our BLOC implementation related files

models package
will hold the POJO class or the model
class of the JSON response we will be getting from the server

resources package
 will hold the repository class and the network call implemented class.

 ui package will hold our screens that will be visible to the user.





 BlocProvider is a generic class. The generic type T is scoped to be an object that implements the Bloc interface. This means that the provider can only store BLoC objects.
 The of method allows widgets to retrieve the BlocProvider from a descendant in the widget tree with the current build context. This is a very common pattern in Flutter.
 This is some trampolining to get a reference to the generic type.
 The widget’s build method is a passthrough to the widget’s child. This widget will not render anything.
 Finally, the only reason why the provider inherits from StatefulWidget is to get access to the dispose method. When this widget is removed from the tree, Flutter will call the dispose method, which will in turn, close the stream.