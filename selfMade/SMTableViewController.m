//
//  SMTableViewController.m
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "SMTableViewController.h"

@interface SMTableViewController ()

@property NSString *sectionName;
@property NSString *textName;
@property NSString *finalDate;

@property NSArray *sectionsArray;
@property NSMutableDictionary *taskDictioner;

@end

@implementation SMTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Self made";
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
        self.detailViewController = (SMViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    _textName = @"text";
    _sectionName = @"section";
    _finalDate = @"finalDate";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"reloadTheTable" object:nil];
}

-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getEntityName {
    return @"SelfMade";
}

- (NSString *)getAttributeName {
    return _sectionName;
}

- (NSString *)getSortedMetod {
    return _sectionName;
}

- (BOOL)isAscending {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    [self performSegueWithIdentifier:@"InsertNew" sender:sender];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SMView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        SMViewController *controller = (SMViewController *)[segue destinationViewController];

        [controller setDetailItem:object];
    }
    if ([[segue identifier] isEqualToString:@"InsertNew"]) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        
        [newManagedObject setValue:@"1. My restrictions" forKey:_sectionName];
        [newManagedObject setValue:@"" forKey:_textName];
        [newManagedObject setValue:[NSDate date] forKey:_finalDate];
        
        SMViewController *controller = (SMViewController *)[segue destinationViewController];
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

- (void)reloadTable:(NSNotification *)notification {
    [self saveContext];
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    return sectionName;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo =
    [[self.fetchedResultsController sections]
     objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
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
    NSString *text = [[object valueForKey:_textName] description];
    NSDate *date = [object valueForKey:_finalDate];
    NSInteger days = (NSInteger)([date timeIntervalSinceNow] / 86400) + 1;

    if ( days <= 0 ) {
        days = 0;
    }
    NSString *time = [NSString stringWithFormat: @"%li", (long)days];
    NSMutableString *title = [[NSMutableString alloc] initWithString:time];
    
    if ( days <= 0 ) {
        [title appendString:@"        days before..   |  |    "];
        cell.backgroundColor = [UIColor redColor];
    } else if ( days < 10 && days > 0 ) {
        [title appendString:@"        days before..   |  |    "];
        cell.backgroundColor = [UIColor yellowColor];
    } else if ( days < 100 && days > 10 ) {
        [title appendString:@"      days before..   |  |    "];
    } else if ( days < 1000 && days > 100 ) {
        [title appendString:@"    days before..   |  |    "];
    } else {
        [title appendString:@"  days before..   |  |    "];
    }
    [title appendString:text];
    cell.textLabel.text = title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"SMView" sender:indexPath];
}

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
