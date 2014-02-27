//
//  Constant.h
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#ifndef SoapBox_Constant_h
#define SoapBox_Constant_h

#define BARBUTTONFRAME CGRectMake(0, 0, 30, 30)

#define DEVICEHEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define GRAY1 [UIColor colorWithRed:19/255.0f green:19/255.0f blue:19/255.0f alpha:1.0f]
#define GRAY2 [UIColor colorWithRed:31/255.0f green:31/255.0f blue:31/255.0f alpha:1.0f]
#define NAVY [UIColor colorWithRed:24/255.0f green:44/255.0f blue:68/255.0f alpha:1.0f]
#define NAVYBGROUND [UIColor colorWithRed:15/255.0f green:28/255.0f blue:46/255.0f alpha:1.0f]
#define YELLOWTITLE [UIColor colorWithRed:255/255.0f green:205/255.0f blue:96/255.0f alpha:1.0f]



#endif
