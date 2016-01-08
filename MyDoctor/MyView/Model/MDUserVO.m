//
//  MDUserVO.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/12/16.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDUserVO.h"
#import "FileUtils.h"

static MDUserVO *user = nil;
@implementation MDUserVO

+(MDUserVO*)userVO
{
    if (!user) {
        FileUtils *util = [FileUtils sharedFileUtils];
        NSData *data = [util getUserDefaultsForKey:@"loginUser"];
        user = (MDUserVO *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return user;
}

-(void)clearUserVO
{
    if(user)
    {
        FileUtils *util = [FileUtils sharedFileUtils];
        [util deleteDefalutsForKey:@"loginUser"];
    }
}

+(MDUserVO*) convertFromAccountHomeUser:(NSDictionary *)dic{
    MDUserVO * userVO=[[MDUserVO alloc] init];
    userVO.userName=[[dic objectForKey:@"obj"] objectForKey:@"realName"];
    userVO.userID=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"obj"] objectForKey:@"id"]];
//    userVO.account=[[dic objectForKey:@"obj"] objectForKey:@"account"];
    userVO.photo = [[dic objectForKey:@"obj"] objectForKey:@"photo"];
    userVO.baseurl = [[dic objectForKey:@"obj"] objectForKey:@"shoujiPara"][0][1];
    userVO.photourl = [[dic objectForKey:@"obj"] objectForKey:@"shoujiPara"][1][1];
    userVO.photoPath = [NSString stringWithFormat:@"Library/Caches/IMAGE/%@.png",[[dic objectForKey:@"obj"] objectForKey:@"id"]];
    
    return userVO;
}

// @{@"userId":[dic objectForKey:@"msg"],@"userName":number.text,@"userAccount":self.login_name};
+(MDUserVO*) registeredFromDignInUser:(NSDictionary *)dic{
    MDUserVO * userVO=[[MDUserVO alloc] init];
    userVO.userName=[dic objectForKey:@"userName"];
    userVO.userID=[dic objectForKey:@"userId"];
    userVO.account = [dic objectForKey:@"userAccount"];
    userVO.photoPath = [NSString stringWithFormat:@"Library/Caches/IMAGE/%@.png",[dic objectForKey:@"userId"] ];
    userVO.photourl = @"http://111.160.245.75:8082/CommunityWs/Upload/photos/";
    
    return userVO;
}

+(MDUserVO*) setPersonInfoFromUserInfer:(NSDictionary *)dic
{
    MDUserVO * userVO=[[MDUserVO alloc] init];
    userVO.userName = [dic objectForKey:@"userName"];
    userVO.account = [dic objectForKey:@"userAccount"];
    userVO.photoPath = [NSString stringWithFormat:@"Library/Caches/IMAGE/%@.png",[dic objectForKey:@"userId"] ];
    return userVO;
}

+(void)initWithCoder:(MDUserVO *)userVO
{
    user=userVO;

    FileUtils *util = [FileUtils sharedFileUtils];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [util setUserDefaults:data key:@"loginUser"];
    NSData *tmpData = [util getUserDefaultsForKey:@"loginUser"];
    MDUserVO *tmpUser = [NSKeyedUnarchiver unarchiveObjectWithData:tmpData];
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userID forKey:@"id"];
    [aCoder encodeObject:_userName forKey:@"userName"];
//    [aCoder encodeObject:_account forKey:@"userName"];
    [aCoder encodeObject:_photoPath forKey:@"photoPath"];
    [aCoder encodeObject:_photourl forKey:@"photourl"];
   
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    MDUserVO *user = [[MDUserVO alloc] init];
    user.userID = [aDecoder decodeObjectForKey:@"id"];
    user.userName = [aDecoder decodeObjectForKey:@"userName"];
//    user.account = [aDecoder decodeObjectForKey:@"userName"];
    user.photoPath = [aDecoder decodeObjectForKey:@"photoPath"];
    user.photourl = [aDecoder decodeObjectForKey:@"photourl"];
    
    return user;
}
@end
