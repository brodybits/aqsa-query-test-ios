//
//  MyURLProtocol.m
//  qsa
//

#import "MyURLProtocol.h"

#import <UIKit/UIKit.h>

extern UIWebView *gWebView;

@implementation MyURLProtocol

+ (BOOL) canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"got uri: %@", request.URL.absoluteString);
    if ([request.URL.absoluteString hasPrefix:@"file:///aqaq"]) {
      NSString * s1 = [NSString stringWithFormat: @"got uri: %@", request.URL.absoluteString];
      NSString * e = [NSString stringWithFormat:@"%@('%@');", @"aqcallback", s1];

      dispatch_async(dispatch_get_main_queue(), ^{
        // FUTURE TBD: [myJSContext evaluateScript: e];
        [gWebView stringByEvaluatingJavaScriptFromString: e];
      });
    }
    return NO;
}

+ (NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void) startLoading {
    //NSLog(@"start loading");
}

- (void) stopLoading {
    //NSLog(@"stop loading");
}

@end
