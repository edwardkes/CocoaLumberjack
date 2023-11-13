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
@property (strong, nonatomic) dispatch_queue_t loggerQueue;

@end

@implementation HTTPLogger

@dynamic loggerQueue;

- (instancetype)initWithAPIEndpoint:(NSURL *)endpoint {
    self = [super init];
    if (self) {
        _apiEndPoint = endpoint;
        _loggerQueue = dispatch_queue_create("com.menora.httplogger", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(void)logMessage:(DDLogMessage *)logMessage {
    
    dispatch_async(self.loggerQueue, ^{
        NSString *logString = logMessage.message;
        
        NSDictionary *logDict = @{@"message": logString};
        NSData *logData = [NSJSONSerialization dataWithJSONObject:logDict options:0 error:nil];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.apiEndPoint];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:logData];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (error) {
                        NSLog(@"Error sending log to server: %@", error);
                        // Add error handling here
                    }
                    // Handle the response here
        }];
        [task resume];

    });
}

@end
