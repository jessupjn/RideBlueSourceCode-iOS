//
//  returnsHandler.m
//  RideBlue
//
//  Created by Jackson on 11/13/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import "returnsHandler.h"

@implementation returnsHandler

-(id) init{
  return self;
}

-(void) handle:(int)num{
  if(num == 800) [self return800];
  else if (num == 801) [self return801];
  else if(num == 902) [self return902];
  else if(num == 903) [self return903];
  else if(num == 904) [self returnNeg909];
  else if(num == 905) [self return905];
  else if(num == 906) [self returnNeg909];
  else if(num == 907) [self return907];
  else if(num == -908) [self returnNeg908];
  else if(num == -909) [self returnNeg909];
  else if(num == 910) [self returnNeg910];
}

-(void) return800{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your request for a ride has been cancelled." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults removeObjectForKey:@"submittedAlready"];
  [defaults synchronize];
}
-(void) return801{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your request for a ride has been received." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSDateFormatter *datePickerFormat = [[NSDateFormatter alloc] init];
  [datePickerFormat setDateFormat:@"yyyy-MM-dd"];
  [defaults setObject:[datePickerFormat stringFromDate:[NSDate new]] forKey:@"submittedAlready"];
  [defaults synchronize];
}
-(void) return902{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"There was an error in submission. Please try again soon." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
}
-(void) return903{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"There was an error in cancellation. Please try again soon." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
}
-(void) return905{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"RideBlue is currently not in service hours (10pm-2am)." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
}
-(void) return907{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"You already have a request being processed." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
}
-(void) returnNeg908{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"There was an error in the query. Please try again soon." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
}
-(void) returnNeg909{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"You don't have a request being processed today. Please submit a request and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
}
-(void) returnNeg910{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"Your request has previously been cancelled." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
  [alert setDelegate:nil];
  [alert show];
}

@end
