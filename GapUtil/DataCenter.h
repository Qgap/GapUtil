//
//  DataCenter.h
//  GapUtil
//
//  Created by gap on 2017/10/10.
//  Copyright © 2017年 gap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Header.h"

@interface DataCenter : NSObject

@property (nonatomic,strong) AFHTTPSessionManager *sessionManage;

+ (instancetype)shareInstance;

@end
