//
//  CQOnlineRegistrationVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/5.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQOnlineRegistrationVC.h"
#import "MXConstant.h"
#import "CQOnlineRegistrationCell.h"
#import "CQOnlineRegistrationModel.h"
#import "CQWSLASearchView.h"
#import "CQWSLANewCaseVC.h"
#import "BRPickerView.h"
#import "CQUploadFileVC.h"
#import "CQSMRZVC.h"


static NSString *ID=@"CQOnlineRegistrationCell";
extern NSString *checkSucessWsla;


@interface CQOnlineRegistrationVC ()<CQWSLASearchViewDelegate,CQOnlineRegistrationCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *onlineRegistrationTableView;
@property (nonatomic, strong) NSMutableArray *wslaArr;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) CQWSLASearchView *alert;
@property (nonatomic, strong) NSMutableArray *dmmsArr;
@property (nonatomic, strong) NSMutableArray *fydmArr;
@property (strong, nonatomic) IBOutlet UIButton *wylaBtn;
@property (strong, nonatomic) NSString *dm;
@property (nonatomic, assign) int currentPage;


@end

@implementation CQOnlineRegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"网上立案";
    
    [self.wylaBtn.layer setMasksToBounds:YES];
    self.wylaBtn.layer.cornerRadius = 10.0f;
    
    self.onlineRegistrationTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.onlineRegistrationTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];


    [self.onlineRegistrationTableView registerNib:[UINib nibWithNibName:@"CQOnlineRegistrationCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadList:_clztStr];
    
    self.mxNavigationItem.rightItem = [[MXBarButtonItem alloc] initWIthImage:@"tub_31" handler:^{
        __weak CQOnlineRegistrationVC *weakSelf = self;
        [self createBackgroundView];
        weakSelf.alert = [[CQWSLASearchView alloc] initWithAlertViewHeight:355];
        [self.view addSubview:weakSelf.alert];
        weakSelf.alert.delegate = self;
        weakSelf.alert.cancelBtnClick = ^void(UIButton *button){
            [weakSelf.bgView removeFromSuperview];
        };
        weakSelf.alert.searchBtnClick = ^void(UIButton *button) {
            [weakSelf.wslaArr removeAllObjects];
            [MBProgressHUD showMessage:@"正在加载" toView:self.view];

            NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"clzt"] = weakSelf.alert.clzt;
            params[@"fydm"] = weakSelf.dm;
            params[@"dsr"] = weakSelf.alert.dsrTextField.text;
            params[@"page"] = @"1";
            params[@"pageSize"] = @"10";
            [GYHttpTool post:wsla_list ticket:ticket params:params success:^(id json) {
                NSLog(@"json:%@",json);
                [MBProgressHUD hideHUDForView:self.view];

                NSArray *arr = [CQOnlineRegistrationModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
                for (CQOnlineRegistrationModel *model in arr) {
                    [weakSelf.wslaArr addObject:model];
                }
                [weakSelf.onlineRegistrationTableView reloadData];
            } failure:^(NSError *error) {
                [MBProgressHUD showError:@"网络不稳定，请稍后再试"];

            }];
            [self.bgView removeFromSuperview];
            [self.onlineRegistrationTableView.mj_header endRefreshing];
            [self.onlineRegistrationTableView.mj_footer endRefreshing];

        };
    }];
    // Do any additional setup after loading the view from its nib.
}



- (void)loadNewData
{
    [self.wslaArr removeAllObjects];
    self.currentPage = 1;

    [self loadList:_clztStr];
    
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadList:_clztStr];
}


-(void)createBackgroundView{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENwidth, MAINSCREENheight)];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    self.bgView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgView];
}

//加载表格
-(void)loadList:(NSString *)clztStr{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"clzt"] = clztStr;
    params[@"pageSize"] = @"8";
    params[@"page"] = @(self.currentPage);

    [GYHttpTool post:wsla_list ticket:ticket params:params success:^(id json) {
        NSLog(@"json:%@",json);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [CQOnlineRegistrationModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (CQOnlineRegistrationModel *model in arr) {
            [self.wslaArr addObject:model];
        }
        [self.onlineRegistrationTableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络不稳定，请稍后再试"];
    }];
    [self.onlineRegistrationTableView.mj_header endRefreshing];
    [self.onlineRegistrationTableView.mj_footer endRefreshing];

}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wslaArr.count;
}

- (CQOnlineRegistrationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQOnlineRegistrationCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[CQOnlineRegistrationCell alloc]init];
    }
    cell.delegate = self;
    cell.wslaModel = self.wslaArr[indexPath.row];
    cell.deleteBtn.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CQOnlineRegistrationModel *model = self.wslaArr[indexPath.row];
//    CQUploadFileVC *vc = [[CQUploadFileVC alloc]init];
    CQSMRZVC *vc = [[CQSMRZVC alloc]init];

    vc.ajbsStr = model.ajbs;
//    vc.spcxStr = model.spcx;
    [self.navigationController pushViewController:vc animated:YES];
    //取消点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)newCase:(id)sender {
    CQWSLANewCaseVC *vc = [[CQWSLANewCaseVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

//选择法院
- (void)SetCourtWithBtnTag:(UIButton *)sender {
    [self.dmmsArr removeAllObjects];
    [self.fydmArr removeAllObjects];
    [GYHttpTool post:select_fy ticket:nil params:nil success:^(id json) {
        NSLog(@"json:%@",json);
        
        NSArray *arr = [CQOnlineRegistrationModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (CQOnlineRegistrationModel *model in arr) {
            [self.dmmsArr addObject:model.dmms];
            [self.fydmArr addObject:model.dm];
        }
        [BRStringPickerView showStringPickerWithTitle:@"选择法院" dataSource:self.dmmsArr defaultSelValue:sender resultBlock:^(id selectValue) {
            for (CQOnlineRegistrationModel *model in arr) {
                if ([selectValue isEqualToString:model.dmms]) {
                    NSLog(@"...%@",model.dm);
                    self.dm = model.dm;
                }
            }
            [sender setTitle:selectValue forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }];
    } failure:^(NSError *error) {
    }];
}


//删除
-(void)clickDeleteBtn:(NSInteger)index{
    CQOnlineRegistrationModel *model = self.wslaArr[index];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = model.ajbs;
    [GYHttpTool post:wsla_ms ticket:ticket params:nil success:^(id json) {
        NSLog(@"json:%@",json);
        [self.onlineRegistrationTableView reloadData];
    } failure:^(NSError *error) {
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)wslaArr {
    if(_wslaArr == nil) {
        _wslaArr = [[NSMutableArray alloc] init];
    }
    return _wslaArr;
}

- (NSMutableArray *)dmmsArr {
    if(_dmmsArr == nil) {
        _dmmsArr = [[NSMutableArray alloc] init];
    }
    return _dmmsArr;
}

- (NSMutableArray *)fydmArr {
    if(_fydmArr == nil) {
        _fydmArr = [[NSMutableArray alloc] init];
    }
    return _fydmArr;
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
