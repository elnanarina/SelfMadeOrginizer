//
//  DaraManager.h
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//
//@property (nonatomic) NSString* tableName;
//@property ()
//
//- (NSManagedObjectContext *)insert;
////- (void)deleteObject;
//- (NSManagedObject *)getObjectAtIndexPath:(NSIndexPath *)indexPath;

@end
