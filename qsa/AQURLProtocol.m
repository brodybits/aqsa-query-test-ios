//
//  AQURLProtocol.m
//
//  Author: Christopher J. Brody
//
//  License: UNLICENSE (public domain)
//

#import "AQURLProtocol.h"

#import <UIKit/UIKit.h>

#import "AQManager.h"

@implementation AQURLProtocol

+ (BOOL) canInitWithRequest:(NSURLRequest *)request {
    // XXX TBD is this really the most efficient possible?
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

        NSArray * routeParamComponents = [[routeComponents objectAtIndex: 1] componentsSeparatedByString: @"$"];
        if ([routeParamComponents count] < 2) {
            NSLog(@"SORRY missing $ in URI: %@", req);
            return NO;
        }

        NSString * method = [routeParamComponents objectAtIndex: 0];

        NSArray * internalComponents = [[routeParamComponents objectAtIndex: 1] componentsSeparatedByString: @"@"];
        if ([internalComponents count] < 2) {
            NSLog(@"SORRY missing @ in URI: %@", req);
            return NO;
        }

        NSArray * cbComponents = [[internalComponents objectAtIndex: 0] componentsSeparatedByString: @"-"];
        if ([cbComponents count] < 2) {
            NSLog(@"SORRY missing - in URI: %@", req);
            return NO;
        }


        // XXX SECURITY TODO: use code parameter to check a security code, like they do in the Cordova framework
        //NSString * code = [internalComponents objectAtIndex: 1];
        // ...

        AQHandler * handler = [AQManager getHandlerFor:[routeComponents objectAtIndex:0]];
        if (handler != nil) {
            [handler handleMessage: method withParameters: parameters cbHandler: [cbComponents objectAtIndex:0] cbId: [cbComponents objectAtIndex:1]];
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
