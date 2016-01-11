/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "ChatListViewController.h"
#import "SRRefreshView.h"
#import "ChatListCell.h"
#import "EMSearchBar.h"
#import "NSDate+Category.h"
//#import "RealtimeSearchUtil.h"
#import "ChatViewController.h"
#import "EMSearchDisplayController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "RobotManager.h"
#import "UserProfileManager.h"
#import "RobotChatViewController.h"
#import "EaseMob.h"
#import "MDConst.h"
#import "MDUserVO.h"
#import "UIImageView+WebCache.h"
#import "FileUtils.h"
#import "DocPatientSQL.h"
#import "DocPatientModel.h"
#define IMAGECACHE  @"PatientsIMAGE/"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#import "UIViewController+HUD.h"
@implementation EMConversation (search)


//根据用户昵称,环信机器人名称,群名称进行搜索
- (NSString*)showName
{
    if (self.conversationType == eConversationTypeChat) {
        if ([[RobotManager sharedInstance] isRobotWithUsername:self.chatter]) {
            return [[RobotManager sharedInstance] getRobotNickWithUsername:self.chatter];
        }
        return [[UserProfileManager sharedInstance] getNickNameWithUsername:self.chatter];
    } else if (self.conversationType == eConversationTypeGroupChat) {
        if ([self.ext objectForKey:@"groupSubject"] || [self.ext objectForKey:@"isPublic"]) {
            return [self.ext objectForKey:@"groupSubject"];
        }
    }
    return self.chatter;
}

@end

@interface ChatListViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate,SRRefreshDelegate, UISearchBarDelegate, IChatManagerDelegate,ChatViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray        *dataSource;

@property (nonatomic, strong) EMSearchBar           *searchBar;
@property (nonatomic, strong) SRRefreshView         *slimeView;
@property (nonatomic, strong) UIView                *networkStateView;

@property (strong, nonatomic) EMSearchDisplayController *searchController;

@end

@implementation ChatListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    _RealName = [[NSMutableArray alloc] init];
    _headImg = [[NSMutableArray alloc] init];
    _headImgUrl = [[NSMutableArray alloc] init];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    
    imgView.frame = self.view.bounds;
    
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view insertSubview:imgView atIndex:0];
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    [self removeEmptyConversationsFromDB];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.slimeView];
    [self networkStateView];
    
    [self searchController];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//根据手机号获得头像和昵称
-(void)getNickNameAndPhotoWithChatID:(NSString *)chatId
{
    //    MDRequestModel * model = [[MDRequestModel alloc] init];
    //    model.path = MDPath;
    //    model.methodNum = 10102;
    //    NSString * parameter=[NSString stringWithFormat:@"%@@`%@",logInField.text,password.text];
    //    model.parameter = parameter;
    //    model.delegate = self;
    //    [model starRequest];
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10109;
    //    NSLog(@"===%@",_chatID);
    NSString * parameter = chatId;
    model.delegate = self;
    model.parameter = parameter;
    [model starRequest];
    
}


#pragma mark - sen
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    
    NSLog(@"~~~~~~~~%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSArray * arr = [dic objectForKey:@"obj"];
    
    NSMutableArray * attachmentArr = [[NSMutableArray alloc] init];
    DocPatientSQL * docPation = [[DocPatientSQL alloc] init];
    [docPation createAttachmentsDBTableWithPatient];
    
    for (NSDictionary * dic in arr) {
        
        //创建数据库
        
        DocPatientModel * patientModel = [[DocPatientModel alloc] init];
        patientModel.Name = [dic objectForKey:@"RealName"];
        _name=[dic objectForKey:@"RealName"];
        if (![dic objectForKey:@"RealName"]) {
            patientModel.Name = [dic objectForKey:@"Phone"];
            _name=[dic objectForKey:@"Phone"];
        }
        patientModel.phone = [dic objectForKey:@"Phone"];
        if ([dic objectForKey:@"Photo"]) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,[dic objectForKey:@"Photo"]]]];
                UIImage *headImg = [[UIImage alloc]initWithData:data];
                if (data != nil) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
                        //在这里做UI操作(UI操作都要放在主线程中执行)
                        FileUtils * fileUtil = [FileUtils sharedFileUtils];
                        //创建文件下载目录
                        NSString * path2 = [fileUtil createCachePath:IMAGECACHE];
                        
                        NSString *uniquePath=[path2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[dic objectForKey:@"Phone"]]];
                        BOOL result=[UIImagePNGRepresentation(headImg)writeToFile: uniquePath atomically:YES];
                        
                        if(result)
                        {
                            patientModel.ImagePath = [NSString stringWithFormat:@"/Library/Caches/PatientsIMAGE/%@.png",[dic objectForKey:@"Phone"]];
                            NSLog(@"%@",patientModel.ImagePath);
                            
                            [attachmentArr addObject:patientModel];
                            [docPation updatePopAttachmentsDBTable:attachmentArr];
                            [_tableView reloadData];
                        }
                        
                        
//                    });
                }
//            });
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    //
    //    NSLog(@"+++++%@%@",nickName,headImg);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_chatID) {
        EMConversation *conversation =  [[EaseMob sharedInstance].chatManager conversationForChatter:_chatID conversationType:0] ;
        NSString *chatter = conversation.chatter;
        ChatViewController * chatController = [[ChatViewController alloc] initWithChatter:chatter
                                                                         conversationType:conversation.conversationType];
        chatController.title = _name;
        chatController.chatID=_chatID;
        chatController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:NO];
    }
    
    [self refreshDataSource];
    [self registerNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

- (void)removeChatroomConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (conversation.conversationType == eConversationTypeChatRoom) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

#pragma mark - getter

- (SRRefreshView *)slimeView
{
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor whiteColor];
    }
    
    return _slimeView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
    }
    
    return _searchBar;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChatListCell class] forCellReuseIdentifier:@"chatListCell"];
    }
    
    return _tableView;
}

- (EMSearchDisplayController *)searchController
{
    if (_searchController == nil) {
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchController.delegate = self;
        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        __weak ChatListViewController *weakSelf = self;
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *CellIdentifier = @"ChatListCell";
            ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (cell == nil) {
                cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            cell.name = conversation.chatter;
            cell.backgroundColor = [UIColor clearColor];
            if (conversation.conversationType == eConversationTypeChat) {
                cell.name = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.chatter];
                cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
            }
            else{
                NSString *imageName = @"groupPublicHeader";
                NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:conversation.chatter]) {
                        cell.name = group.groupSubject;
                        imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                        break;
                    }
                }
                cell.placeholderImage = [UIImage imageNamed:imageName];
            }
            cell.detailMsg = [weakSelf subTitleMessageByConversation:conversation];
            cell.time = [weakSelf lastMessageTimeByConversation:conversation];
            cell.unreadCount = [weakSelf unreadMessageCountByConversation:conversation];
            if (indexPath.row % 2 == 1) {
                cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
            }else{
                cell.contentView.backgroundColor = [UIColor whiteColor];
            }
            return cell;
        }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
        }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [weakSelf.searchController.searchBar endEditing:YES];
            
            EMConversation *conversation = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
            ChatViewController *chatController;
            if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.chatter]) {
                chatController = [[RobotChatViewController alloc] initWithChatter:conversation.chatter
                                                                 conversationType:conversation.conversationType];
                
                chatController.title = _name;
            }else {
                chatController = [[ChatViewController alloc] initWithChatter:conversation.chatter
                                                            conversationType:conversation.conversationType];
                chatController.title = _name;
            }
            [weakSelf.navigationController pushViewController:chatController animated:YES];
        }];
    }
    
    return _searchController;
}

- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    
    NSArray* sorte = [conversations sortedArrayUsingComparator:
                      ^(EMConversation *obj1, EMConversation* obj2){
                          EMMessage *message1 = [obj1 latestMessage];
                          EMMessage *message2 = [obj2 latestMessage];
                          if(message1.timestamp > message2.timestamp) {
                              return(NSComparisonResult)NSOrderedAscending;
                          }else {
                              return(NSComparisonResult)NSOrderedDescending;
                          }
                      }];
    
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                if ([[RobotManager sharedInstance] isRobotMenuMessage:lastMessage]) {
                    ret = [[RobotManager sharedInstance] getRobotMenuMessageDigest:lastMessage];
                } else {
                    ret = didReceiveText;
                }
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

#pragma mark - TableViewDelegate & TableViewDatasource

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DocPatientSQL * patient = [[DocPatientSQL alloc] init];
    [patient createAttachmentsDBTableWithPatient];
    
    
    static NSString *identify = @"chatListCell";
    ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
    cell.name = conversation.chatter;
    
    
    //取出conversation.chatter对应的数据库
    
    NSLog(@"++%@",conversation.chatter);
    
    NSArray * array=[patient getAttachmentswithMailPhone:conversation.chatter];
    NSLog(@"%@",array);
    
    DocPatientModel * patienModel;
    if ([array count]>0) {
        patienModel= array[0];
    }else{
        patienModel = nil;
    }
    if (conversation.conversationType == eConversationTypeChat) {
        
        cell.name = patienModel.Name;
        
        UIImage * headImg = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",NSHomeDirectory(),patienModel.ImagePath]];
        
        NSLog(@"!!!%@%@",NSHomeDirectory(),patienModel.ImagePath);
        
        
        if (headImg) {
            cell.placeholderImage = headImg;
            
        }
        else
        {
            cell.placeholderImage = [UIImage imageNamed:@"chatListCellHead.png"];
        }
        
        
        
        //
        //        }
    }
    else{
        NSString *imageName = @"groupPublicHeader";
        if (![conversation.ext objectForKey:@"groupSubject"] || ![conversation.ext objectForKey:@"isPublic"])
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    cell.name = group.groupSubject;
                    imageName = group.isPublic ? @"groupPublicHeader" : @"groupPrivateHeader";
                    
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupSubject forKey:@"groupSubject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        else
        {
            cell.name = [conversation.ext objectForKey:@"groupSubject"];
            imageName = [[conversation.ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
        }
        cell.placeholderImage = [UIImage imageNamed:imageName];
    }
    cell.detailMsg = [self subTitleMessageByConversation:conversation];
    cell.time = [self lastMessageTimeByConversation:conversation];
    cell.unreadCount = [self unreadMessageCountByConversation:conversation];
    //    if (indexPath.row % 2 == 1) {
    //        cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
    //    }else{
    //        cell.contentView.backgroundColor = [UIColor whiteColor];
    //    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ChatListCell tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
    
    ChatViewController *chatController;
    NSString *title = conversation.chatter;
    if (conversation.conversationType != eConversationTypeChat) {
        if ([[conversation.ext objectForKey:@"groupSubject"] length])
        {
            title = [conversation.ext objectForKey:@"groupSubject"];
        }
        else
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    title = group.groupSubject;
                    break;
                }
            }
        }
    } else if (conversation.conversationType == eConversationTypeChat) {
        //        title = _RealName[indexPath.row];
    }
    
    NSString *chatter = conversation.chatter;
    if ([[RobotManager sharedInstance] isRobotWithUsername:chatter]) {
        chatController = [[RobotChatViewController alloc] initWithChatter:chatter
                                                         conversationType:conversation.conversationType];
        chatController.title = _name;
    }else {
        chatController = [[ChatViewController alloc] initWithChatter:chatter
                                                    conversationType:conversation.conversationType];
        ChatListCell * cell=[tableView cellForRowAtIndexPath:indexPath];
        chatController.title = cell.name;
    }
    
    chatController.delelgate = self;
    [self.navigationController pushViewController:chatController animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [self.dataSource objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES append2Chat:YES];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    __weak typeof(self) weakSelf = self;
    //    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataSource searchText:(NSString *)searchText collationStringSelector:@selector(showName) resultBlock:^(NSArray *results) {
    //        if (results) {
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                [weakSelf.searchController.resultsSource removeAllObjects];
    //                [weakSelf.searchController.resultsSource addObjectsFromArray:results];
    //                [weakSelf.searchController.searchResultsTableView reloadData];
    //            });
    //        }
    //    }];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    //    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate
//刷新消息列表
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self refreshDataSource];
    [_slimeView endRefresh];
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - public

-(void)refreshDataSource
{
    //    EMConversation *conversation = [self.dataSource objectAtIndex:indexPath.row];
    
    self.dataSource = [self loadDataSource];
    _chatIDs = [[NSString alloc] init];
    int i=0;
    for (EMConversation *conversation in self.dataSource) {
        //        [self getNickNameAndPhotoWithChatID:conversation.chatter];
        if (i==0) {
            _chatIDs=conversation.chatter;
        }else{
            _chatIDs= [NSString stringWithFormat:@"%@,%@",_chatIDs,conversation.chatter];
        }
        i++;
        
    }
    [self getNickNameAndPhotoWithChatID:_chatIDs];
    NSLog(@"~~~~~~~~%@",_chatIDs);
//    [_tableView reloadData];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        _tableView.tableHeaderView = _networkStateView;
    }
    else{
        _tableView.tableHeaderView = nil;
    }
}

- (void)willReceiveOfflineMessages{
    NSLog(NSLocalizedString(@"message.beginReceiveOffine", @"Begin to receive offline messages"));
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self refreshDataSource];
}

- (void)didFinishedReceiveOfflineMessages{
    NSLog(NSLocalizedString(@"message.endReceiveOffine", @"End to receive offline messages"));
}

#pragma mark - ChatViewControllerDelegate

// 根据环信id得到要显示头像路径，如果返回nil，则显示默认头像
- (NSString *)avatarWithChatter:(NSString *)chatter{
    //    return @"http://img0.bdstatic.com/img/image/shouye/jianbihua0525.jpg";
    return nil;
}

// 根据环信id得到要显示用户名，如果返回nil，则默认显示环信id
- (NSString *)nickNameWithChatter:(NSString *)chatter{
    return chatter;
}

@end
