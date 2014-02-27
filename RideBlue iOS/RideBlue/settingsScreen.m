//
//  settingsScreen.m
//  RideBlue
//
//  Created by Jackson on 10/31/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import "settingsScreen.h"

@interface settingsScreen () < UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>

@end

@implementation settingsScreen

@synthesize table, optionsArray, defaults, navBar;

// ======================================================================
//
//                UITABLEVIEW DELEGATE METHODS
//
// ======================================================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;    //count of section
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [optionsArray count];    //count number of row from counting array hear cataGorry is An Array
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil){
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:19.0]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
    [cell.textLabel setTextColor:YELLOWTITLE];
    [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 2, cell.frame.size.width-15, table.rowHeight)];
    [inputField setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
    [inputField setTextColor:[UIColor whiteColor]];
    [inputField setTextAlignment:NSTextAlignmentRight];
    [inputField setAdjustsFontSizeToFitWidth:YES];
    [inputField setTag:indexPath.row+1];
    [inputField setDelegate:self];
    [inputField setHidden:YES];
    [inputField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [inputField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    [inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [inputField setText:[NSString stringWithFormat:@"%i", indexPath.row]];
    
    NSInteger index = indexPath.row;
    if([[optionsArray objectAtIndex:index] isEqualToString:@"fname"])
      [cell.textLabel setText:@"First Name:"], [cell.detailTextLabel setText:[defaults objectForKey:@"firstName"]];
    else if([[optionsArray objectAtIndex:index] isEqualToString:@"lname"])
      [cell.textLabel setText:@"Last Name:"], [cell.detailTextLabel setText:[defaults objectForKey:@"lastName"]];
    else if([[optionsArray objectAtIndex:index] isEqualToString:@"umid"])
      [cell.textLabel setText:@"UMID Number:"], [cell.detailTextLabel setText:[defaults objectForKey:@"umid"]], [inputField setKeyboardType:UIKeyboardTypeNumberPad];
    else if([[optionsArray objectAtIndex:index] isEqualToString:@"pickup"])
      [cell.textLabel setText:@"Pickup Location:"], [cell.detailTextLabel setText:[defaults objectForKey:@"fromAddress"]];
    else if([[optionsArray objectAtIndex:index] isEqualToString:@"dropoff"])
      [cell.textLabel setText:@"Destination:"], [cell.detailTextLabel setText:[defaults objectForKey:@"toAddress"]];
    else if([[optionsArray objectAtIndex:index] isEqualToString:@"phone"])
      [cell.textLabel setText:@"Phone Number:"], [cell.detailTextLabel setText:[defaults objectForKey:@"phoneNum"]], [inputField setKeyboardType:UIKeyboardTypeNumberPad];
    
    [cell.contentView addSubview:inputField];
  }
  
  NSInteger index = indexPath.row;
  if([[optionsArray objectAtIndex:index] isEqualToString:@"fname"])
    [cell.textLabel setText:@"First Name:"], [cell.detailTextLabel setText:[defaults objectForKey:@"firstName"]];
  else if([[optionsArray objectAtIndex:index] isEqualToString:@"lname"])
    [cell.textLabel setText:@"Last Name:"], [cell.detailTextLabel setText:[defaults objectForKey:@"lastName"]];
  else if([[optionsArray objectAtIndex:index] isEqualToString:@"umid"])
    [cell.textLabel setText:@"UMID Number:"], [cell.detailTextLabel setText:[defaults objectForKey:@"umid"]];
  else if([[optionsArray objectAtIndex:index] isEqualToString:@"pickup"])
    [cell.textLabel setText:@"Pickup Location:"], [cell.detailTextLabel setText:[defaults objectForKey:@"fromAddress"]];
  else if([[optionsArray objectAtIndex:index] isEqualToString:@"dropoff"])
    [cell.textLabel setText:@"Destination:"], [cell.detailTextLabel setText:[defaults objectForKey:@"toAddress"]];
  else if([[optionsArray objectAtIndex:index] isEqualToString:@"phone"])
    [cell.textLabel setText:@"Phone Number:"], [cell.detailTextLabel setText:[defaults objectForKey:@"phoneNum"]];

  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  selectedRow = indexPath.row;
  
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  UITextField *tf = (UITextField *)[cell viewWithTag:indexPath.row+1];
  [tf setText:cell.detailTextLabel.text];
  [cell.detailTextLabel setHidden:YES];
  [tf setHidden:NO];
  [tf becomeFirstResponder];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  UITextField *tf = (UITextField *)[cell viewWithTag:indexPath.row+1];
  
  if(tf.tag == 3){
    if( ![[tf.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:@""] || (tf.text.length != 8)){
      [tf setText:origString];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"UMID must contain exactly 8 numeric characters!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
      [alert show];
    }
  }
  else if (tf.tag == 6){
    if( ![[tf.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:@""] || (tf.text.length != 10)){
      [tf setText:origString];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Phone number must contain exactly 10 numeric characters!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
      [alert show];
    }
  }
  tf.text = [tf.text uppercaseString];
  [cell.detailTextLabel setText:tf.text];
  [tf setHidden:YES];
  [cell.detailTextLabel setHidden:NO];
  [tf resignFirstResponder];
}
// ======================================================================
// ======================================================================















// ======================================================================
//
//                UIALERTVIEW DELEGATE METHODS
//
// ======================================================================
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  if(alertView.tag == 2 && buttonIndex){
    [defaults removeObjectForKey:@"firstName"];
    [defaults removeObjectForKey:@"lastName"];
    [defaults removeObjectForKey:@"umid"];
    [defaults removeObjectForKey:@"fromAddress"];
    [defaults removeObjectForKey:@"toAddress"];
    [defaults removeObjectForKey:@"phoneNum"];
    [defaults removeObjectForKey:@"locationList"];
    
    [defaults synchronize], [self.table reloadData];
    NSLog(@"Information Cleared");
  }
}
// ======================================================================
// ======================================================================















// ======================================================================
//
//                UITEXTFIELD DELEGATE METHODS
//
// ======================================================================
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
  origString = textField.text;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
  [self resignKeyboard];
  if(textField.tag == 1) [defaults setObject:textField.text forKey:@"firstName"];
  else if(textField.tag == 2) [defaults setObject:textField.text forKey:@"lastName"];
  else if(textField.tag == 3) [defaults setObject:textField.text forKey:@"umid"];
  else if(textField.tag == 4) [defaults setObject:textField.text forKey:@"fromAddress"];
  else if(textField.tag == 5) [defaults setObject:textField.text forKey:@"toAddress"];
  else if(textField.tag == 6) [defaults setObject:textField.text forKey:@"phoneNum"];
  
  [defaults synchronize], [table reloadData];
  
}
// ======================================================================
// ======================================================================






















// ======================================================================
//
//                VIEWDIDLOAD
//
// ======================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    navBar = [[UIView alloc] initWithFrame:CGRectMake(0,0,DEVICEWIDTH,64)];
    [navBar setBackgroundColor:NAVYBGROUND];
  

    // title.
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0,20,DEVICEWIDTH,44)];
    [title setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:25.0]];
    [title setTextColor:YELLOWTITLE];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:@"Profile Defaults"];
  
    // back button
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but1 setFrame:CGRectMake(10,20,50,44)];
    [but1.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0]];
    [but1 setTitle:@"Back" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
  
    [navBar addSubview:but1];
    [navBar addSubview:title];
    [self.view addSubview:navBar];
  
    defaults = [NSUserDefaults standardUserDefaults];
    optionsArray = [[NSArray alloc] initWithObjects:@"fname", @"lname", @"umid", @"pickup", @"dropoff", @"phone", nil];
  
    [table setDataSource:self];
    [table setDelegate:self];
    [table setScrollEnabled:NO];
    [table setContentOffset:CGPointMake(0, 10)];
    [table setBackgroundColor:[UIColor clearColor]];
    if( IS_IPHONE_5 ) [table setFrame:CGRectMake(0,64,320,DEVICEHEIGHT-280)];
    else [table setFrame:CGRectMake(0,44,320,344)], [table setRowHeight:34];;
    [table setAllowsSelectionDuringEditing:YES];
  
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeGesture];
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeGesture];
  
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setFrame:CGRectMake(10, DEVICEHEIGHT-70, 300, 44)];
    [clearButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0]];
    [clearButton setTitle:@"Clear Information" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearInfo) forControlEvents:UIControlEventTouchUpInside];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setBackgroundColor:NAVYBGROUND];
    [clearButton.layer setBorderColor:GRAY2.CGColor];
    [clearButton.layer setBorderWidth:1];
    [clearButton.layer setCornerRadius:10];
    [self.view addSubview:clearButton];
}
// ======================================================================
// ======================================================================













// ======================================================================
//
//                    CLEAR INFO BUTTON
//
// ======================================================================
-(void)clearInfo{

  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Caution:"
                                                  message:@"Are you sure that you want to clear your previous settings?"
                                                 delegate:self
                                        cancelButtonTitle:@"No"
                                        otherButtonTitles:@"Yes", nil];
  [alert setTag:2];
  [alert show];
}
// ======================================================================
// ======================================================================












// ======================================================================
//
//                        LITTLE FUNCTIONS
//
// ======================================================================
-(void) backPressed{
  [self resignKeyboard];
  [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void) resignKeyboard{
  [self.view endEditing:YES];
}
-(void) swipeBack{
  [self backPressed];
}
// ======================================================================
// ======================================================================


@end
