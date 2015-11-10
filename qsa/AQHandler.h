//
//  AQHandler.h
//
//  Author: Christopher J. Brody
//
//  License: UNLICENSE (public domain)
//

#import <Foundation/Foundation.h>

@interface AQHandler : NSObject

- (void) handleMessage: (NSString *)name withParameters: (NSString *) parameters cbHandler: (NSString *) cbHandler cbId: (NSString *) cbid;

@end
