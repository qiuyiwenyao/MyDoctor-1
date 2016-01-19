//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat MXMail_MJRefreshHeaderHeight = 54.0;
const CGFloat MXMail_MJRefreshFooterHeight = 44.0;
const CGFloat MXMail_MJRefreshFastAnimationDuration = 0.25;
const CGFloat MXMail_MJRefreshSlowAnimationDuration = 0.4;

NSString *const MXMail_MJRefreshHeaderUpdatedTimeKey = @"MXMail_MJRefreshHeaderUpdatedTimeKey";
NSString *const MXMail_MJRefreshContentOffset = @"contentOffset";
NSString *const MXMail_MJRefreshContentSize = @"contentSize";
NSString *const MXMail_MJRefreshPanState = @"pan.state";

NSString *const MXMail_MJRefreshHeaderStateIdleText = @"下拉可以刷新";
NSString *const MXMail_MJRefreshHeaderStatePullingText = @"松开立即刷新";
NSString *const MXMail_MJRefreshHeaderStateRefreshingText = @"正在刷新数据中...";

NSString *const MXMail_MJRefreshFooterStateIdleText = @"点击加载更多";
NSString *const MXMail_MJRefreshFooterStateRefreshingText = @"正在加载更多的数据...";
NSString *const MXMail_MJRefreshFooterStateNoMoreDataText = @"已经全部加载完毕";