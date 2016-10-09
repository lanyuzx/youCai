//
//  LLDownLoadImage.h
//  仿好书 app
//
//  Created by JYD on 16/7/8.
//  Copyright © 2016年 JYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLDownLoadImage : NSObject


+(LLDownLoadImage *) share;
/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath;

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage;

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName;

/**
 *  删除旧图片
 */
- (void)deleteOldImage;

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName;
/**
 *  判断是否是第一次安装 app
 *
 *  @return yes no
 */
-(BOOL) isFristStratApp;

@end
