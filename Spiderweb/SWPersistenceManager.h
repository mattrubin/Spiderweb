//
//  SWPersistenceManager.h
//  Spiderweb
//
//  Created by Matt Rubin on 5/5/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

@import Foundation;


@interface SWPersistenceManager : NSObject

- (NSArray *)nodesFromDirectoryAtURL:(NSURL *)directoryToScan;

- (void)saveModels:(NSArray *)models toDirectoryAtURL:(NSURL *)directory;

@end
