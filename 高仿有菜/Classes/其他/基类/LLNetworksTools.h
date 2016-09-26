//
//  LLNetworksTools.h
//  高仿有菜
//
//  Created by JYD on 16/9/23.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
/*! 定义请求成功的block */
typedef void( ^ ResponseSuccess)(id response);
/*! 定义请求失败的block */
typedef void( ^ ResponseFail)(NSError *error);
/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, httpRequestType)
{
    
    requestTypeGet = 0,
    requestTypePost
    
};
/*! 定义请求成功的block */
typedef void( ^ ResponseSuccess)(id response);
/*! 定义请求失败的block */
typedef void( ^ ResponseFail)(NSError *error);
@interface LLNetworksTools : AFHTTPSessionManager
//单例
+(instancetype)sharedTools;

+ (NSURLSessionTask *)requestWithType:(httpRequestType)type withUrlString:(NSString *)urlString withParameters:(NSDictionary *)parameters withSuccessBlock:(ResponseSuccess)successBlock withFailureBlock:(ResponseFail)failureBlock ;

-(UIColor *) colorWithHexString: (NSString *)color andAlpha:(CGFloat )setAlpha;
@end
