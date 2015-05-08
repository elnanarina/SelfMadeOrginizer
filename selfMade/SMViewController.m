//
//  SMViewController.m
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "SMViewController.h"

@interface SMViewController () {
    IBOutlet UIDatePicker *datePicker;
}

@property NSString *columnSection;
@property NSString *columnText;
@property NSString *finalDate;

@end


@implementation SMViewController

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
        self.taskText.text = [[self.detailItem valueForKey:@"text"] description];
        self.chooseSection.text = [[self.detailItem valueForKey:@"section"] description];
        datePicker.date = [self.detailItem valueForKey:@"finalDate"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"Self made detail";
    
    _saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(pressSave)];
    self.navigationItem.rightBarButtonItem = _saveButton;
    _detailDescription = [UIButton buttonWithType:UIButtonTypeCustom];
    _detailDescription.layer.cornerRadius = 5;
    
    _columnText = @"text";
    _columnSection = @"section";
    _finalDate = @"finalDate";
    
    [self configureView];
}

- (void)pressSave {
    [self.detailItem setValue:_taskText.text forKey:_columnText];
    [self.detailItem setValue:_chooseSection.text forKey:_columnSection];
    [self.detailItem setValue:datePicker.date forKey:_finalDate];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - change section

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSArray *titles = @[@"1. My restrictions", @"2. My promises", @"3. Morning tasks", @"4. Tasks on during day", @"5. Evening tasks"];
    
    _chooseSection.text = titles[buttonIndex];

    [self.detailItem setValue:_chooseSection.text forKey:_columnSection];
    [self.detailItem setValue:_chooseSection.text forKey:_columnText];
}

- (IBAction)showActionSheet:(id)sender {
    NSString *cancelTitle = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"Cancel" : nil;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"choose a section:"
                                                             delegate:self
                                                    cancelButtonTitle:cancelTitle
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"1. My restrictions", @"2. My promises", @"3. Morning tasks", @"4. Tasks on during day", @"5. Evening tasks", nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // In this case the device is an iPad.
        [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        // In this case the device is an iPhone/iPod Touch.
        [actionSheet showInView:self.view];
    }
    
    actionSheet.tag = 300;
}



@end
