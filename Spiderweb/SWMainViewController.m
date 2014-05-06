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

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTextField *titleField;
@property (weak) IBOutlet NSTextField *uniqueIDField;

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

- (void)loadView
{
    [super loadView];
    [self updateFieldsWithNode:nil];
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

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [self updateFieldsWithNode:self.selectedNode];

}

- (SWNode *)selectedNode
{
    NSIndexSet *selectedRows = self.tableView.selectedRowIndexes;

    if (selectedRows.count == 1) {
        NSUInteger selectedRow = selectedRows.firstIndex;
        return self.models[selectedRow];
    }

    return nil;
}

- (void)updateFieldsWithNode:(SWNode *)node
{
    if (!node) {
        self.titleField.enabled = NO;
        self.titleField.stringValue = @"";
        self.uniqueIDField.stringValue = @"";
    } else {
        self.titleField.enabled = YES;
        self.titleField.stringValue = node.title ?: @"";
        self.uniqueIDField.stringValue = node.uniqueID.UUIDString;
    }
}

@end
