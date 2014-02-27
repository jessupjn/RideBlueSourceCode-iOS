//
//  ServerSpeak.h
//  RideBlue
//
//  Created by Jackson on 1/21/14.
//  Copyright (c) 2014 RideBlue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>
#import <string.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <netdb.h>
#include "returnsHandler.h"

@interface ServerSpeak : NSObject

-(int)shootRequest:(int)reqType
         withFName:(NSString *)fname
         withLname:(NSString*)lname
          withLocF:(NSString *)fromAdd
          withLocT:(NSString *)toAdd
          withUMID:(int)UMID
         withPhone:(NSString *)phoneNum
      withComments:(NSString *)notes;

@end
