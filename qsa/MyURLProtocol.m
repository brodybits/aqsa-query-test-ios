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
        NSString * req = request.URL.absoluteString;
        NSArray * topComponents = [req componentsSeparatedByString: @"#"];
        //NSString * s1 = [NSString stringWithFormat: @"got components: %@ %@", [topComponents objectAtIndex: 0], [topComponents count] < 2 ? @"" : [topComponents objectAtIndex: 1]];
        if ([topComponents count] < 2) {
            NSLog(@"SORRY missing # in URI: %@", req);
            return NO;
        }

        NSString * handleString = [topComponents objectAtIndex: 1];
        NSArray * handleComponents = [handleString componentsSeparatedByString: @"?"];
        if ([handleComponents count] < 2) {
            NSLog(@"SORRY missing ? in URI: %@", req);
            return NO;
        }

        NSArray * routeComponents = [[handleComponents objectAtIndex: 0] componentsSeparatedByString: @":"];
        if ([routeComponents count] < 2) {
            NSLog(@"SORRY missing : in URI: %@", req);
            return NO;
        }

        NSArray * routeParamComponents = [[routeComponents objectAtIndex: 1] componentsSeparatedByString: @"@"];
        if ([routeParamComponents count] < 2) {
            NSLog(@"SORRY missing @ in URI: %@", req);
            return NO;
        }

        NSString * s1 = [NSString stringWithFormat: @"got obj: %@ method: %@ code: %@ params: %@", [routeComponents objectAtIndex: 0], [routeParamComponents objectAtIndex: 0], [routeParamComponents objectAtIndex: 1], [handleComponents objectAtIndex: 1]];

        NSString * myScript = [NSString stringWithFormat:@"%@('%@');", @"aqcallback", s1];

        dispatch_async(dispatch_get_main_queue(), ^{
            // FUTURE TBD: [myJSContext evaluateScript: myScript];
            [gWebView stringByEvaluatingJavaScriptFromString: myScript];
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
