//
//  AQManager.m
//
//  Author: Christopher J. Brody
//
//  License: UNLICENSE (public domain)
//

#import "AQManager.h"

@implementation AQManager

// XXX TODO MOVE:
static NSMutableDictionary * myHandlers = nil;

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
