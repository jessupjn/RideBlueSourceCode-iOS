//
//  submitRequest.m
//  RideBlue
//
//  Created by Jackson on 10/20/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import "submitRequest.h"

@interface submitRequest () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

@end

@implementation submitRequest

@synthesize navBar, pickupButton, pickerView, locationArray, submitButton, dismissButton;
@synthesize fname, lname, fromAdd, toAdd, phoneNum, UMID, notes;
@synthesize returnHandler, label1, label2, label3;




// ------------------------------------------------------
//                   UI PICKER VIEW FUNCTIONS
//
// ------------------------------------------------------
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return locationArray.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
  return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
  return [locationArray objectAtIndex:row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
  UILabel* tView = (UILabel*)view;
  if (!tView){
    tView = [[UILabel alloc] init];
    [tView setTextColor: YELLOWTITLE];
    [tView setTextAlignment:NSTextAlignmentCenter];
    [tView setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:24.0]];

  }
  [tView setText: [locationArray objectAtIndex:row]];
  return tView;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  [fromAdd setText:[locationArray objectAtIndex:row]];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
  return 34;
}
// ------------------------------------------------------
// ------------------------------------------------------









// ------------------------------------------------------
//                   UIALERTVIEW FUNCTIONS
//
// ------------------------------------------------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  if( alertView.tag == 1 ){
    if( buttonIndex ) [self cancelReq:[[alertView textFieldAtIndex:0].text intValue]];
  }
}
// ------------------------------------------------------
// ------------------------------------------------------











// ------------------------------------------------------
//                   WHEN THE VIEW LOADS
//
// ------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    [pickupButton.layer setCornerRadius:5];
  
    [dismissButton addTarget:self action:@selector(resignKeyboard) forControlEvents:UIControlEventTouchUpInside];
  
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeGesture];
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeGesture];
  
    // navigation bar programmatically.
    navBar = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICEWIDTH,64)];
    [navBar setBackgroundColor: NAVYBGROUND];

    // submit button.
    [submitButton.layer setBorderColor: GRAY2.CGColor];
    [submitButton.layer setBorderWidth:1];
    [submitButton.layer setCornerRadius:10];
    [submitButton setCenter:CGPointMake(DEVICEWIDTH/2, DEVICEHEIGHT-65)];
  
    // cancel button.
    [self.cancelButton.layer setBorderColor: GRAY2.CGColor];
    [self.cancelButton.layer setBorderWidth:1];
    [self.cancelButton.layer setCornerRadius:10];
    [self.cancelButton setCenter:CGPointMake(DEVICEWIDTH/2, DEVICEHEIGHT-65)];
  
    // title.
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0,20,DEVICEWIDTH,44)];
    [title setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:25.0]];
    [title setTextColor:YELLOWTITLE];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:@"Submit Request"];
  
    // back button
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but1 setFrame:CGRectMake(10,20,50,44)];
    [but1.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
    [but1 setTitle:@"Back" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
  
    // hidden resign keyboard button
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but2 setFrame:navBar.frame];
    [but2.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
    [but2 setTitle:@"" forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(resignKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:but2];
  
    [navBar addSubview:but1];
    [navBar addSubview:title];
    [self.view addSubview:navBar];
  
    self.defaults = [NSUserDefaults standardUserDefaults];
    if( [self.defaults valueForKey:@"firstName"] != NULL) fname.text = [self.defaults valueForKey:@"firstName"];
    if( [self.defaults valueForKey:@"lastName"] != NULL) lname.text = [self.defaults valueForKey:@"lastName"];
    if( [self.defaults valueForKey:@"fromAddress"] != NULL) fromAdd.text = [self.defaults valueForKey:@"fromAddress"];
    if( [self.defaults valueForKey:@"toAddress"] != NULL) toAdd.text = [self.defaults valueForKey:@"toAddress"];
    if( [self.defaults valueForKey:@"phoneNum"] != NULL) phoneNum.text = [self.defaults valueForKey:@"phoneNum"];
    if( [self.defaults valueForKey:@"umid"] != NULL) UMID.text = [self.defaults valueForKey:@"umid"];

  if( !IS_IPHONE_5 ){
    [fname setCenter:CGPointMake(fname.center.x, fname.center.y-5)];
    [lname setCenter:CGPointMake(lname.center.x, lname.center.y-5)];

    CGRect fr = fname.frame;
    fr.size.height -= 5;
    [fname setFrame:fr];
    fr.origin.y += 30;
    [UMID setFrame:fr];
    
    fr = lname.frame;
    fr.size.height -= 5;
    [lname setFrame:fr];
    fr.origin.y += 30;
    [phoneNum setFrame:fr];
    
    [toAdd setCenter:CGPointMake(toAdd.center.x, toAdd.center.y-65)];
    [pickupButton setCenter:CGPointMake(pickupButton.center.x, pickupButton.center.y-55)];
    [fromAdd setCenter:CGPointMake(fromAdd.center.x, fromAdd.center.y-55)];

    
    [label1 setCenter:CGPointMake(label1.center.x, label1.center.y-55)];
    [label2 setCenter:CGPointMake(label2.center.x, label2.center.y-65)];
    [label3 setCenter:CGPointMake(label3.center.x, label3.center.y-5)];

  }
  
  pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, DEVICEHEIGHT, DEVICEWIDTH, 200)];
  pickerView.dataSource = self;
  pickerView.delegate = self;
  [pickerView setBackgroundColor: NAVYBGROUND];
  [self.view addSubview:pickerView];
  
}

-(void)viewWillAppear:(BOOL)animated{
  NSDateFormatter *datePickerFormat = [[NSDateFormatter alloc] init];
  [datePickerFormat setDateFormat:@"yyyy-MM-dd"];
  if( [[self.defaults stringForKey:@"submittedAlready"] isEqualToString:[datePickerFormat stringFromDate:[NSDate new]]]){
    [self.submitButton setCenter:CGPointMake(self.cancelButton.center.x, self.cancelButton.center.y-60)];
  }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// ------------------------------------------------------
// ------------------------------------------------------










// ------------------------------------------------------
//                    SUBMIT BUTTON
//
// ------------------------------------------------------
-(IBAction)submitClicked:(id)sender{
  NSLog(@"Submit Form");
  if([fname.text isEqualToString:@""] || [lname.text isEqualToString:@""] || [fromAdd.text isEqualToString:@""] || [toAdd.text isEqualToString:@""] || [UMID.text isEqualToString:@""] || [phoneNum.text isEqualToString:@""])
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"All fields must be filled!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
  }
  else if( ![[UMID.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:@""]  || (UMID.text.length != 8))
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"UMID must contain exactly 8 numeric characters!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
  }
  else if( ![[phoneNum.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:@""] || (phoneNum.text.length != 10))
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Phone number must be a valid US phone number beginning with the area code first!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    
  }
  else{
    
    ServerSpeak *req = [[ServerSpeak alloc] init];
    int result = [req shootRequest:0
                         withFName:fname.text
                         withLname:lname.text
                          withLocF:fromAdd.text
                          withLocT:toAdd.text
                          withUMID:[UMID.text intValue]
                         withPhone:phoneNum.text
                      withComments:notes.text];
    
    dispatch_async(dispatch_get_main_queue(),^{
      returnsHandler *ret = [[returnsHandler alloc] init];
      [ret handle:result];
    });
    
    // successfully submitted request form:
    if(result == 801){
      [UIView animateWithDuration:0.4 animations:^{
        [self.submitButton setCenter:CGPointMake(self.cancelButton.center.x, self.cancelButton.center.y-60)];
      }];
    }
    
  }
}

// ------------------------------------------------------
// ------------------------------------------------------









// ------------------------------------------------------
//                 PICKER VIEW BUTTON
//
// ------------------------------------------------------
-(IBAction)pickupDef:(id)sender{
  [self resignKeyboard];
  [pickerView reloadAllComponents];
  if(pickerView.frame.origin.y == DEVICEHEIGHT){
    [UIView animateWithDuration:0.25 animations:^(void){
      [pickerView setCenter:CGPointMake(pickerView.center.x, pickerView.center.y-175)];
    }];
  }
  else{
    [UIView animateWithDuration:0.25 animations:^(void){
      [pickerView setCenter:CGPointMake(pickerView.center.x, pickerView.center.y+175)];
    }];
  }
}
// ------------------------------------------------------
// ------------------------------------------------------












// ------------------------------------------------------
//                    CANCEL BUTTON
//
// ------------------------------------------------------
-(IBAction)cancelButton:(id)sender{
  UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Cancel Your Ride:"
                                                   message:@"Enter your UMID to cancel your request for a ride."
                                                  delegate:self
                                         cancelButtonTitle:@"Back"
                                         otherButtonTitles:@"Cancel Ride", nil];
  alert.alertViewStyle = UIAlertViewStylePlainTextInput;
  [[alert textFieldAtIndex:0] setTextAlignment:NSTextAlignmentCenter];
  [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
  [[alert textFieldAtIndex:0] becomeFirstResponder];
  [[alert textFieldAtIndex:0] setText:self.UMID.text];
  [alert setTag:1];
  [alert show];
}
-(void)cancelReq:(int)UMIDnum{
  
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
    returnsHandler *ret = [[returnsHandler alloc] init];
    [ret handle:result];
  });
  
  // successfully cancelled request:
  if(result == 800){
    [UIView animateWithDuration:0.4 animations:^{
      [self.submitButton setCenter:self.cancelButton.center];
    }];
  }
  
}
// ------------------------------------------------------
// ------------------------------------------------------












// ------------------------------------------------------
//                    LITTLE FUNCTIONS
//
// ------------------------------------------------------
-(void)textFieldChanged: (id)sender{
  UITextField *text = (UITextField *)sender;
  if([text.text length] > 255) text.text = [text.text substringToIndex:255];
  
  NSString *newMessage = [NSString stringWithFormat:@"Do you have any notes for the driver?\r\r(%i/255)", text.text.length];
  [self.alert setMessage:newMessage];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
  if( pickerView.frame.origin.y != DEVICEHEIGHT ){
    [UIView animateWithDuration:0.25 animations:^(void){
      [pickerView setCenter:CGPointMake(pickerView.center.x, pickerView.center.y+175)];
    }];
  }
  
  if(textField.tag == 7){
    NSLog(@"HERE");
    [UIView animateWithDuration:0.25 animations:^{
      [self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y-25)];
    }];
  }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
  textField.text = [textField.text uppercaseString];
  [UIView animateWithDuration:0.25 animations:^{
    [self.view setCenter:CGPointMake(DEVICEWIDTH/2, DEVICEHEIGHT/2)];
  }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self resignKeyboard];
  return NO;
}
-(void) swipeDown{
  if(pickerView.frame.origin.y != DEVICEHEIGHT){
    [UIView animateWithDuration:0.25 animations:^(void){
      [pickerView setCenter:CGPointMake(pickerView.center.x, pickerView.center.y+175)];
    }];
  }
  [self resignKeyboard];
}

-(void) swipeBack{
  [self backPressed];
}
-(void) backPressed{
  [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void) resignKeyboard{
  [self.view endEditing:YES];
}
// ------------------------------------------------------
// ------------------------------------------------------

@end
