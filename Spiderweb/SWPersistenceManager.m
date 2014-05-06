//
//  SWPersistenceManager.m
//  Spiderweb
//
//  Created by Matt Rubin on 5/5/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import "SWPersistenceManager.h"
#import "SWModel.h"


@implementation SWPersistenceManager

- (NSArray *)modelsFromDirectoryAtURL:(NSURL *)directoryToScan
{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSDirectoryEnumerator *dirEnumerator = [fileManager enumeratorAtURL:directoryToScan
                                             includingPropertiesForKeys:@[NSURLIsRegularFileKey,
                                                                          NSURLIsReadableKey]
                                                                options:NSDirectoryEnumerationSkipsHiddenFiles |
                                            NSDirectoryEnumerationSkipsPackageDescendants |
                                            NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                                           errorHandler:^BOOL(NSURL *url, NSError *error) {
                                                               NSLog(@"ERROR: %@", error);
                                                               return YES;
                                                           }];

    NSMutableArray *models = [NSMutableArray array];

    for (NSURL *theURL in dirEnumerator) {
        // Check that the URL points to a readable regular file

        NSError *resourceValueError;

        NSNumber *isRegularFile;
        [theURL getResourceValue:&isRegularFile forKey:NSURLIsRegularFileKey error:&resourceValueError];
        if (!isRegularFile.boolValue || resourceValueError) {
            continue;
        }

        NSNumber *isReadable;
        [theURL getResourceValue:&isReadable forKey:NSURLIsReadableKey error:&resourceValueError];
        if (!isReadable.boolValue || resourceValueError) {
            continue;
        }

        // Read in the file as a JSON object

        NSError *jsonError;
        NSData *jsonData = [NSData dataWithContentsOfURL:theURL
                                                 options:0
                                                   error:&jsonError];
        if (jsonError) {
            NSLog(@"Error: %@ (%@)", jsonError.localizedDescription, theURL);
            continue;
        }

        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:0
                                                          error:&jsonError];
        if (jsonError) {
            NSLog(@"Error: %@ (%@)", jsonError.localizedDescription, theURL);
            continue;
        }

        // Convert the JSON into a model object

        NSError *modelError;
        SWModel *model = [MTLJSONAdapter modelOfClass:[SWModel class]
                                   fromJSONDictionary:jsonObject
                                                error:&modelError];
        if (modelError) {
            NSLog(@"Error: %@ (%@)", modelError.localizedDescription, theURL);
            continue;
        }

        if (model) {
            [models addObject:model];
        } else {
            NSLog(@"UNKNOWN ERROR: reached the end of file import without a valid model object.");
        }
    }

    return models;
}

- (void)saveModels:(NSArray *)models toDirectoryAtURL:(NSURL *)directory
{
    for (SWModel *model in models) {
        NSAssert([model isKindOfClass:[SWModel class]], @"Attempted to save a non-model object: %@", model);

        NSDictionary *jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:model];

        NSError *jsonError;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&jsonError];
        if (jsonError) {
            NSLog(@"Error: %@", jsonError.localizedDescription);
            continue;
        }

        NSURL *fileURL = [directory URLByAppendingPathComponent:model.persistentFileName];
        fileURL = [fileURL URLByAppendingPathExtension:@"json"];

        NSError *writeError;
        [jsonData writeToURL:fileURL
                     options:0
                       error:&writeError];
        if (writeError) {
            NSLog(@"Error: %@", writeError.localizedDescription);
            continue;
        }
    }
}

@end
