//
//  submitRequest.h
//  RideBlue
//
//  Created by Jackson on 10/20/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Constant.h"
#import "ServerSpeak.h"
#import "returnsHandler.h"


@interface submitRequest : UIViewController

// nav bar and populates locations
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) NSMutableArray *locationArray;
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) UIAlertView *alert;

// when submitting a request
@property (nonatomic, strong) returnsHandler *returnHandler;

@property (nonatomic, strong) IBOutlet UILabel *label1;
@property (nonatomic, strong) IBOutlet UILabel *label2;
@property (nonatomic, strong) IBOutlet UILabel *label3;

@property (nonatomic, strong) IBOutlet UIButton *dismissButton;
@property (nonatomic, strong) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) IBOutlet UITextField *fname;
@property (nonatomic, strong) IBOutlet UITextField *lname;
@property (nonatomic, strong) IBOutlet UITextField *fromAdd;
@property (nonatomic, strong) IBOutlet UITextField *toAdd;
@property (nonatomic, strong) IBOutlet UITextField *phoneNum;
@property (nonatomic, strong) IBOutlet UITextField *UMID;
@property (nonatomic, strong) IBOutlet UITextField *notes;
@property (nonatomic, strong) IBOutlet UIButton *pickupButton;
@property (nonatomic, strong) UIPickerView *pickerView;



-(IBAction)pickupDef:(id)sender;
-(IBAction)submitClicked:(id)sender;

@end
