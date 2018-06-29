//
//  CQAJCXVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQAJCXVC.h"
#import "MXConstant.h"
#import "CQAJCXCell.h"
#import "CQAJCXSearchView.h"
#import "CQAJCXModel.h"

static NSString *ID=@"CQAJCXCell";


@interface CQAJCXVC ()
@property (strong, nonatomic) IBOutlet UIButton *wylaBtn;
@property (strong, nonatomic) IBOutlet UIButton *bdajBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) CQAJCXSearchView *alert;
@property (nonatomic, strong) NSMutableArray *ajcxArr;
@property (nonatomic, assign) int currentPage;



@end

@implementation CQAJCXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"我的案件";
    
    [self.wylaBtn.layer setMasksToBounds:YES];
    self.wylaBtn.layer.cornerRadius = 10.0f;
    [self.bdajBtn.layer setMasksToBounds:YES];
    self.bdajBtn.layer.cornerRadius = 10.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"CQAJCXCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    [self loadList];
    self.mxNavigationItem.rightItem = [[MXBarButtonItem alloc] initWIthImage:@"tub_31" handler:^{
        __weak CQAJCXVC *weakSelf = self;

        [self createBackgroundView];
        weakSelf.alert = [[CQAJCXSearchView alloc] initWithAlertViewHeight:355];
        [self.view addSubview:weakSelf.alert];
        weakSelf.alert.cancelBtnClick = ^void(UIButton *button){
            [weakSelf.bgView removeFromSuperview];
        };
        weakSelf.alert.searchBtnClick = ^void(UIButton *button){
            [weakSelf.ajcxArr removeAllObjects];
            NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"ygmc"] = weakSelf.alert.yuangaoTextField.text;
            params[@"bgmc"] = weakSelf.alert.beigaoTextField.text;
            params[@"page"] = @(self.currentPage);
            params[@"pagesize"] = @"10";
            
            [GYHttpTool post:wdaj_list ticket:ticket params:params success:^(id json) {
                NSLog(@"json:%@",json);
                NSArray *arr = [CQAJCXModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
                for (CQAJCXModel *model in arr) {
                    [weakSelf.ajcxArr addObject:model];
                }
                [weakSelf.tableView reloadData];
            } failure:^(NSError *error) {
            }];
            [weakSelf.bgView removeFromSuperview];
        };
    }];


    // Do any additional setup after loading the view from its nib.
}

- (void)loadNewData
{
    [self.ajcxArr removeAllObjects];
    self.currentPage = 1;
    [self loadList];
    
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadList];
}


-(void)createBackgroundView{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENwidth, MAINSCREENheight)];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    self.bgView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgView];
}

-(void)loadList{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @"8";
    params[@"page"] = @(self.currentPage);
    [GYHttpTool post:wdaj_list ticket:ticket params:nil success:^(id json) {
        NSLog(@"json:%@",json);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [CQAJCXModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (CQAJCXModel *model in arr) {
            [self.ajcxArr addObject:model];
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
    return self.ajcxArr.count;
}

- (CQAJCXCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQAJCXCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[CQAJCXCell alloc]init];
    }
    cell.ajcxModel = self.ajcxArr[indexPath.row];
    //    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)ajcxArr {
    if(_ajcxArr == nil) {
        _ajcxArr = [[NSMutableArray alloc] init];
    }
    return _ajcxArr;
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
