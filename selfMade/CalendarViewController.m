//
//  CalendarViewController.m
//  selfMade
//
//  Created by Air on 6/11/14.
//  Copyright (c) 2014 Air. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController () {
    NSString *isPerforming;
    NSString *isTakeTime;
    NSString *dateString;
    
    UIPopoverController *popOverForDatePicker;
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    NSDateFormatter *dateFormatter;
}

@end

@implementation CalendarViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        self.titleDescription.text = [[self.detailItem valueForKey:@"titleTask"] description];
        self.detailDescription.text = [[self.detailItem valueForKey:@"textTask"] description];
        dateString = [[self.detailItem valueForKey:@"performDate"] description];
        timePicker.date = [self.detailItem valueForKey:@"performTime"];
        isPerforming = [[self.detailItem valueForKey:@"isPerform"] description];
        isTakeTime = [[self.detailItem valueForKey:@"isTakeTime"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"Calendar detail";
    
    _saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(pressSave:)];
    self.navigationItem.rightBarButtonItem = _saveButton;
    
    _isPerformSwith = [[UISwitch alloc] initWithFrame:CGRectMake(160, 555, 0, 0)];
    [_isPerformSwith addTarget:self action:@selector(changePerformSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_isPerformSwith];
    
    _isTakeTimeSwith = [[UISwitch alloc] initWithFrame:CGRectMake(240, 130, 0, 0)];
    [_isTakeTimeSwith addTarget:self action:@selector(changeTimeSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_isTakeTimeSwith];
    
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 320, 162)];
    timePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 320, 162)];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    [timePicker setLocale:[NSLocale systemLocale]];
    
    datePicker.hidden = YES;
    timePicker.hidden = YES;
    _dateButton.layer.cornerRadius = 5;
    _timeButton.layer.cornerRadius = 5;

    [datePicker addTarget:self action:@selector(datePickerChange) forControlEvents:UIControlEventValueChanged];
    [timePicker addTarget:self action:@selector(timePickerChange) forControlEvents:UIControlEventValueChanged];
    
    [self configureView];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    datePicker.date = [dateFormatter dateFromString:dateString];
    _dateLabel.text = dateString;
    [dateFormatter setDateFormat:@"HH:mm"];
    _timeLabel.text = [dateFormatter stringFromDate:timePicker.date];
    
    if ([isPerforming isEqualToString:@"1"]) {
        [_isPerformSwith setOn:YES animated:NO];
    } else {
        [_isPerformSwith setOn:NO animated:NO];
    }
    
    if ([isTakeTime isEqualToString:@"1"]) {
        [_isTakeTimeSwith setOn:YES animated:NO];
        _timeLabel.hidden = NO;
        _timeButton.hidden = NO;
        _addTimeLabel.hidden = NO;
    } else if ([isTakeTime isEqualToString:@"0"]) {
        [_isTakeTimeSwith setOn:NO animated:NO];
        _timeLabel.hidden = YES;
        _timeButton.hidden = YES;
        _addTimeLabel.hidden = YES;
    }
}


- (IBAction)pressSave:(id)sender {
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [dateFormatter stringFromDate:datePicker.date];
    [self.detailItem setValue:_titleDescription.text forKey:@"titleTask"];
    [self.detailItem setValue:_detailDescription.text forKey:@"textTask"];
    [self.detailItem setValue:dateString forKey:@"performDate"];
    [self.detailItem setValue:timePicker.date forKey:@"performTime"];
    [self.detailItem setValue:@([isPerforming intValue]) forKey:@"isPerform"];
    [self.detailItem setValue:@([isTakeTime intValue]) forKey:@"isTakeTime"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changePerformSwitch:(id)sender{
    if([sender isOn]){
        isPerforming = @"1";
        [_isPerformSwith setOn:YES animated:YES];
//        NSLog(@"Switch is ON");
    } else{
//        NSLog(@"Switch is OFF");
        [_isPerformSwith setOn:NO animated:YES];
        isPerforming = @"0";
    }
}

- (void)changeTimeSwitch:(id)sender{
    timePicker.datePickerMode = UIDatePickerModeTime;
    [timePicker setLocale:[NSLocale systemLocale]];
    
    if([sender isOn]){
//        NSLog(@"Switch is ON");
        isTakeTime = @"1";
        [_isTakeTimeSwith setOn:YES animated:YES];
        _timeLabel.hidden = NO;
        _timeButton.hidden = NO;
        _addTimeLabel.hidden = NO;
    } else{
//        NSLog(@"Switch is OFF");
        [_isTakeTimeSwith setOn:NO animated:YES];
        isTakeTime = @"0";
        _timeLabel.hidden = YES;
        _timeButton.hidden = YES;
        _addTimeLabel.hidden = YES;
    }
    [dateFormatter setDateFormat:@"HH:mm"];
    _timeLabel.text = [dateFormatter stringFromDate:timePicker.date];
}

#pragma mark - change date

- (void)datePickerChange {
    datePicker.datePickerMode = UIDatePickerModeDate;
    timePicker.date = datePicker.date;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _dateLabel.text = [dateFormatter stringFromDate:datePicker.date];
}

- (void)timePickerChange {
    timePicker.datePickerMode = UIDatePickerModeTime;
    [dateFormatter setDateFormat:@"HH:mm"];
    _timeLabel.text = [dateFormatter stringFromDate:timePicker.date];
}

- (IBAction)dateChange:(UIButton *)sender {
        datePicker.hidden = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIViewController *viewController = [[UIViewController alloc]init];
        UIView *viewForDatePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 162)];
    
        
    
        [viewForDatePicker addSubview:datePicker];
        [viewController.view addSubview:viewForDatePicker];
    
        popOverForDatePicker = [[UIPopoverController alloc]initWithContentViewController:viewController];
        popOverForDatePicker.delegate = self;
        [popOverForDatePicker setPopoverContentSize:CGSizeMake(320, 160) animated:NO];
        [popOverForDatePicker presentPopoverFromRect:sender.frame inView:self.view  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown| UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight) animated:YES];
    } else {
        UIAlertController *searchActionSheet = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];

        [ searchActionSheet.view setBounds:CGRectMake(0, 0, 320, 160)];
        [searchActionSheet.view addSubview:datePicker];

        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [searchActionSheet addAction:ok];
        
        [self presentViewController:searchActionSheet animated:YES completion:nil];
    }
}

- (IBAction)timeChange:(UIButton *)sender {
    timePicker.hidden = NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIViewController *viewController = [[UIViewController alloc]init];
        UIView *viewForDatePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 162)];

        [viewForDatePicker addSubview:timePicker];
        [viewController.view addSubview:viewForDatePicker];
    
        popOverForDatePicker = [[UIPopoverController alloc]initWithContentViewController:viewController];
        popOverForDatePicker.delegate = self;
        [popOverForDatePicker setPopoverContentSize:CGSizeMake(320, 160) animated:NO];
        [popOverForDatePicker presentPopoverFromRect:sender.frame inView:self.view  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown| UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight) animated:YES];
    } else {
        UIAlertController *searchActionSheet = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [ searchActionSheet.view setBounds:CGRectMake(0, 0, 320, 160)];
        [searchActionSheet.view addSubview:timePicker];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [searchActionSheet addAction:ok];
        
        [self presentViewController:searchActionSheet animated:YES completion:nil];
    }
}

@end
