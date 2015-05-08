//
//  MasterViewController.m
//  selfMade
//
//  Created by Air on 3/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@property NSArray *objects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _objects = [[NSArray alloc] initWithObjects:@"LongTerm", @"Calendar", @"Self Made 24/7", nil];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

//    NSLog(@"svc view did load");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _objects[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        if ([[_objects objectAtIndex:indexPath.row] isEqual: @"LongTerm"]) {
            LTTableViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"0"];
        
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [[self.splitViewController.viewControllers objectAtIndex:1] pushViewController:detail animated:NO];
        } else {
            [self.navigationController pushViewController:detail animated:NO];
        }
    } else if ([[_objects objectAtIndex:indexPath.row] isEqual: @"Calendar"]) {
        CalendarTableViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"1"];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [[self.splitViewController.viewControllers objectAtIndex:1] pushViewController:detail animated:NO];
        } else {
            [self.navigationController pushViewController:detail animated:NO];
        }
    } else if ([[_objects objectAtIndex:indexPath.row] isEqual: @"Self Made 24/7"]) {
        CalendarTableViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"2"];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [[self.splitViewController.viewControllers objectAtIndex:1] pushViewController:detail animated:NO];
        } else {
            [self.navigationController pushViewController:detail animated:NO];
        }
    }
    } else {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"LongTerm" sender:self];
                break;
                
            case 1:
                [self performSegueWithIdentifier:@"Calendar" sender:self];
                break;
                
            case 2:
                [self performSegueWithIdentifier:@"SelfMade" sender:self];
                break;
        }
    }
}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController showViewController:(UIViewController *)vc sender:(id)sender {
    return YES;
}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}


@end
