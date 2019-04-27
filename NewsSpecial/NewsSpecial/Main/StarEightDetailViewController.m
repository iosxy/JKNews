//
//  StarEightDetailViewController.m
//  NewsSpecial
//
//  Created by 欢瑞世纪 on 2019/4/24.
//  Copyright © 2019 GetOn. All rights reserved.
//

#import "StarEightDetailViewController.h"
#import "NewsTableViewCell.h"
#import "TCSendTextView.h"
#import "TalkModel.h"
#import "NSKeyedArchiver+TCExtension.h"
#import "TalkCell.h"
#define DETAIL_URL @"http://api.app.happyjuzi.com/article/detail?accesstoken=5fc865056742c82430db621de55b1320&brand=Apple&carrier=2&id=%@&idfa=AD40CFA7-85B0-4ECB-A823-313C5F85C325&model=iPhone7Plus&net=wifi&pf=ios&res=414x736&system=12.1.4&uid=4363595144352692&ver=4.1"

@interface StarEightDetailViewController ()
@property(nonatomic,strong) NSMutableArray * commentList;
@property (nonatomic,strong) TCSendTextView *sendTextView;

@end

@implementation StarEightDetailViewController
- (void)dealloc{
    [self.sendTextView.textView removeObserver:self forKeyPath:@"frame"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentList = [NSMutableArray array];
    self.title = @"文章详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"TalkCell" bundle:nil] forCellReuseIdentifier:@"TALK"];

    [self.tableView registerClass:[NewsTableViewCell class] forCellReuseIdentifier:@"title"];
    [self.tableView registerClass:[NewsTextTableViewCell class] forCellReuseIdentifier:@"text"];
    [self.tableView registerClass:[NewsImageTableViewCell class] forCellReuseIdentifier:@"image"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
    [self YreloadData];
   
    [self setReplay];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void) setReplay{
    self.sendTextView.textView.text = nil;
    self.sendTextView.textView.placehold = @"发送评论";
}
- (void)YreloadData{
    [self.tableView.header endRefreshing];
    NSMutableArray * arrModelTemp = [NSKeyedUnarchiver unarchiveObjectWithFileName:[self.contentId stringValue]];
    if (arrModelTemp) {
        [self.commentList addObjectsFromArray:arrModelTemp];
        [self.tableView reloadData];
        return;
    }
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:DETAIL_URL,self.contentId] andParamter:@{} returnData:^(NSData *data, NSError *error) {
        
        if (!error) {
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            
            NSLog(@"%@",dic);
            [self.dataList removeAllObjects];
            [self.dataList addObject:dic[@"data"][@"info"]];
            
            
            NSString * contents = dic[@"data"][@"contents"];
            NSMutableArray * strArr = [contents componentsSeparatedByString:@"</p><p>"];
            
            [self.dataList addObjectsFromArray:strArr];
            [self.dataList addObjectsFromArray:dic[@"data"][@"resources"][@"IMG"]];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}
- (void)YloadMoreData{
    
    [self.tableView.footer noticeNoMoreData];
    
    
}
- (TCSendTextView *)sendTextView{
    if (!_sendTextView) {
        _sendTextView = [[TCSendTextView alloc]init];
        [_sendTextView setUp];
        _sendTextView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        //        _sendTextView.bottom = (isOldHorizontalPhone ? self.view.height : self.view.height - 88);
        [_sendTextView.textView addObserver:self
                                 forKeyPath:@"frame"
                                    options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                    context:nil];
        WEAKSELF
        [_sendTextView setOnSendText:^(NSString * text) {
            [weakSelf sendComment:text];
            // 发送评论
        }];
        
        
        [self.view addSubview:_sendTextView];
        [_sendTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(isOldHorizontalPhone?0:-25);
            make.height.equalTo(@50);
            make.left.right.equalTo(self.view);
        }];
        //        _sendTextView.bottom = (isOldHorizontalPhone ? self.view.height : self.view.height - 88);
    }
    return _sendTextView;
}
//发送评论
- (void) sendComment:(NSString*)text{
    [self.sendTextView.textView resignFirstResponder];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if (![[user objectForKey:@"isLogin"]isEqualToString:@"isLogin"]) {
        [self.view showLoadingMeg:@"请先登录" time:1];
        return;
    }
    
    TalkModel * model = [TalkModel new];
    UserModel  * userModel = [UserModel currentUser];
    model.nickname = userModel.nickName;
    model.createTime = [self getCurrentTimes];
    model.content = text;
    model.headImg = userModel.userLogo;
    [self.commentList addObject:model];
    [self.tableView reloadData];
    self.sendTextView.textView.text = nil;
    [self.view showLoadingMeg:@"评论成功" time:1];
    [self cunDang];
}
- (void)cunDang {
    
    NSMutableArray *thirdArray = [self.commentList mutableCopy];
    //    [thirdArray removeObjectAtIndex:0];
    NSString * key = [NSString stringWithFormat:@"%@",[self.contentId stringValue]];
    //    [[NSUserDefaults standardUserDefaults] setValue:thirdArray forKey:key];
    //存档
    [NSKeyedArchiver archiveRootObject:thirdArray toFileName:key];
    
}

-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

#pragma mark - keyboard
- (void)myKeyboardWillShow:(NSNotification *)notif{
    //    self.keyboardShowing = YES;
    NSDictionary * userInfo = notif.userInfo;
    //    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGSize kbSize = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //    CGSize kbEndSize = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat sendViewHeight = self.sendTextView.height;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + sendViewHeight, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height - sendViewHeight;
    [self.sendTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kbSize.height);
        make.height.equalTo(@50);
        make.left.right.equalTo(self.view);
    }];
    //    [UIView animateWithDuration:duration animations:^{
    ////        CGRect frame = self.sendTextView.frame;
    ////        frame.origin.y = self.view.height - self.sendTextView.height - kbSize.height;
    ////
    ////        self.sendTextView.frame = frame;
    //
    //    }];
    
}
- (void)myKeyboardWillHide:(NSNotification *)notif{
    
    //    self.keyboardShowing = NO;
    
    NSDictionary * userInfo = notif.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, self.sendTextView.height - (isOldHorizontalPhone ? 10 : 20), 0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    [UIView animateWithDuration:duration animations:^{
        [self.sendTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(isOldHorizontalPhone?0:-25);
            make.height.equalTo(@50);
            make.left.right.equalTo(self.view);
        }];
    }];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        
        //获取之前的值和现在的值
        CGRect frameNew = [change[NSKeyValueChangeNewKey] CGRectValue];
        CGRect frameOld = [change[NSKeyValueChangeOldKey] CGRectValue];
        CGFloat offset = frameNew.size.height - frameOld.size.height;
        
        //修改sendTextView的位置和高度
        CGRect rect = self.sendTextView.frame;
        rect.size.height = frameNew.size.height + 14;
        rect.origin.y = rect.origin.y - offset;
        self.sendTextView.frame = rect;
        
        //修改tableview的contentinset,并移动
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.bottom += offset;
        self.tableView.contentInset = contentInset;
        //        [self.commentTabelView scrollToRowAtIndexPath:_indexPathLastVisible atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1){
        TalkCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TALK"];
        TalkModel * model = self.commentList[indexPath.row];
        cell.headimg.image = [UIImage imageWithContentsOfFile:model.headImg];
        if ([model.headImg length] == 0) {
            cell.headimg.image = [UIImage imageNamed:@"icon_portrait_placeholder"];
        }
        cell.nickname.text = model.nickname;
        cell.createTime.text = model.createTime;
        
        cell.content.text = model.content;
        return cell;
    }
    
    
    if (indexPath.row == 0 ) {
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath];
        
        [cell loadData:self.dataList[indexPath.row]];
        return cell;
        
    }else {
        
        id item = self.dataList[indexPath.row];
        if ([item isKindOfClass:[NSDictionary class]]) {
            NewsImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"image" forIndexPath:indexPath];
            [cell loadData:self.dataList[indexPath.row]];
            return cell;
        }else {
            
            NewsTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"text" forIndexPath:indexPath];
            [cell loadData:self.dataList[indexPath.row]];
            return cell;
            
            
        }
        
        
        
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 100;
    }else {
        return  UITableViewAutomaticDimension;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return  self.dataList.count;
    }else {
        return  self.commentList.count;
    }
    

    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}



@end
