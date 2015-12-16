//
//  FileUtils.m
//  mobileBank
//
//  Created by zhu zhanping on 11-11-02.
//  Copyright 2011__MyCompanyName__. All rights reserved.
//

#import "FileUtils.h"

static FileUtils *fileUtil = nil;
@implementation FileUtils

#pragma mark - sigleton
+(FileUtils*) sharedFileUtils {

    if (fileUtil == nil) {
        @synchronized(self) {
            if (fileUtil == nil) {
                fileUtil = [[self alloc] init];
            }
        }
    }
    return fileUtil;
}

+(id)allocWithZone:(NSZone *)zone {

    @synchronized(self) {
    
        if (fileUtil == nil) {
            fileUtil = [super allocWithZone:zone];
            return fileUtil;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

/*
-(void) release {

    //do noting
}
 */

#pragma mark -
#pragma mark file utils method

-(NSString *) getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

-(NSString*)getSandBoxFilePath :(NSString*)fileName {
    return [[self getDocumentPath] stringByAppendingPathComponent:fileName];
}

-(NSString*) getCachePath {
    return [NSString stringWithFormat:@"%@/Library/Caches/", NSHomeDirectory()];
}

-(NSString*) getCacheFilePath:(NSString*)fileName {
    NSString *absolutePath = [[self getCachePath] stringByAppendingPathComponent:fileName];
    return absolutePath;
}

-(NSString*) createCachePath:(NSString*)lastFolder {
    NSString *filePath = [[self getCachePath] stringByAppendingPathComponent:lastFolder];
    //判断本地缓存文件夹是否已创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}

-(NSString *)getAppFilePath:(NSString*)fileName suffix:(NSString*)suffix {
    return [[[self class] frameworkBundle] pathForResource:fileName ofType:suffix];
}


+ (NSBundle *)frameworkBundle {
    static NSBundle* frameworkBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"MXKitResources.bundle"];
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
    });
    return frameworkBundle;
}

-(NSString *)getBaseURL
{
    NSString *baseURL = nil;
    NSString *port = [fileUtil getUserDefaultsForKey:@"minxingPort"];
    if(port && port.length > 0 && port.intValue != 80 && port.intValue != 443)
    {
        baseURL = [NSString stringWithFormat:@"%@:%@", [fileUtil getUserDefaultsForKey:@"minxingURL"], [fileUtil getUserDefaultsForKey:@"minxingPort"]];
    }
    else
    {
        baseURL = [fileUtil getUserDefaultsForKey:@"minxingURL"];
    }
    return  baseURL;
}

-(NSString *)getHomeName
{
    NSString *hostName = nil;
    NSString *baseURL = [fileUtil getUserDefaultsForKey:@"minxingURL"];
    if(baseURL)
    {
        NSString *ignoreCaseString = [baseURL lowercaseString];
        hostName = [ignoreCaseString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
        hostName = [hostName stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    }
    return hostName;
}

-(NSString *)getMqttURL
{
    NSString *mqttURL = [fileUtil getUserDefaultsForKey:@"minxingMqttUrl"];
    mqttURL = [mqttURL stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    return mqttURL;
}

-(unsigned int)getMqttPort
{
    return [[fileUtil getUserDefaultsForKey:@"minxingMqttPort"] intValue];
}


//设置用户标准文件数据
-(void) setUserDefaults:(id) object key:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//获取用户标准文件数据
-(id)getUserDefaultsForKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//删除用户标准把文件数据
-(void)deleteDefalutsForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)cleanCurrentUserCache{
   // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
   // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        if ([key isKindOfClass:[NSString class]]) {
            if ([key hasPrefix:@"messages_"]) {
                [defs removeObjectForKey:key];
            }
        }
    }
    [defs synchronize];
}

//删除文件
-(void) deleteFile:(NSString*)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];
}

-(void) deleteFileAtPath:(NSString*)filePath {
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@" 删除文件失败 路径 %@,错误 %@", filePath,error);
    }
    
}

//删除文件夹
-(BOOL) deleteFloder:(NSString*)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
   BOOL result = [fileManager removeItemAtPath:path error:&error];
    if (!result) {
        NSLog(@"删除文件夹失败,%@",[error localizedDescription]);
    }
    return result;
}

//获取本地文件或文件夹路径
-(NSString*) getFilePath:(NSString*)lastFolder {
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:lastFolder];
    //判断本地缓存文件夹是否已创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}

//写入临时文件夹
-(NSString*) writeToTemp:(NSData*)data withSufix:(NSString*)sufix {
    NSDateFormatter *formmater = [[NSDateFormatter alloc] init];
    [formmater setDateFormat:@"yyyyMMddhhmmssSSS"];
    NSString *fileName = [NSString stringWithFormat:@"%@%@.%@",NSTemporaryDirectory(),[formmater stringFromDate:[NSDate date]],sufix];
    BOOL isSuccess = [data writeToFile:fileName atomically:YES];
    if (!isSuccess) {
        return nil;
    }
    return fileName;
}

-(NSString*) getTmpPath {
//    return NSTemporaryDirectory();
    return [NSString stringWithFormat:@"%@/tmp", [self getCachePath]];
}

//判断文件是否存在
-(BOOL) fileExist:(NSString*)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

//创建文件
-(void) createFile:(NSString*)filePath {
    if (![self fileExist:filePath]) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
}

-(NSString*)avarPath {
    NSDateFormatter *formmater = [[NSDateFormatter alloc] init];
    [formmater setDateFormat:@"yyyyMMddhhmmssSSS"];
    NSString *path = @"Library/Caches/IMAGE";
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.jpg",path,[formmater stringFromDate:[NSDate date]]];
    return fileName;
}

//+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath{
//    CGSize imageSize = image.size;
//    CGFloat width = imageSize.width;
//    CGFloat height = imageSize.height;
//    CGFloat scaleFactor = 0.0;
//    CGPoint thumbPoint = CGPointMake(0.0,0.0);
//    CGFloat widthFactor = thumbSize.width / width;
//    CGFloat heightFactor = thumbSize.height / height;
//    if (widthFactor > heightFactor)  {
//        scaleFactor = widthFactor;
//    }
//    else {
//        scaleFactor = heightFactor;
//    }
//    CGFloat scaledWidth  = width * scaleFactor;
//    CGFloat scaledHeight = height * scaleFactor;
//    if (widthFactor > heightFactor)
//    {
//        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
//    }
//    else if (widthFactor < heightFactor)
//    {
//        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
//    }
//    UIGraphicsBeginImageContext(thumbSize);
//    CGRect thumbRect = CGRectZero;
//    thumbRect.origin = thumbPoint;
//    thumbRect.size.width  = scaledWidth;
//    thumbRect.size.height = scaledHeight;
//    [image drawInRect:thumbRect];
//    
//    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
//    NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
////    NSData *thumbImageData = UIImagePNGRepresentation(thumbImage);
//    [thumbImageData writeToFile:thumbPath atomically:NO];
//    UIGraphicsEndImageContext();
//}
//
//+ (void)createEditThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath{
//    CGSize imageSize = image.size;
//    CGFloat width = imageSize.width;
//    CGFloat height = imageSize.height;
//    CGFloat scaleFactor = 0.0;
//    CGPoint thumbPoint = CGPointMake(0.0,0.0);
//    CGFloat widthFactor = thumbSize.width / width;
//    CGFloat heightFactor = thumbSize.height / height;
//    if (widthFactor > heightFactor)  {
//        scaleFactor = widthFactor;
//    }
//    else {
//        scaleFactor = heightFactor;
//    }
//    CGFloat scaledWidth  = width * scaleFactor;
//    CGFloat scaledHeight = height * scaleFactor;
//    if (widthFactor > heightFactor)
//    {
//        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
//    }
//    else if (widthFactor < heightFactor)
//    {
//        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
//    }
//    UIGraphicsBeginImageContext(thumbSize);
//    CGRect thumbRect = CGRectZero;
//    thumbRect.origin = thumbPoint;
//    thumbRect.size.width  = scaledWidth;
//    thumbRect.size.height = scaledHeight;
//    [image drawInRect:thumbRect];
//    
//    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
//    NSData *thumbImageData = UIImagePNGRepresentation(thumbImage);
//    [thumbImageData writeToFile:thumbPath atomically:NO];
//    UIGraphicsEndImageContext();
//}

@end
