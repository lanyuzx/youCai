//
//  LLCacheInterface.h
//  数组转为NSDate
//
//  Created by JYD on 16/9/18.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLCacheInterface : NSObject

///写入本地缓存 jsonDict为接口请求的数据
+(void)cacheInterface:(id)jsonDict  :(NSString *)cacheName ;


+(id)loadCache  :(NSString *)cacheName ;
@end
