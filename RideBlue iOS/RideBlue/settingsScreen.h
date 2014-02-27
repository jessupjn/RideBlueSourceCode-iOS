//
//  settingsScreen.h
//  RideBlue
//
//  Created by Jackson on 10/31/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Constant.h"
#import "returnsHandler.h"


@interface settingsScreen : UIViewController{
  NSInteger objectToSave;
  NSString *origString;
  NSInteger selectedRow;
}

@property (nonatomic, strong) UIView *navBar;

@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) NSArray *optionsArray;
@property (nonatomic, strong) NSUserDefaults *defaults;


@end
