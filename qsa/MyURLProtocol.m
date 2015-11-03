//
//  MyURLProtocol.m
//  qsa
//
//  Created by C. Brody on 11/2/15.
//  Copyright (c) 2015 C. Brody. All rights reserved.
//

#import "MyURLProtocol.h"

#import <UIKit/UIKit.h>

extern UIWebView *gWebView;

@implementation MyURLProtocol

+ (BOOL) canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"got uri: %@", request.URL.absoluteString);
    if ([request.URL.absoluteString hasPrefix:@"file:///aqaq"]) {
      dispatch_async(dispatch_get_main_queue(), ^{
        NSString * s1 = [NSString stringWithFormat: @"got uri: %@", request.URL.absoluteString];
        NSString * e = [NSString stringWithFormat:@"%@('%@', '%@');", @"TestObjectCB", @"safd", s1];
        // FUTURE TBD: [self.myContext evaluateScript: e];
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
