//
//  LTView.h
//  selfMade
//
//  Created by Air on 4/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextField *detailText;
@property (strong, nonatomic) NSString *priority;

@property (nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
