//
//  AQHandler.m
//
//  Author: Christopher J. Brody
//
//  License: UNLICENSE (public domain)
//

#import "AQHandler.h"

@implementation AQHandler

- (void) handleMessage: (NSString *)name withParameters: (NSString *) parameters
{
    NSLog(@"got message name: %@ with parameters: %@", name, parameters);
}

@end
