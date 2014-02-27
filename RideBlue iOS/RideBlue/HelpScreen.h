//
//  HelpScreen.h
//  RideBlue
//
//  Created by Jackson on 12/22/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface HelpScreen : UIViewController

@property (nonatomic, strong) UIView *navBar;

@property (nonatomic, strong) IBOutlet UIImageView *pic1;
@property (nonatomic, strong) IBOutlet UIImageView *pic2;
@property (nonatomic, strong) IBOutlet UIImageView *pic3;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollBox;

@property (nonatomic, strong) IBOutlet UILabel *label1;
@property (nonatomic, strong) IBOutlet UILabel *label2;
@property (nonatomic, strong) IBOutlet UILabel *label3;

@end
