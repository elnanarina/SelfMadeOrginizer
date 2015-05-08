//
//  LTView.m
//  selfMade
//
//  Created by Air on 4/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "LTViewController.h"

@interface LTViewController () {
    BOOL moved;
}

@property (nonatomic) IBOutlet UIButton *high;
@property (nonatomic) IBOutlet UIButton *middle;
@property (nonatomic) IBOutlet UIButton *low;
@property (nonatomic) IBOutlet UIButton *none;

@end

@implementation LTViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailText.text = [[self.detailItem valueForKey:@"longTerm"] description];
        self.priority = [[self.detailItem valueForKey:@"priority"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"Long Term detail";
    _saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = _saveButton;
    
    [self configureView];
    
    _high.layer.cornerRadius = 5;
    _middle.layer.cornerRadius = 5;
    _low.layer.cornerRadius = 5;
    _none.layer.cornerRadius = 5;
    
    if ([self.priority isEqualToString:@"1"]) {
        _high.backgroundColor = [UIColor redColor];
        _middle.backgroundColor = [UIColor whiteColor];
        _low.backgroundColor = [UIColor whiteColor];
    } else if ([self.priority isEqualToString:@"2"]) {
        _high.backgroundColor = [UIColor whiteColor];
        _middle.backgroundColor = [UIColor yellowColor];
        _low.backgroundColor = [UIColor whiteColor];
    } else if ([self.priority isEqualToString:@"3"]){
        _high.backgroundColor = [UIColor whiteColor];
        _middle.backgroundColor = [UIColor whiteColor];
        _low.backgroundColor = [UIColor greenColor];
    } else {
        _high.backgroundColor = [UIColor whiteColor];
        _middle.backgroundColor = [UIColor whiteColor];
        _low.backgroundColor = [UIColor whiteColor];
    }
    [_detailText resignFirstResponder];
}

-(IBAction)choosePriority:(UIButton *)sender {
    if (sender.tag == 1) {
        self.priority = @"1";
        sender.backgroundColor = [UIColor redColor];
        _middle.backgroundColor = [UIColor whiteColor];
        _low.backgroundColor = [UIColor whiteColor];
    } else if (sender.tag == 2) {
        self.priority = @"2";
        sender.backgroundColor = [UIColor yellowColor];
        _high.backgroundColor = [UIColor whiteColor];
        _low.backgroundColor = [UIColor whiteColor];
    } else if (sender.tag == 3){
        self.priority = @"3";
        sender.backgroundColor = [UIColor greenColor];
        _middle.backgroundColor = [UIColor whiteColor];
        _high.backgroundColor = [UIColor whiteColor];
    } else {
        self.priority = @"0";
        _low.backgroundColor = [UIColor whiteColor];
        _middle.backgroundColor = [UIColor whiteColor];
        _high.backgroundColor = [UIColor whiteColor];
    }
}

- (void)save {
    [self.detailItem setValue:_detailText.text forKey:@"longTerm"];
    [self.detailItem setValue:@([_priority intValue]) forKey:@"priority"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:self.detailItem];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end