//
//  SWNode.h
//  Spiderweb
//
//  Created by Matt Rubin on 5/5/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "SWPersistentModel.h"


@interface SWNode : MTLModel <MTLJSONSerializing, SWPersistentModel>

@property (nonatomic, copy) NSString *title;

@end
