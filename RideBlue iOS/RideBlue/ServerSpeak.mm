//
//  ServerSpeak.m
//  RideBlue
//
//  Created by Jackson on 1/21/14.
//  Copyright (c) 2014 RideBlue. All rights reserved.
//

#import "ServerSpeak.h"
#include "RideBlueUserSubmissionData.pb.h"

@implementation ServerSpeak


-(id) init{
  return self;
}


// ------------------------------------------------------
//                    CREATE REQUEST FOR SERVER
//
// ------------------------------------------------------
-(int)shootRequest:(int)reqType
         withFName:(NSString *)fname
         withLname:(NSString*)lname
          withLocF:(NSString *)fromAdd
          withLocT:(NSString *)toAdd
          withUMID:(int)UMID
         withPhone:(NSString *)phoneNum
      withComments:(NSString *)notes{
  NSLog(@"First Name:  %@", fname);
  NSLog(@"Last Name:   %@", lname);
  NSLog(@"From:   %@", fromAdd);
  NSLog(@"To:    %@", toAdd);
  NSLog(@"UMID:   %d", UMID);
  NSLog(@"Phone#:   %@", phoneNum);
  NSLog(@"Comments:   %@", notes);
  SubmissionData::SubmissionData submissionDataForTesting;
  submissionDataForTesting.set_firstname( [fname UTF8String] );
  submissionDataForTesting.set_lastname( [lname UTF8String] );
  submissionDataForTesting.set_locationfrom( [fromAdd UTF8String] );
  submissionDataForTesting.set_locationto( [toAdd UTF8String] );
  submissionDataForTesting.set_umid( UMID );
  submissionDataForTesting.set_requesttype(reqType);    // Submit request
  submissionDataForTesting.set_deviceid( [[[UIDevice currentDevice].identifierForVendor UUIDString] UTF8String] );
  submissionDataForTesting.set_phonenumer( [phoneNum UTF8String] );
  submissionDataForTesting.set_comments( [notes UTF8String] );
  
  
  char *dataForSubmissionCStr = (char *)malloc(submissionDataForTesting.ByteSize());
  submissionDataForTesting.SerializeToArray(dataForSubmissionCStr, submissionDataForTesting.ByteSize());
  
  return [self talkToServer:submissionDataForTesting withCStr:dataForSubmissionCStr];
}


// ------------------------------------------------------
//                    TALK TO SERVER
//
// ------------------------------------------------------
-(int)talkToServer:(SubmissionData::SubmissionData) submissionDataForTesting
           withCStr:(char *)dataForSubmissionCStr
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error:" message:@"Could not connect to the server. Please make sure you are connected to a network" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
  
  // start connection with server
  int sockfd, portno;
  struct hostent *server;
  struct sockaddr_in serv_addr;
  
  // set parameters
  portno = 12345;
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if (sockfd < 0)
  {
    NSLog(@"ERROR opening socket");
    [alert show];
    return 0;
  }
  //server = gethostbyname("127.0.0.1");
  server = gethostbyname("ec2-75-101-198-44.compute-1.amazonaws.com");
  if (server == NULL)
  {
    [alert show];
    return 0;
  }
  bzero((char *)&serv_addr, sizeof(serv_addr));
  serv_addr.sin_family = AF_INET;
  bcopy((char *)server->h_addr,
        (char *)&serv_addr.sin_addr.s_addr,
        server->h_length);
  serv_addr.sin_port = htons(portno);
  
  // connect
  if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0)
  {
    NSLog(@"ERROR connecting");
    return 0;
  }
  
  // submit data
  int msgLen = submissionDataForTesting.ByteSize();
  int nMsgLen = htonl(msgLen);
  
  if (send(sockfd, &nMsgLen, 4, 0) == -1)
  {
    NSLog(@"ERROR sending packet size");
    [alert show];
    return 0;
  }
  if (send(sockfd, dataForSubmissionCStr, msgLen, 0) == -1)
  {
    NSLog(@"ERROR sending packet content");
    [alert show];
    return 0;
  }
  
  int recvMsgLen = 0;
  int recvMessage = 0;
  if (recv(sockfd, &recvMsgLen, 4, MSG_WAITALL) == -1)
  {
    NSLog(@"ERROR receiving response size");
    [alert show];
    return 0;
  }
  if (recv(sockfd, &recvMessage, ntohl(recvMsgLen), MSG_WAITALL) == -1)
  {
    NSLog(@"ERROR receiving response");
    [alert show];
    return 0;
  }
  NSLog(@"Response from server: %d", recvMessage);

  close(sockfd);
  return recvMessage;
  
}
// ------------------------------------------------------
// ------------------------------------------------------

@end
