//
//  DataCenter.m
//  GapUtil
//
//  Created by gap on 2017/10/10.
//  Copyright © 2017年 gap. All rights reserved.
//

#import "DataCenter.h"
#import <AFNetworking.h>

@interface DataCenter ()

@end

@implementation DataCenter

+ (instancetype)shareInstance {
    static DataCenter *dataCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataCenter = [[DataCenter alloc] init];
    });
    return dataCenter;
}

- (id)init {
    if (self = [super init]) {
        self.sessionManage = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        self.sessionManage.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManage.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.sessionManage.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndex:400];

//        self.sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/form-data",@"application/json", nil];
        [self.sessionManage.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        
        
        


        self.sessionManage.requestSerializer.timeoutInterval = 30;
    }
    return self;
    
}


@end
