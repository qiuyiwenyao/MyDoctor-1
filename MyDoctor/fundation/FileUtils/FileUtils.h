//
//  FileUtils.h
//  mobileBank
//  文件操作工具类
//  Created by zhu zhanping on 11-11-02.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

+(FileUtils*) sharedFileUtils;

#pragma mark -
#pragma mark 沙盒文件操作
//获取document路径
-(NSString *) getDocumentPath;

//获取沙盒中文件路径
-(NSString*)getSandBoxFilePath :(NSString*)fileName;

#pragma mark -
#pragma mark APP应用中文件操作
//获取APP中文件路径
-(NSString *)getAppFilePath:(NSString*)fileName suffix:(NSString*)suffix;

//设置用户标准文件数据
-(void) setUserDefaults:(id) object key:(NSString*)key;

//获取用户标准文件数据
-(id)getUserDefaultsForKey:(NSString*)key;

//删除用户标准把文件数据
-(void)deleteDefalutsForKey:(NSString *)key;

//删除文件
-(void) deleteFile:(NSString*)fileName;

//删除文件
-(void) deleteFileAtPath:(NSString*)filePath;

//删除文件夹
-(BOOL) deleteFloder:(NSString*)path;

//获取本地文件路径
-(NSString*) getFilePath:(NSString*)lastFolder;

//写入临时文件夹
-(NSString*) writeToTemp:(NSData*)data withSufix:(NSString*)sufix;

//判断文件是否存在
-(BOOL) fileExist:(NSString*)filePath;

//创建文件
-(void) createFile:(NSString*)filePath;

//获取临时文件夹
-(NSString*) getTmpPath;
//清除的当前用户的所有离线数据 比如登录信息 本地缓存的 圈的数据
-(void)cleanCurrentUserCache;

+ (NSBundle *)frameworkBundle;

#pragma mark -
#pragma mark 缓存文件操作
-(NSString*) getCachePath;

-(NSString*) getCacheFilePath:(NSString*)fileName;

-(NSString*) createCachePath:(NSString*)lastFolder;

//头像路径
-(NSString*) avarPath;

-(NSString *)getBaseURL;
-(NSString *)getMqttURL;
-(unsigned int)getMqttPort;
-(NSString *)getHomeName;


/**
 *  创建图片缩略图
 *
 *  @param image     原始图片
 *  @param thumbSize 图片压缩后尺寸
 *  @param percent   压缩率0-1(0最大，１最小)
 *  @param thumbPath 图片压缩后保存路径
 */
//+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath;
//
//+ (void)createEditThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath;

@end
