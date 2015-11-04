//
//  MyURLProtocol.h
//  qsa
//

#import <Foundation/Foundation.h>

@interface AQHandler : NSObject

- (void) handleMessage: (NSString *)name withParameters: (NSString *) parameters;

@end

@interface MyURLProtocol : NSURLProtocol

@end

@interface AQManager : NSObject

+ (void) addHandler: (AQHandler *)handler for: (NSString *)name;
+ (AQHandler *) getHandlerFor: (NSString *) name;

@end
