//
//  SWMainViewController.m
//  Spiderweb
//
//  Created by Matt Rubin on 5/5/14.
//  Copyright (c) 2014 Matt Rubin. All rights reserved.
//

#import "SWMainViewController.h"
#import "SWNode.h"


@interface SWMainViewController () <NSTableViewDataSource, NSTableViewDelegate>

@end


@implementation SWMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}


#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.models.count;
}


#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];

    SWNode *node = [self.models objectAtIndex:row];

    if ([tableColumn.identifier isEqualToString:@"TitleColumn"]) {
        cellView.textField.stringValue = node.title ?: @"";
    }

    return cellView;
}

@end
