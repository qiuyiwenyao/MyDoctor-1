//
//  ViewController.m
//  ChatMessageTableViewController
//
//  Created by Yongchao on 21/11/13.
//  Copyright (c) 2013 Yongchao. All rights reserved.
//

#import "MDChatViewController.h"
#import "EaseMob.h"



@interface MDChatViewController () <JSMessagesViewDelegate, JSMessagesViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,EMChatManagerChatDelegate,IChatManagerDelegate,EMCallManagerDelegate,EMChatManagerDelegate>

@property (strong, nonatomic) NSMutableArray *messageArray;
@property (nonatomic,strong) UIImage *willSendImage;
@property (strong, nonatomic) NSMutableArray *timestamps;

@end

@implementation MDChatViewController
{
    int sendOrput;
    NSMutableArray * tapyArray;
}
@synthesize messageArray;


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    sendOrput=0;
    self.title = @"聊天";
    tapyArray=[[NSMutableArray alloc] init];
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"13662142222" conversationType:eConversationTypeChat];
    conversation.enableReceiveMessage=YES;
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    //注册为SDK的ChatManager的delegate
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];

    
    self.messageArray = [NSMutableArray array];
    self.timestamps = [NSMutableArray array];
//    [self addtext];
}

-(void)dealloc
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].callManager removeDelegate:self];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

#pragma mark - Messages view delegate
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    if (sender==nil) {
        sendOrput=0;
    }else{
        sendOrput=1;
        
        EMChatText *txtChat = [[EMChatText alloc] initWithText:text];
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
        // 生成message
        EMMessage *message = [[EMMessage alloc] initWithReceiver:@"13662142222" bodies:@[body]];
        message.messageType = eMessageTypeChat;
        EMError *error = nil;
        id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
        //    [chatManager asyncResendMessage:message progress:nil];
        [chatManager sendMessage:message progress:nil error:&error];
        if (error) {
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"error" message:@"发送失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [a show];
        }else {
        }
    }
    [tapyArray addObject:[NSString stringWithFormat:@"%d",sendOrput]];
    
   
    sendOrput=0;
    
    [self.messageArray addObject:[NSDictionary dictionaryWithObject:text forKey:@"Text"]];
    
    [self.timestamps addObject:[NSDate date]];
    
    if((self.messageArray.count - 1) % 2)
        [JSMessageSoundEffect playMessageSentSound];
    else
        [JSMessageSoundEffect playMessageReceivedSound];
    
    [self finishSend];
}

- (void)cameraPressed:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tapyArray[indexPath.row] intValue];
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JSBubbleMessageStyleFlat;
}

- (JSBubbleMediaType)messageMediaTypeForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"Text"]){
        return JSBubbleMediaTypeText;
    }else if ([[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"Image"]){
        return JSBubbleMediaTypeImage;
    }
    
    return -1;
}

- (UIButton *)sendButton
{
    return [UIButton defaultSendButton];
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    /*
     JSMessagesViewTimestampPolicyAll = 0,
     JSMessagesViewTimestampPolicyAlternating,
     JSMessagesViewTimestampPolicyEveryThree,
     JSMessagesViewTimestampPolicyEveryFive,
     JSMessagesViewTimestampPolicyCustom
     */
    return JSMessagesViewTimestampPolicyEveryThree;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    /*
     JSMessagesViewAvatarPolicyIncomingOnly = 0,
     JSMessagesViewAvatarPolicyBoth,
     JSMessagesViewAvatarPolicyNone
     */
    return JSMessagesViewAvatarPolicyBoth;
}

- (JSAvatarStyle)avatarStyle
{
    /*
     JSAvatarStyleCircle = 0,
     JSAvatarStyleSquare,
     JSAvatarStyleNone
     */
    return JSAvatarStyleCircle;
}

- (JSInputBarStyle)inputBarStyle
{
    /*
     JSInputBarStyleDefault,
     JSInputBarStyleFlat
     
     */
    return JSInputBarStyleFlat;
}

//  Optional delegate method
//  Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  - (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
//

#pragma mark - Messages view data source
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"Text"]){
        return [[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"Text"];
    }
    return nil;
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.timestamps objectAtIndex:indexPath.row];
}

- (UIImage *)avatarImageForIncomingMessage
{
    return [UIImage imageNamed:@"demo-avatar-jobs"];
}

- (UIImage *)avatarImageForOutgoingMessage
{
    return [UIImage imageNamed:@"demo-avatar-woz"];
}

- (id)dataForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"Image"]){
        return [[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"Image"];
    }
    return nil;
    
}

#pragma UIImagePicker Delegate

#pragma mark - Image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Chose image!  Details:  %@", info);
    
    self.willSendImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (picker) {
        sendOrput=1;
        NSLog(@"%@",self.willSendImage);
        EMChatImage *imgChat = [[EMChatImage alloc] initWithUIImage:self.willSendImage displayName:@"displayName"];
        EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithChatObject:imgChat];
        // 生成message
        
        EMMessage *message = [[EMMessage alloc] initWithReceiver:@"18234087856" bodies:@[body]];
        message.messageType = eMessageTypeChat;
        EMError *error = nil;
        id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
        [chatManager sendMessage:message progress:nil error:&error];
        if (error) {
            UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"error" message:@"发送失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [a show];
        }else {
        }
    }else{
        sendOrput=0;
        
    }
    [tapyArray addObject:[NSString stringWithFormat:@"%d",sendOrput]];
    sendOrput=0;
    
    
    
    [self.messageArray addObject:[NSDictionary dictionaryWithObject:self.willSendImage forKey:@"Image"]];
    [self.timestamps addObject:[NSDate date]];
    [self.tableView reloadData];
    [self scrollToBottomAnimated:YES];
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


-(void)didReceiveMessage:(EMMessage *)message
{
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            sendOrput=1;
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            NSLog(@"收到的文字是 txt -- %@",txt);
            [self  sendPressed:nil withText:txt];
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
            NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"大图的secret -- %@"    ,body.secretKey);
            NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
            NSLog(@"大图的下载状态 -- %lu",body.attachmentDownloadStatus);
            
            
            // 缩略图sdk会自动下载
            NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
            NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
            NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
            NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
            NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
            
            
            id <IChatManager> chatManager = [[EaseMob sharedInstance] chatManager];
            //获取缩略图
            [chatManager asyncFetchMessageThumbnail:message progress:nil completion:^(EMMessage *aMessage, EMError *error) {
                if (!error) {
                    id<IEMMessageBody> msgBody = aMessage.messageBodies.firstObject;
                    EMImageMessageBody *body1 = ((EMImageMessageBody *)msgBody);
                    
                    
                    //                    UIImageView * imageV = [[UIImageView alloc] init];
                    //                    [imageV sd_setImageWithURL:[NSURL URLWithString:body1.thumbnailRemotePath]];
                    //                    [imageV sd_setImageWithURL:[NSURL URLWithString:@"/Users/WuJun/Library/Developer/CoreSimulator/Devices/57BBA3B7-984B-4421-8A28-1C98C0206CBD/data/Containers/Data/Application/273F97E8-22BC-4529-BB51-69FDF1249326/Library/appdata/18234087856/chat/13662142222/messages/thumb_43833480-a953-11e5-81af-217f4f418613"] placeholderImage:[UIImage imageNamed:@"葵花胃康灵.png"]];
                    NSLog(@"%@",body1.thumbnailLocalPath);
                    NSString *homeDirectory = NSHomeDirectory();
                    NSLog(@"path:%@", homeDirectory);
                    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:body1.thumbnailLocalPath];//[NSString stringWithFormat:@"%@/Library/appdata/18234087856/chat/13662142222/messages/thumb_759ea8a0-a953-11e5-ace3-e70dc9229b06",homeDirectory]];
                    
                    
                    NSLog(@"%@",imgFromUrl3);
                    
                    [tapyArray addObject:@"0"];
                    [self.messageArray addObject:[NSDictionary dictionaryWithObject:imgFromUrl3 forKey:@"Image"]];
                    [self.timestamps addObject:[NSDate date]];
                    [self.tableView reloadData];
                    [self scrollToBottomAnimated:YES];
                    
                    [self dismissViewControllerAnimated:YES completion:NULL];
                    
                }else{
                    //                    [weakSelf showHint:NSLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
                }
                
            } onQueue:nil];
            
        }
            break;
        case eMessageBodyType_Location:
        {
            EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
            NSLog(@"纬度-- %f",body.latitude);
            NSLog(@"经度-- %f",body.longitude);
            NSLog(@"地址-- %@",body.address);
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频sdk会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
            NSLog(@"音频的secret -- %@"        ,body.secretKey);
            NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"音频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
        }
            break;
        case eMessageBodyType_Video:
        {
            EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
            
            NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"视频的secret -- %@"        ,body.secretKey);
            NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"视频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
            NSLog(@"视频的W -- %f ,视频的H -- %f", body.size.width, body.size.height);
            
            // 缩略图sdk会自动下载
            NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
            NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailRemotePath);
            NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
            NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
        }
            break;
        case eMessageBodyType_File:
        {
            EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
            NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
            NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"文件的secret -- %@"        ,body.secretKey);
            NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"文件文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
        }
            break;
            
        default:
            break;
    }
}
-(void) addtext{
    //1.
    EMConversation *conversation2 =  [[EaseMob sharedInstance].chatManager conversationForChatter:@"18234087856" conversationType:0] ;
    NSString * context = @"";//用于制作对话框中的内容.(现在还没有分自己发送的还是别人发送的.)
    NSArray * arrcon;
    NSArray * arr;
    long long timestamp = [[NSDate date] timeIntervalSince1970] * 1000 + 1;//制作时间戳
    arr = [conversation2 loadAllMessages]; // 获得内存中所有的会话.
    arrcon = [conversation2 loadNumbersOfMessages:10 before:timestamp]; //根据时间获得5调会话. (时间戳作用:获得timestamp这个时间以前的所有/5会话)
    // 2.
    for (EMMessage * hehe in arrcon) {
        id<IEMMessageBody> messageBody = [hehe.messageBodies firstObject];
        NSString *messageStr = nil;
        //3.
        messageStr = ((EMTextMessageBody *)messageBody).text;
        //        [context stringByAppendingFormat:@"%@",messageStr ];
        
        if (![hehe.from isEqualToString:@"18234087856"]) {//如果是自己发送的.
            context = [NSString stringWithFormat:@"%@\n\t\t\t\t\t我说:%@",context,messageStr];
             sendOrput=1;
            NSLog(@"%@",context);
        }else{
            context = [NSString stringWithFormat:@"%@\n%@",context,messageStr];
            sendOrput=0;
        }
        
    }
    [tapyArray addObject:[NSString stringWithFormat:@"%d",sendOrput]];
    UIButton * button=[[UIButton alloc] init];
            [self sendPressed:button withText:context];
    
    sendOrput=0;
}


@end
