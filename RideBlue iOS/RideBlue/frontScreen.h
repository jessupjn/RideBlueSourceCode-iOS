//
//  frontScreen.h
//  RideBlue
//
//  Created by Jackson on 10/17/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "submitRequest.h"
#import "settingsScreen.h"
#import "HelpScreen.h"
#import "Constant.h"
#import "ServerSpeak.h"
#import "returnsHandler.h"


@interface frontScreen : UIViewController

// when submitting a request
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) returnsHandler *returnHandler;
@property (nonatomic, strong) NSUserDefaults *defaults;


//back view
@property (nonatomic, strong) IBOutlet UIButton *getRide;
@property (nonatomic, strong) IBOutlet UIButton *queuePosition;
@property (nonatomic, strong) IBOutlet UIButton *cancelRide;
@property (nonatomic, strong) IBOutlet UIButton *settings;
@property (nonatomic, strong) IBOutlet UIButton *helpButton;

-(IBAction)cancelYourRide:(id)sender;
-(IBAction)posInLine:(id)sender;
-(IBAction)goToHelp:(id)sender;

@end
