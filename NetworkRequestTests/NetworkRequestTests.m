//
//  NetworkRequestTests.m
//  NetworkRequestTests
//
//  Created by Ragaie Alfy on 6/17/17.
//  Copyright © 2017 Ragaie Alfy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GetRemoteData.h"
#import "UIImageView+RenderImage.h"

@interface NetworkRequestTests : XCTestCase

@end

@implementation NetworkRequestTests
GetRemoteData *GetData;

- (void)setUp {
    [super setUp];
    
    GetData = [[GetRemoteData alloc]init];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testRenderImage {
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    [image setImageWithURL:@"https://avatars0.githubusercontent.com/u/19505162?v=3"];
    
}


- (void)testGetWithHeaderParameterRequest {
    
    NSMutableDictionary * tempParameter = [[NSMutableDictionary alloc] init];
    
    [tempParameter setValue:@"full_name" forKey:@"sort"];
    [tempParameter setValue:@"desc" forKey:@"direction"];
    
    [tempParameter setValue:@"owner" forKey:@"type"];
    
    [GetData RequestData:tempParameter bodyParameter:NULL urlString:@"https://api.github.com/users/ragaie/repos" httpWay: GET responseDelegate:GetData responseSelector: @selector(dataRecive:)];
    
    
}




- (void)testGetRequest {
    
    [GetData RequestData:NULL bodyParameter:NULL urlString:@"https://api.github.com/users/ragaie/repos" httpWay: GET responseDelegate:GetData responseSelector: @selector(dataRecive:)];
    
}
- (void)testPostRequest {
    
    NSMutableDictionary * tempParameter = [[NSMutableDictionary alloc] init];
    
    [tempParameter setValue:@"full_name" forKey:@"sort"];
    [tempParameter setValue:@"desc" forKey:@"direction"];
    
    [tempParameter setValue:@"owner" forKey:@"type"];
    
    
    NSMutableDictionary * tempPostHeader = [[NSMutableDictionary alloc] init];
    
    [tempPostHeader setValue:@"application/json" forKey:@"Content-Type"];
    
    
    [tempPostHeader setValue:@"application/json" forKey:@"Content-Type"];
    
    [GetData RequestData:tempPostHeader bodyParameter:tempParameter urlString:@"http://posttestserver.com/post.php?dump&html&dir=henry&status_code=202&sleep=2" httpWay: POST responseDelegate:GetData responseSelector: @selector(dataRecive:)];
    
}


- (void)testPUTRequest {
    
    NSMutableDictionary * tempParameter = [[NSMutableDictionary alloc] init];
    
    [tempParameter setValue:@"full_name" forKey:@"sort"];
    [tempParameter setValue:@"desc" forKey:@"direction"];
    
    [tempParameter setValue:@"owner" forKey:@"type"];
    
    
    NSMutableDictionary * tempPostHeader = [[NSMutableDictionary alloc] init];
    
    [tempPostHeader setValue:@"application/json" forKey:@"Content-Type"];
    
    // call get method with  && without ----> header parameter
    //
    
    [GetData RequestData:tempPostHeader bodyParameter:tempParameter urlString:@"http://posttestserver.com/post.php?dump&html&dir=henry&status_code=202&sleep=2" httpWay: PUT responseDelegate:GetData responseSelector: @selector(dataRecive:)];
    
}



- (void)testPatchRequest {
    
    NSMutableDictionary * tempParameter = [[NSMutableDictionary alloc] init];
    
    [tempParameter setValue:@"full_name" forKey:@"sort"];
    [tempParameter setValue:@"desc" forKey:@"direction"];
    
    [tempParameter setValue:@"owner" forKey:@"type"];
    
    
    NSMutableDictionary * tempPostHeader = [[NSMutableDictionary alloc] init];
    
    [tempPostHeader setValue:@"application/json" forKey:@"Content-Type"];
    
    // call get method with  && without ----> header parameter
    //
    
    [GetData RequestData:tempPostHeader bodyParameter:tempParameter urlString:@"http://posttestserver.com/post.php?dump&html&dir=henry&status_code=202&sleep=2" httpWay: PATCH responseDelegate:GetData responseSelector: @selector(dataRecive:)];
    
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
