# aqsa test: asynchronous query from web worker to native iOS code using XHR

Also contains direct query from main thread of Javascript

Author: Christopher J. Brody

License: UNLICENSE (public domain)

I can hereby testify that this project is completely my own work and not subject to agreements with any other parties.
In case of code written under direct guidance from sample code the link is given for reference.
In case I accept contributions from any others I will require CLA with similar statements.

## About

This project demonstrates the following:
- Ability to request native iOS functionality from within a web worker *and return a callback to the web worker*.
- Build a hybrid Javascript-native app without using a framework such as Cordova which requires attribution of use.

The interaction between Javascript and native iOS works as follows:
- The Javascript executes a simple XHR POST with a `file:` URI (FUTURE TBD custom URI protocol prefix)
- The Objective-C sees URL request and triggers the Javascript `aqcallback` function with a string that echos the URI from the XHR request

This project also has an `AQManager` component that keeps and handles the routing for multiple components that implement the `AQHandler` interface.

In addition, the custom `ViewController` registers a function object in the `JSContext` that returns a string to Javascript. It does *not* work from the web worker but can be used for certain tasks, such as checking an interface version or getting an internal bridge secret like Cordova does.

This project is a starting point for the following ideas (so far):
- Javascript-native interface that can be used from a web worker within Cordova, such as: [@brodybits / cordova-aqs-ios](https://github.com/brodybits/cordova-aqs-ios) and [@brodybits / cordova-aqs-android](https://github.com/brodybits/cordova-aqs-android)
- Provide a sqlite database access layer for Javascript that can be used within multiple Javascript-native bridging frameworks including Cordova, React Native, and NativeScript
- Provide a public-domain Javascript-native access bridge

## Security warning

The Cordova project has been fixing security issues in its external domain whitelist plugin over time, and has also dealt with security issues in its internal bridging mechanism. It is very strongly advised NOT to release an app with a custom-built web view bridging or domain whitelisting mechanism without proper code review and testing.

## Major tips & tricks

- Uses a subclass of `NSURLProtocol` to intercept XHR requests

## Related project(s)

- [@brodybits / aq-query-test-android](https://github.com/brodybits/aq-query-test-android) - request native Android functionality from within a web worker
- [@brodybits / cordova-aqs-ios](https://github.com/brodybits/cordova-aqs-ios) and [@brodybits / cordova-aqs-android](https://github.com/brodybits/cordova-aqs-android)

A similar concept described in my [Starting JSONBus: towards a replacement for Cordova/PhoneGap](http://brodyspark.blogspot.com/2012/12/starting-jsonbus-towards-replacement.html) post on an old blog in December 2012.
