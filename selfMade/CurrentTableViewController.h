////
////  CalendarTableViewController.h
////  selfMade
////
////  Created by Air on 4/11/14.
////  Copyright (c) 2014 Air. All rights reserved.
////

#import <UIKit/UIKit.h>
#import "ParentTableViewController.h"
#import "CurrentViewController.h"

@class CurrentViewController;

@interface CalendarTableViewController : ParentTableViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) CurrentViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (NSString *)getEntityName;

@end