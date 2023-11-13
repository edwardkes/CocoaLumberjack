// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2023, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

#import "HTTPLogger.h"

@interface HTTPLogger ()

@property (strong, nonatomic) NSURL *apiEndPoint;

@end

@implementation HTTPLogger

- (instancetype)initWithAPIEndpoint:(NSURL *)endpoint {
    self = [super init];
    if (self) {
        _apiEndPoint = endpoint;
    }
    return self;
}

-(void)logMessage:(DDLogMessage *)logMessage {
    
    NSString *logString = logMessage.message;
    
    NSDictionary *logDict = @{@"message": logString};
    NSData *logData = [NSJSONSerialization dataWithJSONObject:logDict options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.apiEndPoint];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:logData];
    [request setValue:@"application/json" forKey:@"Content-Type"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error sending log to server: %@", error);
        }
        // Handle the response here
    }]resume];
}

@end
