# KDNotification

[![CI Status](http://img.shields.io/travis/Kéké Dandois/KDNotification.svg?style=flat)](https://travis-ci.org/Kéké Dandois/KDNotification)
[![Version](https://img.shields.io/cocoapods/v/KDNotification.svg?style=flat)](http://cocoapods.org/pods/KDNotification)
[![License](https://img.shields.io/cocoapods/l/KDNotification.svg?style=flat)](http://cocoapods.org/pods/KDNotification)
[![Platform](https://img.shields.io/cocoapods/p/KDNotification.svg?style=flat)](http://cocoapods.org/pods/KDNotification)

KDNotification is a lightweight framework to show and interact with notifications and toast in your application. The general style is inspired by iOS 10 notifications.

##Screenshots
| Notification	| Toast	|
|:-------------:|:-------------:|:-------------:|
| <img src="Screenshots/screenshot_notification.png" width="300"/> | <img src="Screenshots/screenshot_toast.png" width="300"/> |
## Usage
 
#####Notifications:

```ruby
    [KDNotification showWithText:@"PING" duration:3.0 tapped:^(KDNotification *notification) {
        NSLog(@"tapped notification");
    }];
```
#####Toasts:

```ruby
    [KDToastNotification showWithText:@"this is a toast. Who has the butter?" duration:3.0 tapped:^(KDNotification *notification) {
        NSLog(@"tapped toast");
    }];
    
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

KDNotification is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KDNotification"
```
## TODO
* dark mode
* customization options (text color, font etc.)
* Actions

## Author

Kéké Dandois
Twitter: @kekedandois

## License

KDNotification is available under the MIT license. See the LICENSE file for more info.
