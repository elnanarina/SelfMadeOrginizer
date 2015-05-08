//
//  CalendarViewController.h
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController <UINavigationControllerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate> //UIPickerViewDataSource, UIPickerViewDelegate, 

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextField *titleDescription;
@property (weak, nonatomic) IBOutlet UITextView *detailDescription;
@property (retain, nonatomic) UISwitch *isPerformSwith;
@property (retain, nonatomic) UISwitch *isTakeTimeSwith;

@property (nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic) IBOutlet UIButton *dateButton;
@property (strong, nonatomic) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addTimeLabel;
@property (strong, nonatomic) UIAlertView *alert;

- (IBAction)pressSave:(id)sender;

@end
