//
//  SWAppDelegate.m
//  Spiderweb
//
//  Created by Matt Rubin on 5/4/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import "SWAppDelegate.h"
#import "SWPersistenceManager.h"


@implementation SWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    SWPersistenceManager *persistenceManager = [SWPersistenceManager new];
    NSURL *dirURL = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"spiderweb"]];
    NSArray *models = [persistenceManager modelsFromDirectoryAtURL:dirURL];
    NSLog(@"MODELS:\n%@", models);
    [persistenceManager saveModels:models toDirectoryAtURL:dirURL];
}

@end
