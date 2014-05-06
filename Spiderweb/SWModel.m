//
//  SWModel.m
//  Spiderweb
//
//  Created by Matt Rubin on 5/5/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import "SWModel.h"


@implementation SWModel

- (NSUUID *)uniqueID
{
    if (!_uniqueID) {
        _uniqueID = [NSUUID UUID];
    }
    return _uniqueID;
}

+ (NSValueTransformer *)uniqueIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *uuidString) {
        if (![uuidString isKindOfClass:[NSString class]]) return nil;
        return [[NSUUID alloc] initWithUUIDString:uuidString];
    } reverseBlock:^id(NSUUID *uuid) {
        if (![uuid isKindOfClass:[NSUUID class]]) return nil;
        return uuid.UUIDString;
    }];
}


#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"uniqueID": @"ID"};
}


#pragma mark - SWPersistentModel

- (NSString *)persistentFileName
{
    return self.uniqueID.UUIDString;
}

@end
