//
//  SWNode.m
//  Spiderweb
//
//  Created by Matt Rubin on 5/5/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import "SWNode.h"


@implementation SWNode

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"title": @"Title"};
}


#pragma mark - SWPersistentModel

- (NSString *)persistentFileName
{
    return [self.title.lowercaseString stringByReplacingOccurrencesOfString:@" " withString:@"-"];
}

@end
