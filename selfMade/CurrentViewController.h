//
//  CurrentViewController.h
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) UILabel *detailDescriptionLabel;

@property (nonatomic) IBOutlet UIBarButtonItem *backButton;
- (IBAction)pressBack:(id)sender;

@end
