////
////  CalendarTableViewController.h
////  selfMade
////
////  Created by Air on 4/11/14.
////  Copyright (c) 2014 Air. All rights reserved.
////

#import <UIKit/UIKit.h>
#import "RightTableViewController.h"
#import "CalendarViewController.h"

@class CalendarViewController;

@interface CalendarTableViewController : RightTableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) CalendarViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (NSString *)getEntityName;

@end