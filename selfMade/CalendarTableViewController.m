////
////  CalendarTableViewController.m
////  selfMade
////
////  Created by Air on 4/11/14.
////  Copyright (c) 2014 Air. All rights reserved.
////

#import "CalendarTableViewController.h"
#import <CoreText/CoreText.h>

@interface CalendarTableViewController ()

@property NSString *titleTask;
@property NSString *text;
@property NSString *performDate;
@property NSString *performTime;
@property NSString *isTakeTime;

@property NSArray *sectionsArray;
@property NSMutableArray *sectionsMutableArray;
@property NSDictionary *taskDictioner;
@property NSArray *monthsArray;
@property NSIndexPath *managerIndexPath;
@property NSManagedObject *objectForAlert;

@end

@implementation CalendarTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Calendar";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UIBarButtonItem *customBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(goBack)];
        self.navigationItem.leftBarButtonItem = customBackButton;
    } else {
        if ([self.splitViewController respondsToSelector:@selector(displayModeButtonItem)]){
            
            self.navigationController.topViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        }
        self.navigationItem.leftBarButtonItem.title = @"Menu";
    }
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        self.detailViewController = (CalendarViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    }
    _titleTask = @"titleTask";
    _text = @"textTask";
    _performDate = @"performDate";
    _performTime = @"performTime";
    _isTakeTime = @"isTakeTime";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    _monthsArray = [dateFormatter monthSymbols];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"reloadTheTable" object:nil];
}

-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getEntityName {
    return @"Calendar";
}

- (NSString *)getAttributeName {
    return _titleTask;
}

- (NSString *)getSortedMetod {
    return _performDate;
}

- (BOOL)isAscending {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)insertNewObject:(id)sender {
    [self performSegueWithIdentifier:@"InsertNew" sender:sender];
}

- (void)reloadTable:(NSNotification *)notification {
    [self saveContext];
    [self.tableView reloadData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"CalendarView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object;
        if ( indexPath == nil ) {
            object = _objectForAlert;
        } else {
            object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        }

        CalendarViewController *controller = (CalendarViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
    }
    if ([[segue identifier] isEqualToString:@"InsertNew"]) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *stringDate = [dateFormatter stringFromDate:[NSDate date]];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
        
        [newManagedObject setValue:date forKey:_performTime];
        [newManagedObject setValue:stringDate forKey:_performDate];
        [newManagedObject setValue:@"new.." forKey:_titleTask];
        [newManagedObject setValue:@"" forKey:_text];
        [newManagedObject setValue:@0 forKey:@"isPerform"];
        [newManagedObject setValue:@0 forKey:_isTakeTime];
        
        CalendarViewController *controller = (CalendarViewController *)[segue destinationViewController];
        [controller setDetailItem:newManagedObject];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Table View
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *rawDateStr = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    NSArray *subStrings = [rawDateStr componentsSeparatedByString:@"-"];
    NSString *monthString = [subStrings objectAtIndex:1];
    
    int monthIndex = [monthString intValue] - 1;
    NSString *monthSymbol = [_monthsArray objectAtIndex:monthIndex];
    
    NSMutableString *resultDate = [[NSMutableString alloc] initWithFormat:@"%@ %@ %@", [subStrings objectAtIndex:2], monthSymbol, [subStrings objectAtIndex:0]];

    return resultDate;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSInteger seconds = [[NSTimeZone defaultTimeZone] secondsFromGMTForDate: [NSDate date]];
    NSDate *today = [[NSDate alloc] initWithTimeInterval:seconds sinceDate:[NSDate date]];
    NSDate *perfTime = [[NSDate alloc] initWithTimeInterval:seconds sinceDate:[object valueForKey:_performTime]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"HH:mm"];
    NSString *perfDate = [[object valueForKey:_performDate] description];
    NSString *time = [formatter stringFromDate:perfTime];
    NSString *text = [[object valueForKey:_titleTask] description];
    NSMutableString *title;
    NSString *isTakeTime = [[object valueForKey:_isTakeTime] description];
    if ( [isTakeTime isEqualToString:@"0"]) {
        title = [[NSMutableString alloc] initWithString:text];
    } else {
        title = [[NSMutableString alloc] initWithFormat:@"%@    |  |    %@", time, text];
    }

    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc]initWithString:title];
    NSString *isPerform = [[object valueForKey:@"isPerform"] description];
    if ([isPerform isEqualToString:@"1"]) {
        [attString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [title length])];
        cell.textLabel.attributedText = attString;
        cell.textLabel.textColor = [UIColor grayColor];
    } else {
        [attString addAttribute:title value:0 range:NSMakeRange(0, 0)];
        cell.textLabel.attributedText = attString;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    if ( [today compare:perfTime] == NSOrderedDescending && _objectForAlert == nil ) {
        if ([isPerform isEqualToString:@"0"] && [isTakeTime isEqualToString:@"1"]) {
//            cell.backgroundColor = [UIColor redColor];
//            if ([isTakeTime isEqualToString:@"1"]) {
                NSString *massage = [[NSString alloc] initWithFormat:@"\'%@\'\nperform date: %@, time: %@", text, perfDate, time];
                _objectForAlert = object;
                _managerIndexPath = indexPath;
                [self addAlertView:massage];
//                NSLog(@"table view");
//            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"CalendarView" sender:indexPath];
}

#pragma mark - Alert create

-(void)addAlertView:(NSString *)massage{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"You have expired task:"
                                                       message:massage
                                                      delegate:self
                                             cancelButtonTitle:@"Delete"
                                             otherButtonTitles:@"Change", nil];
    [alertView show];
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0: {
            NSLog(@"Delete");
            NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
            
            [context deleteObject:_objectForAlert];
            _objectForAlert = nil;
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            [self.tableView reloadData];
            break;
        }
        case 1: {
            NSLog(@"Change task");
            [self performSegueWithIdentifier:@"CalendarView" sender:nil];
            break;
        }
        default:
            break;
    }
}
#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(IBAction)unwind:(UIStoryboardSegue*)segue {
}

@end
