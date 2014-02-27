//
//  HelpScreen.m
//  RideBlue
//
//  Created by Jackson on 12/22/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import "HelpScreen.h"

@interface HelpScreen () <UIScrollViewAccessibilityDelegate, UIScrollViewDelegate>

@end

@implementation HelpScreen


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICEWIDTH,64)];
  [self.navBar setBackgroundColor:NAVYBGROUND];
  
  
  // title.
  UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0,20,DEVICEWIDTH,44)];
  [title setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:25.0]];
  [title setTextColor:YELLOWTITLE];
  [title setTextAlignment:NSTextAlignmentCenter];
  [title setText:@"Help Menu"];

  // back button
  UIButton *but1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [but1 setFrame:CGRectMake(10,20,50,44)];
  [but1.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
  [but1 setTitle:@"Back" forState:UIControlStateNormal];
  [but1 addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.navBar addSubview:but1];
  [self.navBar addSubview:title];
  [self.view addSubview:self.navBar];
  
  UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack)];
  [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
  [self.view addGestureRecognizer:swipeGesture];
  
  [self.pic1.layer setBorderWidth:1];
  [self.pic2.layer setBorderWidth:1];
  [self.pic3.layer setBorderWidth:1];
  
  [self.pic1.layer setBorderColor:[UIColor whiteColor].CGColor];
  [self.pic2.layer setBorderColor:[UIColor whiteColor].CGColor];
  [self.pic3.layer setBorderColor:[UIColor whiteColor].CGColor];

  [self.scrollBox setContentSize:CGSizeMake(320, 1200)];
  [self.scrollBox setScrollEnabled:YES];
  [self.scrollBox setShowsVerticalScrollIndicator:YES];
}


-(void) swipeBack{
  [self backPressed];
}
-(void) backPressed{
  [self resignKeyboard];
  [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void) resignKeyboard{
  [self.view endEditing:YES];
}
@end
