//
//  AQManager.h
//
//  Author: Christopher J. Brody
//
//  License: UNLICENSE (public domain)
//

#import "AQHandler.h"

@interface AQManager : NSObject

+ (void) addHandler: (AQHandler *)handler for: (NSString *)name;
+ (AQHandler *) getHandlerFor: (NSString *) name;

@end
