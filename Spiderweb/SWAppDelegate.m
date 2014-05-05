//
//  SWAppDelegate.m
//  Spiderweb
//
//  Created by Matt Rubin on 5/4/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import "SWAppDelegate.h"

@implementation SWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSURL *dirURL = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"spiderweb"]];
    [self scanDirectoryAtURL:dirURL];
}

- (void)scanDirectoryAtURL:(NSURL *)directoryToScan
{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSDirectoryEnumerator *dirEnumerator = [fileManager enumeratorAtURL:directoryToScan
                                             includingPropertiesForKeys:@[NSURLNameKey,
                                                                          NSURLIsRegularFileKey,
                                                                          NSURLIsReadableKey]
                                                                options:NSDirectoryEnumerationSkipsHiddenFiles |
                                                                        NSDirectoryEnumerationSkipsPackageDescendants |
                                                                        NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                                           errorHandler:^BOOL(NSURL *url, NSError *error) {
                                                               NSLog(@"ERROR: %@", error);
                                                               return YES;
                                                           }];

    for (NSURL *theURL in dirEnumerator) {
        NSNumber *isRegularFile;
        [theURL getResourceValue:&isRegularFile forKey:NSURLIsRegularFileKey error:NULL];
        if (!isRegularFile.boolValue) {
            continue;
        }

        NSNumber *isReadable;
        [theURL getResourceValue:&isReadable forKey:NSURLIsReadableKey error:NULL];
        if (!isReadable.boolValue) {
            continue;
        }

        NSString *fileName;
        [theURL getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
        NSLog(@"%@ :", fileName);


        NSStringEncoding stringEncoding;
        NSError *readError;
        NSString *fileString = [NSString stringWithContentsOfURL:theURL
                                                    usedEncoding:&stringEncoding
                                                           error:&readError];
        if (readError) {
            NSLog(@"Read error: %@", readError.localizedDescription);
        }
        NSLog(@"%@", fileString);
    }
}

@end
