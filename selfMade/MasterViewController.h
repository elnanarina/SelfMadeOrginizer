//
//  MasterViewController.h
//  selfMade
//
//  Created by Air on 3/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "LTTableViewController.h"
#import "CalendarTableViewController.h"
#import "SMTableViewController.h"

@class LTTableViewController;
@class CalendarTableViewController;
@class SMTableViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) LTTableViewController *lTDetailViewController;
@property (strong, nonatomic) CalendarTableViewController *cDetailViewController;
@property (strong, nonatomic) SMTableViewController *sMDetailViewController;

@end

