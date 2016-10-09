//
//  LLDownLoadImage.m
//  仿好书 app
//
//  Created by JYD on 16/7/8.
//  Copyright © 2016年 JYD. All rights reserved.
//

#import "LLDownLoadImage.h"

#define adImageName @"adImageName"

#define kUserDefaults  [NSUserDefaults standardUserDefaults]
#import <UIKit/UIKit.h>

@implementation LLDownLoadImage


+(LLDownLoadImage *)share{
    
    static LLDownLoadImage * downLoadImage;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        downLoadImage = [[self alloc]init];
    });
    
    return downLoadImage;

}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory
            ];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage
{
    NSMutableURLRequest * request = [NSMutableURLRequest  requestWithURL:[NSURL URLWithString:@"http://news-at.zhihu.com/api/4/start-image/1080*1776"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    if (request == nil) {
        return;
    }
    [request setHTTPMethod:@"GET"];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            NSLog(@"%@",jsonDict);
            
            NSString *urlStringImage = [jsonDict objectForKey:@"img"];
            
            // 获取图片名:43-130P5122Z60-50.jpg
            NSArray *stringArr = [urlStringImage componentsSeparatedByString:@"/"];
            NSString *imageName = stringArr.lastObject;
            
            // 拼接沙盒路径
            NSString *filePath = [self getFilePathWithImageName:imageName];
            BOOL isExist = [self isFileExistWithFilePath:filePath];
            if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
                
                [self downloadAdImageWithUrl:urlStringImage imageName:imageName];
                
            }

        }
        
       
        
    }];
    
    [dataTask resume];
   }

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

-(BOOL) isFristStratApp {
    
    //判断app的版本号
    NSString * key = @"CFBundleShortVersionString";
    //获得当前软件的版本号
    NSString * curentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"%@",curentVersion);
    //获得沙盒中的版本号
    NSString * sanBoxVerison = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    NSLog(@"%@",sanBoxVerison);
    if (![curentVersion isEqualToString:sanBoxVerison]) {
        NSLog(@"我爱懒懒");
        //存储当前的版本号
        [[NSUserDefaults standardUserDefaults]setObject:curentVersion forKey:key];
        //立即进行存储
        [[NSUserDefaults standardUserDefaults]synchronize];
        //是第一次下载
        return YES;
    }else{
        //不是第一次下载
        return NO;
    
    
    }


}

@end
