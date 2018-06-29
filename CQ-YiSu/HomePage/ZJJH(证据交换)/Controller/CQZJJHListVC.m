//
//  CQZJJHListVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/19.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQZJJHListVC.h"
#import "MXConstant.h"
#import "CQZJJHWclCell.h"
#import "CQZJJHModel.h"

static NSString *ID=@"CQZJJHWclCell";


@interface CQZJJHListVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *zjjhArr;
@property (strong, nonatomic) IBOutlet UIView *wclView;
@property (strong, nonatomic) IBOutlet UIView *yclView;

@end

@implementation CQZJJHListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"证据交换";

    [self.tableView registerNib:[UINib nibWithNibName:@"CQZJJHWclCell" bundle:nil] forCellReuseIdentifier:ID];
    
    if ([self.status isEqualToString:@"2"]) {
        self.status = @"2";
        self.yclView.hidden = NO;
        self.wclView.hidden = YES;
        [self loadList:self.status];
    }else{
        self.status = @"1";
        self.yclView.hidden = YES;
        self.wclView.hidden = NO;
        [self loadList:self.status];
    }

    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickWclBtn:(id)sender {
    self.status = @"1";
    self.yclView.hidden = YES;
    self.wclView.hidden = NO;
    [self loadList:self.status];
}

- (IBAction)clickYclBtn:(id)sender {
    self.status = @"2";
    self.yclView.hidden = NO;
    self.wclView.hidden = YES;
    [self loadList:self.status];
}


-(void)loadList:(NSString *)status{
    [self.zjjhArr removeAllObjects];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"status"] = status;
    params[@"page"] = @"1";
    params[@"pagesize"] = @"10";
    NSLog(@"tt:%@",ticket);
    [GYHttpTool post:zjjh_list ticket:ticket params:params success:^(id json) {
        NSLog(@"json:%@",json);
        NSArray *arr = [CQZJJHModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (CQZJJHModel *model in arr) {
            [self.zjjhArr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
}



#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.zjjhArr.count;
}

- (CQZJJHWclCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQZJJHWclCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[CQZJJHWclCell alloc]init];
    }
    cell.status = self.status;
    cell.zjjhModel = self.zjjhArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)zjjhArr {
    if(_zjjhArr == nil) {
        _zjjhArr = [[NSMutableArray alloc] init];
    }
    return _zjjhArr;
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
