//
//  CurrentViewController.m
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "CurrentViewController.h"

@interface CurrentViewController ()

@end

@implementation CurrentViewController

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
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"longTerm"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    _detailDescriptionLabel = [[UILabel alloc] init];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [buttonBack setBackgroundImage:YOURImage forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    _backButton = [[UIBarButtonItem alloc] initWithCustomView:buttonBack]; // UIBarButtonItem *
    
    [buttonBack setTitle:@"Cancel" forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = _backButton;
    
    [self.view addSubview:buttonBack];
    
    
    //    [[self navigationController] setDelegate:self];
    //    self.navigationItem.hidesBackButton = NO;
    //    [self.view addSubview:_detailDescriptionLabel];
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    label.backgroundColor= [UIColor redColor];
    //    [self.view addSubview:label];
    //    _detailDescriptionLabel = [UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(IBAction)pressBack:(id)sender {
    NSLog(@"backpressed");
    //    [self.navigationController popToViewController: animated:<#(BOOL)#>];
    [self.navigationController popViewControllerAnimated:NO];
    NSLog(@"------------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
