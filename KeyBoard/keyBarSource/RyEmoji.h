//
//  RyEmoji.h
//  RTPClient
//
//  Created by kevin on 14/11/25.
//
//

#import <Foundation/Foundation.h>

@interface RyEmoji : NSObject

+ (NSArray *)recent;

+ (NSArray *)peopel;

+ (NSArray *)nature;

+ (NSArray *)places;

+ (NSArray *)objects;

+ (NSArray *)symbols;

+ (void)saveRecent:(NSString *)enjoyString;

@end
