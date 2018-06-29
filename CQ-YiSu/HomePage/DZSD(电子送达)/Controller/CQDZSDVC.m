//
//  CQDZSDVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQDZSDVC.h"
#import "MXConstant.h"
#import "CQDZSDCell.h"
#import "CQDZSDSignVC.h"

static NSString *ID=@"CQDZSDCell";


@interface CQDZSDVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dzsdArr;
@property (strong, nonatomic) IBOutlet UIView *dqsView;
@property (strong, nonatomic) IBOutlet UIView *yqsView;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, assign) int currentPage;


@end

@implementation CQDZSDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"电子送达";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CQDZSDCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];


    if ([self.sdzt isEqualToString:@"1"]) {
        self.dqsView.hidden = YES;
        self.yqsView.hidden = NO;
        self.sdzt = @"1";
        [self loadNoSignList:self.sdzt];
    }else{
        self.dqsView.hidden = NO;
        self.yqsView.hidden = YES;
        self.sdzt = @"2";
        [self loadNoSignList:self.sdzt];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadNewData
{
    [self.dzsdArr removeAllObjects];
    self.currentPage = 1;
    
    [self loadNoSignList:_sdzt];
    
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadNoSignList:_sdzt];
}

//点击未签收
- (IBAction)clickNoSignBtn:(id)sender {
    self.dqsView.hidden = NO;
    self.yqsView.hidden = YES;
    self.sdzt = @"2";
    [self loadNoSignList:self.sdzt];
}

//点击已签收
- (IBAction)clickSignBtn:(id)sender {
    self.dqsView.hidden = YES;
    self.yqsView.hidden = NO;
    self.sdzt = @"1";
    [self loadNoSignList:self.sdzt];
}

//加载列表
-(void)loadNoSignList:(NSString *)sdzt{
    [self.dzsdArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];

    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"sdzt"] = sdzt;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"10";
    NSLog(@"tt:%@",ticket);
    [GYHttpTool post:dzsd_yw ticket:ticket params:params success:^(id json) {
        NSLog(@"json:%@",json);
        [MBProgressHUD hideHUDForView:self.view];

        CQDZSDModel *model = [CQDZSDModel mj_objectWithKeyValues:json[@"parameters"]];
        [[NSUserDefaults standardUserDefaults] setObject:model.ticket forKey:@"login_ticket"];
        NSArray *arr = [CQDZSDModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (CQDZSDModel *model in arr) {
            [self.dzsdArr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络不稳定，请稍后再试"];

    }];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];

}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dzsdArr.count;
}

- (CQDZSDCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQDZSDCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[CQDZSDCell alloc]init];
    }
    cell.dzsdModel = self.dzsdArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CQDZSDModel *model = self.dzsdArr[indexPath.row];
    
    if ([self.sdzt isEqualToString:@"1"]) {
        CQDZSDSignVC *vc = [[CQDZSDSignVC alloc]init];
        NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = model.id;
        [GYHttpTool postImage:dzsd_file ticket:ticket params:params success:^(id json) {
            NSLog(@"json:::==%@==%@",json,params);
            if (json) {
                [MBProgressHUD hideHUDForView:self.view];
                NSString *rootPath = [self dirDoc];
                self.filePath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",model.id]];
                [json writeToFile:self.filePath atomically:NO];
                NSLog(@"filePath::::%@",self.filePath);
                vc.pdfFilePath = self.filePath;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    //取消点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dzsdArr {
    if(_dzsdArr == nil) {
        _dzsdArr = [[NSMutableArray alloc] init];
    }
    return _dzsdArr;
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
