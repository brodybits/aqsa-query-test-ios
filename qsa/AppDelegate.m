//
//  AppDelegate.m
//  qsa
//

#import "AppDelegate.h"

#import "AQManager.h"
#import "AQURLProtocol.h"

// XXX TODO MOVE:
extern UIWebView *gWebView;

@interface TestHandler : AQHandler

@end

@implementation TestHandler

- (void) handleMessage:(NSString *)name withParameters:(NSString *)parameters
{
    NSLog(@"test handler got message: %@ with parameters: %@", name, parameters);
    NSString * s1 = [NSString stringWithFormat: @"got method: %@ params: %@", name, parameters];
    
    NSString * myScript = [NSString stringWithFormat:@"%@('%@');", @"aqcallback", s1];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // FUTURE TBD: [myJSContext evaluateScript: myScript];
        [gWebView stringByEvaluatingJavaScriptFromString: myScript];
    });
}

@end


@interface AppDelegate ()

@property AQHandler * myHandler;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSURLProtocol registerClass:[AQURLProtocol class]];
    self.myHandler = [[TestHandler alloc] init];
    [AQManager addHandler:self.myHandler for:@"th"];
    [AQManager addHandler:self.myHandler for:@"as"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
