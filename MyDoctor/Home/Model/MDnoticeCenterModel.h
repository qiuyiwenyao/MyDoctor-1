//
//  MDnoticeCenterModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/16.
//  Copyr/Users/WuJun/Desktop/NewDoctorSystem/MyDoctor/fundation/Chat/ChatView/MessageView/ChatCell/ChatCellBubble/EMChatLocationBubbleView.might © 2015年 com.mingxing. All rights reserved.
//
/*   "Content": "为了让广大居民度过一个健康祥和的冬季，居委会特邀社区医院的医护人员来我社区为广大居民进行一次全面的免费普查活动",
 "UserID": 1,
 "Title": "关于社区医院冬季体检的通知",
 "SendFlag": 0,
 "ID": 1,
 "CensusTime": "2016年2月14日 上午8：45开始",
 "HostUnit": "建昌道街居委会",
 "PicUrl": "123",
 "AddTime": "2015-12-09 20:57:23",
 "Detail": "尊敬的社区居民\r\n       随着冬季的到来，天气寒冷，气候干燥，很容易引发或传染各种疾病 如：鼻、咽喉、气管、支气管炎，急性或复发性哮喘等病，心脑血管疾病、肠胃疾病和意外损伤也时常出现。支气管炎以长期咳嗽、咳痰或伴有喘息为特征， 还应注意预防伤风感冒、注意扁桃腺炎、腹泻等疾病。冬季天气寒冷还容易引发哮喘病，尤其是体弱或过敏性疾病的人，对温度变化敏感，适应能力较弱，极易因上呼吸道感染而诱发。冬季稍不注意就会引发其它疾病。\r\n      为了让广大居民度过一个健康祥和的冬季，建昌道街居委会特邀天津红十字医院的医护人员来我社区为广大居民进行一次全面的免费普查活动。\r\n",
 "CensusAddress": "建昌道街居委会",
 "NoticeTime": "2015-12-09 20:57:19"*/

#import <Foundation/Foundation.h>

@interface MDnoticeCenterModel : NSObject

@property (nonatomic,assign) int UserID;
@property (nonatomic,strong) NSString * Content;
@property (nonatomic,strong) NSString * Title;
@property (nonatomic,assign) int SendFlag;
@property (nonatomic,assign) int ID;
@property (nonatomic,strong) NSString * AddTime;
@property (nonatomic,strong) NSString * NoticeTime;
@property (nonatomic,strong) NSString * PicUrl;
@property (nonatomic,strong) NSString * CensusTime;
@property (nonatomic,strong) NSString * HostUnit;
@property (nonatomic,strong) NSString * Detail;
@property (nonatomic,strong) NSString * CensusAddress;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
