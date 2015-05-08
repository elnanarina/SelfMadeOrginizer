//
//  SMViewController.h
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *chooseSection;
@property (weak, nonatomic) IBOutlet UIButton *detailDescription;
@property (weak, nonatomic) IBOutlet UITextField *taskText;

@property (nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
