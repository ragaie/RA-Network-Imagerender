//
//  GetRemoteData.m
//  NetworkRequest
//
//  Created by Ragaie Alfy on 6/15/17.
//  Copyright © 2017 Ragaie Alfy. All rights reserved.
//

#import "GetRemoteData.h"

@implementation GetRemoteData


-(void)RequestData:(NSDictionary *)Headers bodyParameter:(NSDictionary *)parameter urlString:(NSString *)urlString httpWay:(HttpWay *)way responseDelegate:(id)delegate responseSelector:(SEL)selector{
    
    
    UIApplication *   app = [UIApplication sharedApplication];
    
    app.networkActivityIndicatorVisible = YES;
    
    dispatch_queue_t concurrentQueue;
    if (concurrentQueue == NULL ){
        
        concurrentQueue  = dispatch_queue_create("com.concurrent.queue", DISPATCH_QUEUE_SERIAL);
    }
    dispatch_semaphore_t concurrencyLimitingSemaphore = dispatch_semaphore_create(6);
    
    if ([self CheckconnectionType] == 3){
        
        concurrencyLimitingSemaphore = dispatch_semaphore_create(6);
        
    }
    else  if ([self CheckconnectionType] == 2){
        
        concurrencyLimitingSemaphore = dispatch_semaphore_create(2);
        
    }

    
    dispatch_async(concurrentQueue, ^{
        /* work goes here */
        dispatch_semaphore_wait(concurrencyLimitingSemaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_semaphore_signal(concurrencyLimitingSemaphore);
        
        
        
        
        
        
        
        
        NSError *error;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration ];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url ];
        
        
        
        //GET=1,POST ,PUT,PATCH,DELETE
        
        if (way == GET){
            
            [request setHTTPMethod:@"GET"];
            
        }else if (way == POST){
            [request setHTTPMethod:@"POST"];
            
        }else if (way == PUT){
            [request setHTTPMethod:@"PUT"];
            
        }else if (way == PATCH){
            [request setHTTPMethod:@"PATCH"];
            
        }else if (way == DELETE){
            [request setHTTPMethod:@"DELETE"];
            
        }
        
        
        // add headers parameter
        if (Headers != nil ){
            
            for (NSString* key in Headers) {
              
                id value = [Headers objectForKey:key];
                [request addValue:value forHTTPHeaderField: key ];
                
            }
        }
        
        
        
        
        
        
        if (parameter != nil ){
            NSData *postData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:&error];
            
            
            NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:parameter
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
            [request setHTTPBody:dataFromDict];
        }
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            
            app.networkActivityIndicatorVisible = NO;
            
            
            if (error != nil) {
               
                [delegate performSelectorOnMainThread:selector withObject: error waitUntilDone:NO];
                
            }
            if (data != nil) {
            
                [delegate performSelectorOnMainThread:selector withObject:data waitUntilDone:NO];
            
            }
            
            
        }];
        
        [postDataTask resume];
        
        
    });
    
}



- (ConnectionType)CheckconnectionType
{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "8.8.8.8");
    SCNetworkReachabilityFlags flags;
    BOOL success = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    if (!success) {
        return ConnectionTypeUnknown;
    }
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL isNetworkReachable = (isReachable && !needsConnection);
    
    if (!isNetworkReachable) {
        return ConnectionTypeNone;
    } else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        return ConnectionType3G;
    } else {
        return ConnectionTypeWiFi;
    }
}


@end
