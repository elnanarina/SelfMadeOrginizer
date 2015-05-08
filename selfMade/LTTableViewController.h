//
//  DetailViewController.h
//  selfMade
//
//  Created by Air on 3/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTViewController.h"
#import "RightTableViewController.h"

@class LTViewController;

@interface LTTableViewController : RightTableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) LTViewController *detailViewController;
@property (nonatomic) BOOL jumpNeeded;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (NSString *)getEntityName;
- (NSString *)getAttributeName;

@end

