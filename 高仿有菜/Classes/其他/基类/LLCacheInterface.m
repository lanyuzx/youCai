//
//  LLCacheInterface.m
//  数组转为NSDate
//
//  Created by JYD on 16/9/18.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import "LLCacheInterface.h"

@implementation LLCacheInterface

+(void)cacheInterface:(id)jsonDict  :(NSString *)cacheName {
    
    //缓存数据
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [paths objectAtIndex:0];
    documentsPath = [documentsPath stringByAppendingPathComponent:cacheName];
    
    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if ([data length] > 0 && error == nil){
        
        BOOL yes =    [data writeToFile:documentsPath atomically:true];
        
        if (yes) {
            NSLog(@"写入成功");
        }
        
    }
    
}

+(id)loadCache  :(NSString *)cacheName {
    
    //缓存数据
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [paths objectAtIndex:0];
    documentsPath = [documentsPath stringByAppendingPathComponent:cacheName];
    NSData * cacheData = [NSData dataWithContentsOfFile:documentsPath];
    
    id  cache = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingAllowFragments error:nil];
    
    return cache;
    
}

@end
