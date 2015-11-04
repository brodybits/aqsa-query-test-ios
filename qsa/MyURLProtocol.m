//
//  MyURLProtocol.m
//  qsa
//

#import "MyURLProtocol.h"

#import <UIKit/UIKit.h>

// XXX TODO MOVE:
extern UIWebView *gWebView;

@implementation AQHandler

// TBD ???:
- (id) init
{
    self = [super init];
    return self;
}

- (void) handleMessage: (NSString *)name withParameters: (NSString *) parameters
{
    NSLog(@"got message name: %@ with parameters: %@", name, parameters);
}

@end

// XXX TODO MOVE:
static NSMutableDictionary * myHandlers = nil;

@implementation AQManager

+ (void) addHandler:(AQHandler *)handler for:(NSString *)name
{
    static dispatch_once_t my_init_token;
    static NSMutableDictionary * my_handlers = nil;

    dispatch_once(&my_init_token, ^{
        myHandlers = my_handlers = [[NSMutableDictionary alloc] init];
    });
    [myHandlers setObject: handler forKey: name];
}

+ (AQHandler *) getHandlerFor: (NSString *) name
{
    return (myHandlers == nil) ? nil : [myHandlers objectForKey: name];
}

@end

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
