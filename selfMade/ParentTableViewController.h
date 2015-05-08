//
//  ParentTableViewController.h
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ParentTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic) NSString *tableName;
- (NSString *)getEntityName;
- (NSString *)getAttributeName;
- (NSString *)cacheName;

@end

//@protocol ParentTableViewController
//
//@property (nonatomic) NSString *tableName;
//
//@end