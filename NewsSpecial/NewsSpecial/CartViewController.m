//
//  CartViewController.m
//  weiliao
//
//  Created by 游成虎 on 16/11/2.
//  Copyright © 2016年 游成虎. All rights reserved.
//

#import "CartViewController.h"
#import "YSchedulingTableViewCell.h"
#import <EventKit/EventKit.h>
#define YLIST_RUL @"http://ywapp.hryouxi.com/yuwanapi/app/listCalendar"

@interface CartViewController ()
@property(nonatomic,assign)NSString * currentNew;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self.tableView registerClass:[YSchedulingTableViewCell class] forCellReuseIdentifier:@"YSchedulingTableViewCell"];

    self.tableView.estimatedRowHeight = 260;
    self.tableView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}
- (void)loadMoreData {
    self.currentNew = [NSString stringWithFormat:@"%d",self.currentNew.intValue + 1];
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:YLIST_RUL] andParamter:@{@"pageSize":@"20",@"pageNo":self.currentNew, @"userId" : @"",@"type" : @"0"} returnData:^(NSData *data, NSError *error) {
        if (!error) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            NSArray * dataArr = dic[@"data"][@"catchList"][@"list"];
            [self.dataList addObjectsFromArray:dataArr];
            [self.tableView reloadData];
            [self.tableView.footer endRefreshing];
        }else{
            [self.tableView.footer endRefreshing];
        }
    }];
}
- (void)loadData
{
    _currentNew = @"1";
    [YCHNetworking postStartRequestFromUrl:[NSString stringWithFormat:YLIST_RUL] andParamter:@{@"pageSize":@"20",@"pageNo":self.currentNew, @"userId" : @"",@"type" : @"0"} returnData:^(NSData *data, NSError *error) {
        if (!error) {
            [self.dataList removeAllObjects];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            NSArray * dataArr = dic[@"data"][@"catchList"][@"list"];
            [self.dataList addObjectsFromArray:dataArr];
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
        }else{
            [self.tableView.header endRefreshing];
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = self.dataList[indexPath.row];
    YSchedulingTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"YSchedulingTableViewCell"];
    [cell loadData:data];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSDictionary * data = self.dataList[indexPath.row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定添加提醒到日历吗?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *skipAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view showLoadingMeg:@"已成功添加到日历" time:1];
        [self saveEvent:data];
    }];
   
    [alertController addAction:cancelAction];
    [alertController addAction:skipAction];
 
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)saveEvent:(NSDictionary *)model
{
    //calshow:后面加时间戳格式，也就是NSTimeInterval
    //    注意这里计算时间戳调用的方法是-
    //    NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSinceDate:2016];
    
    //    timeIntervalSinceReferenceDate的参考时间是2000年1月1日，
    //    [NSDate date]是你希望跳到的日期。
    
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //06.07 使用 requestAccessToEntityType:completion: 方法请求使用用户的日历数据库
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    //06.07 元素
                    //title(标题 NSString),
                    //location(位置NSString),
                    //startDate(开始时间 2016/06/07 11:14AM),
                    //endDate(结束时间 2016/06/07 11:14AM),
                    //addAlarm(提醒时间 2016/06/07 11:14AM),
                    //notes(备注类容NSString)
                    
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title  = model[@"title"];
                    event.location = model[@"address"];
                    
                    //                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    //                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    //06.07 时间格式
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setAMSymbol:@"AM"];
                    [dateFormatter setPMSymbol:@"PM"];
                    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mmaaa"];
                    
                    //NSString * s = [dateFormatter stringFromDate:date];
                    NSDate *date = [dateFormatter dateFromString:model[@"dateStr"]];
                    // NSLog(@"%@",s);
                    
                    //开始时间(必须传)
                    event.startDate = [date dateByAddingTimeInterval:60 * 2];
                    //结束时间(必须传)
                    event.endDate   = [date dateByAddingTimeInterval:60 * 5 * 24];
                    //                    event.endDate   = [[NSDate alloc]init];
                    //                    event.allDay = YES;//全天
                    
                    //添加提醒
                    //第一次提醒  (几分钟后)
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -1.0f]];
                    //第二次提醒  ()
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -10.0f * 24]];
                    
                    //06.07 add 事件类容备注
                    NSString * str = @"接受信息类容备注";
                    event.notes = [NSString stringWithFormat:@"%@",str];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    NSLog(@"保存成功");
                    
                    //直接杀死进程
                    // exit(2);
                    
                }
            });
        }];
    }
    
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow:"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
