//
//  SWAppDelegate.m
//  Spiderweb
//
//  Created by Matt Rubin on 5/4/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import "SWAppDelegate.h"
#import "SWMainViewController.h"
#import "SWPersistenceManager.h"


@interface SWAppDelegate ()

@property (nonatomic, strong) SWMainViewController *mainViewController;

@end


@implementation SWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    SWPersistenceManager *persistenceManager = [SWPersistenceManager new];
    NSURL *dirURL = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"spiderweb"]];
    NSArray *models = [persistenceManager modelsFromDirectoryAtURL:dirURL];
    NSLog(@"MODELS:\n%@", models);

    self.mainViewController = [[SWMainViewController alloc] initWithNibName:@"SWMainViewController" bundle:nil];
    self.mainViewController.models = models;

    [self.window.contentView addSubview:self.mainViewController.view];
    self.mainViewController.view.frame = ((NSView *)self.window.contentView).bounds;

//    [persistenceManager saveModels:models toDirectoryAtURL:dirURL];
}

@end
