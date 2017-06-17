//
//  GetRemoteData.h
//  NetworkRequest
//
//  Created by Ragaie Alfy on 6/15/17.
//  Copyright © 2017 Ragaie Alfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
@interface GetRemoteData : NSObject





typedef enum{GET=1,POST ,PUT,PATCH,DELETE} HttpWay;


typedef enum {
    ConnectionTypeUnknown,
    ConnectionTypeNone,
    ConnectionType3G,
    ConnectionTypeWiFi
} ConnectionType;


-(void) RequestData : (NSDictionary *)Headers bodyParameter : (NSDictionary *) parameter urlString:(NSString *) urlString httpWay:(HttpWay *)  way responseDelegate:(id)delegate responseSelector:(SEL)selector ;






- (ConnectionType)CheckconnectionType;




@end
