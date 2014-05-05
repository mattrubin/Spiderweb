//
//  SWNode.h
//  Spiderweb
//
//  Created by Matt Rubin on 5/5/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface SWNode : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *title;

@end
