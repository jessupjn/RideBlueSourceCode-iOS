//
//  frontScreen.m
//  RideBlue
//
//  Created by Jackson on 10/17/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import "frontScreen.h"

@interface frontScreen () <UIAlertViewDelegate>

@end

@implementation frontScreen

@synthesize getRide, cancelRide, queuePosition, settings, spinner, returnHandler, defaults;



// ==========================================================================
//
//                     UIALERTVIEW DELEGATE METHODS
//
// ==========================================================================
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if( buttonIndex )
  {
    if(alertView.tag == 0) [self changeInfo];
    else if(alertView.tag == 1) [self cancelReq:[[alertView textFieldAtIndex:0].text intValue]];
    else if(alertView.tag == 2) if( buttonIndex ) [self queryReq:[[alertView textFieldAtIndex:0].text intValue]];
  }

}
// ==========================================================================
// ==========================================================================












// ==========================================================================
//
//                     VIEWDIDLOAD   --   VIEWWILLAPPEAR
//
// ==========================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"RideBlue"];
  
  UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
  [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
  [self.view addGestureRecognizer:swipeGesture];
  
  defaults = [NSUserDefaults standardUserDefaults];
  if ( ![defaults boolForKey:@"firstTime"] ) [self firstTimeUser];
  
  
  [self.getRide.layer setCornerRadius:10];
  [self.cancelRide.layer setCornerRadius:10];
  [self.queuePosition.layer setCornerRadius:10];
  [self.settings setTitle:@"\u2699" forState:UIControlStateNormal];
  
  [self.settings setCenter:CGPointMake(30, DEVICEHEIGHT-30)];
  if(IS_IPHONE_5) [self.cancelRide setCenter:CGPointMake(DEVICEWIDTH/2, settings.center.y-85)];
  else [self.cancelRide setCenter:CGPointMake(DEVICEWIDTH/2, settings.center.y-65)];
  [self.queuePosition setCenter:CGPointMake(DEVICEWIDTH/2, cancelRide.center.y - 60)];
  [self.getRide setCenter:CGPointMake(DEVICEWIDTH/2, queuePosition.center.y - 60)];

  [self.cancelRide.layer setBorderWidth: 2];
  [self.cancelRide.layer setBorderColor: NAVYBGROUND.CGColor];
  [self.getRide.layer setBorderWidth: 2];
  [self.getRide.layer setBorderColor: NAVYBGROUND.CGColor];
  [self.queuePosition.layer setBorderWidth: 2];
  [self.queuePosition.layer setBorderColor: NAVYBGROUND.CGColor];
  
  spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  [spinner setCenter:self.view.center];
  [spinner setHidesWhenStopped:YES];
  [self.view addSubview:spinner];
}

-(void) viewWillAppear:(BOOL)animated{
  [self.cancelRide setHidden:YES];
  [self.queuePosition setHidden:YES];
  [self.getRide setCenter:self.queuePosition.center];
  NSDateFormatter *datePickerFormat = [[NSDateFormatter alloc] init];
  [datePickerFormat setDateFormat:@"yyyy-MM-dd"];
  if( [[defaults stringForKey:@"submittedAlready"] isEqualToString:[datePickerFormat stringFromDate:[NSDate new]]]){
    [self.cancelRide setHidden:NO];
    [self.queuePosition setHidden:NO];
    [self.getRide setCenter:CGPointMake(DEVICEWIDTH/2, queuePosition.center.y - 60)];
  }
}
// ==========================================================================
// ==========================================================================













// ==========================================================================
//
//                        QUERY POSITION IN LINE
//
// ==========================================================================
-(IBAction)posInLine:(id)sender{
  UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Get your position:" message:@"Enter your UMID to get your position in line." delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Get Position", nil];
  alert.alertViewStyle = UIAlertViewStylePlainTextInput;
  [[alert textFieldAtIndex:0] setTextAlignment:NSTextAlignmentCenter];
  [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
  [[alert textFieldAtIndex:0] becomeFirstResponder];
  [[alert textFieldAtIndex:0] setText:[defaults objectForKey:@"umid"]];
  [alert setTag:2];
  [alert show];
}
-(void)queryReq:(int)UMIDnum
{
  ServerSpeak *req = [[ServerSpeak alloc] init];
  int result = [req shootRequest:2
                       withFName:@"1"
                       withLname:@"1"
                        withLocF:@"1"
                        withLocT:@"1"
                        withUMID:UMIDnum
                       withPhone:@"1"
                    withComments:@" "];
  dispatch_async(dispatch_get_main_queue(),^{
    returnHandler = [[returnsHandler alloc] init];
    [returnHandler handle:result];
  });
  
  if((result >= 0 ))
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Position:"
                                                    message:[NSString stringWithFormat:@"You are number %i in line.", result]
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
  }
}
// ==========================================================================
// ==========================================================================











// ==========================================================================
//
//                           CANCEL YOUR RIDE
//
// ==========================================================================
-(IBAction)cancelYourRide:(id)sender{
  UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Cancel Your Ride:" message:@"Enter your UMID to cancel your request for a ride." delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Cancel Ride", nil];
  alert.alertViewStyle = UIAlertViewStylePlainTextInput;
  [[alert textFieldAtIndex:0] setTextAlignment:NSTextAlignmentCenter];
  [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
  [[alert textFieldAtIndex:0] becomeFirstResponder];
  [[alert textFieldAtIndex:0] setText:[defaults objectForKey:@"umid"]];
  [alert setTag:1];
  [alert show];
}
-(void)cancelReq:(int)UMIDnum
{
  ServerSpeak *req = [[ServerSpeak alloc] init];
  int result = [req shootRequest:1
                       withFName:@"1"
                       withLname:@"1"
                        withLocF:@"1"
                        withLocT:@"1"
                        withUMID:UMIDnum
                       withPhone:@"1"
                    withComments:@" "];
  dispatch_async(dispatch_get_main_queue(),^{
    returnHandler = [[returnsHandler alloc] init];
    [returnHandler handle:result];
  });
  
  // Cancel was successful.
  if(result == 800){
    [self.cancelRide setHidden:YES];
    [self.queuePosition setHidden:YES];
    [UIView animateWithDuration:0.2 animations:^{
      [self.getRide setCenter:self.queuePosition.center];
    }];
  }
}
// ==========================================================================
// ==========================================================================












// ==========================================================================
//
//                      CONNECTIONS TO OTHER SCREENS
//
// ==========================================================================
-(IBAction)goToHelp:(id)sender{
  HelpScreen *newVC = [[HelpScreen alloc] init];
  [self.navigationController pushViewController:newVC animated:YES];
}

-(IBAction)getRide:(id)sender{
  submitRequest *newVC = [[submitRequest alloc] init];
  [self.navigationController pushViewController:newVC animated:YES];
}

-(IBAction)goToSettings:(id)sender{
  settingsScreen *newVC = [[settingsScreen alloc] init];
  [self.navigationController pushViewController:newVC animated:YES];
}
// ==========================================================================
// ==========================================================================
















// ==========================================================================
//
//                          FIRST TIME USER
//
// ==========================================================================
-(void) changeInfo
{
  [self goToSettings:self];
}
-(void) firstTimeUser
{
  defaults = [NSUserDefaults standardUserDefaults];
  [defaults setBool:YES forKey:@"firstTime"];
  [defaults setObject:[[NSMutableArray alloc] init] forKey:@"locationList"];
  [defaults synchronize];
  
  UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Welcome to RideBlue!" message:@"Would you like to set some default information about yourself?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
  [alert setTag:0];
  [alert show];
}
// ==========================================================================
// ==========================================================================


-(void) resignKeyboard{
  [self.view endEditing:YES];
}

@end
