//
//  MyURLProtocol.m
//  qsa
//

#import "MyURLProtocol.h"

#import <UIKit/UIKit.h>

#import "AQManager.h"

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

        NSString * parameters = [handleComponents objectAtIndex: 1];

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

        NSString * me = [routeParamComponents objectAtIndex: 0];
        // XXX SECURITY TODO: use code parameter to check a security code, like they do in the Cordova framework
        //NSString * code = [routeParamComponents objectAtIndex: 1];
        // ...

        AQHandler * handler = [AQManager getHandlerFor:[routeComponents objectAtIndex:0]];
        if (handler != nil) {
            [handler handleMessage: me withParameters: parameters];
        }
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
