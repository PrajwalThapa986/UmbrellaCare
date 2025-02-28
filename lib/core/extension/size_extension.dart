//! extension methods
//Extension methods add functionality to existing libraries.

//when using the libraries created by others sometimes we may need additional features.
//in such cases we can't add additional methods to someone else's library.
//we can extend the class but the api returns us the original class instead of extended class.
//we can create a wrapper class that contains the original object inside it. But its wasteful to wrap one object with another object.
//? hence we use extension methods.
//extension methods allows us to add functionality to existing class or library without modifying them.
//Extensions can define not just methods, but also other members such as getter, setters, and operators.
//Also, extensions can have names, which can be helpful if an API conflict arises.

//here we add functionality to existing dart class called num
import 'package:umbrella_care/core/utils/screen_utils.dart';

extension SizeExtension on num {
  //extension function or method to return a relative screen width when the screen width is entered in pixels
  //this is getter method on within an extension on num.
  //on the context of this extension "this" refers to the numeric value that we want to scale
  double get w => ScreenUtils().setWidth(this);

  //for height
  double get h => ScreenUtils().setHeight(this);

  //for text size
  double get ts => ScreenUtils().setFontSize(this);
}
