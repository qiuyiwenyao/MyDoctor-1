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
    userVO.userName=[[dic objectForKey:@"obj"] objectForKey:@"userName"];
    userVO.userID=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"obj"] objectForKey:@"id"]];
    userVO.account=[[dic objectForKey:@"obj"] objectForKey:@"account"];
    return userVO;
}

+(MDUserVO*) registeredFromDignInUser:(NSDictionary *)dic{
    MDUserVO * userVO=[[MDUserVO alloc] init];
    userVO.userName=[dic objectForKey:@"user_Name"];
    userVO.userID=[dic objectForKey:@"msg"];
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
    [aCoder encodeObject:_account forKey:@"userName"];
   
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    MDUserVO *user = [[MDUserVO alloc] init];
    user.userID = [aDecoder decodeObjectForKey:@"id"];
    user.userName = [aDecoder decodeObjectForKey:@"userName"];
    user.account = [aDecoder decodeObjectForKey:@"userName"];
    
    return user;
}
@end
