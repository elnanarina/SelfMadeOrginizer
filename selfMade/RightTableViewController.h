//
//  RightTableViewController.h
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RightTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (NSString *)getEntityName;
- (NSString *)getAttributeName;

@property (strong, nonatomic) UIBarButtonItem *menu;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (nonatomic) UIPopoverController *masterPopoverController;

@end
