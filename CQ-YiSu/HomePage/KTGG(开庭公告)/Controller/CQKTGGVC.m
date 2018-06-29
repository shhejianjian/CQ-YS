//
//  CQKTGGVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/28.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQKTGGVC.h"
#import "MXConstant.h"
#import "CQKTGGCell.h"
#import "CQKTGGModel.h"
#import "CQKTGGDetailView.h"
#import "CQKTGGSearchView.h"
#import "CQOnlineRegistrationModel.h"
#import "BRPickerView.h"
#import "BRInfoModel.h"

static NSString *ID=@"CQKTGGCell";


@interface CQKTGGVC ()<CQKTGGSearchViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ktggArr;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) CQKTGGDetailView *alert;
@property (nonatomic, strong) CQKTGGSearchView *alert2;
@property (nonatomic, strong) NSMutableArray *dmmsArr;
@property (nonatomic, strong) NSMutableArray *fydmArr;
@property (strong, nonatomic) NSString *fydm;
@property (strong, nonatomic) NSString *ggrq;
@property (nonatomic, strong) BRInfoModel *infoModel;

@end

@implementation CQKTGGVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"公告送达";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CQKTGGCell" bundle:nil] forCellReuseIdentifier:ID];

    [self loadList];
    self.mxNavigationItem.rightItem = [[MXBarButtonItem alloc] initWIthImage:@"tub_31" handler:^{
        __weak CQKTGGVC *weakSelf = self;
        [self createBackgroundView];
        weakSelf.alert2 = [[CQKTGGSearchView alloc] initWithAlertViewHeight:355];
        [self.view addSubview:weakSelf.alert2];
        weakSelf.alert2.delegate = self;
        weakSelf.alert2.cancelBtnClick = ^void(UIButton *button){
            [weakSelf.bgView removeFromSuperview];
        };
        weakSelf.alert2.searchBtnClick = ^void(UIButton *button) {
            [weakSelf.ktggArr removeAllObjects];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"startDate"] = self.ggrq;
            params[@"fydm"] = self.fydm;
            params[@"page"] = @"1";
            params[@"pageSize"] = @"10";
            NSLog(@"data:%@",params);
            [GYHttpTool post:ktgg_list ticket:nil params:params success:^(id json) {
                NSLog(@"json:%@",json);
                NSArray *arr = [CQKTGGModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
                for (CQKTGGModel *model in arr) {
                    [weakSelf.ktggArr addObject:model];
                }
                [weakSelf.tableView reloadData];
            } failure:^(NSError *error) {
            }];
            [self.bgView removeFromSuperview];
        };
    }];

    // Do any additional setup after loading the view from its nib.
}


-(void)loadList{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @"1";
    params[@"pageSize"] = @"10";
    [GYHttpTool post:ktgg_list ticket:nil params:params success:^(id json) {
        NSLog(@"json:%@",json);
                NSArray *arr = [CQKTGGModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
                for (CQKTGGModel *model in arr) {
                    [self.ktggArr addObject:model];
                }
                [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ktggArr.count;
}

- (CQKTGGCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQKTGGCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[CQKTGGCell alloc]init];
    }
    cell.ktggModel = self.ktggArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CQKTGGModel *model = self.ktggArr[indexPath.row];
    __weak CQKTGGVC *weakSelf = self;
    [self createBackgroundView];
    weakSelf.alert = [[CQKTGGDetailView alloc] initWithAlertViewHeight:270];
    weakSelf.alert.ahqcLabel.text = model.ahqc;
    weakSelf.alert.ggnrLabel.text = model.ggnr;
    weakSelf.alert.fbrxm.text = model.fbrxm;
    weakSelf.alert.fymcLabel.text = model.fymc;
    [self.view addSubview:weakSelf.alert];
    weakSelf.alert.cancelBtnClick = ^void(UIButton *button){
        [weakSelf.bgView removeFromSuperview];
    };
    //取消点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

-(void)createBackgroundView{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENwidth, MAINSCREENheight)];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    self.bgView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgView];
}


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
                    self.fydm = model.dm;
                }
            }
            [sender setTitle:selectValue forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }];
    } failure:^(NSError *error) {
    }];
    
}

- (void)ChooseRQWithBtnTag:(UIButton *)sender {
    NSDate *minDate = [NSDate br_setYear:1990 month:3 day:12];
    NSDate *maxDate = [NSDate date];
    [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        self.alert2.dateLabel.text = self.infoModel.birthdayStr = selectValue;
        self.alert2.dateLabel.textColor = [UIColor blackColor];
        self.ggrq = selectValue;
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)ktggArr {
    if(_ktggArr == nil) {
        _ktggArr = [[NSMutableArray alloc] init];
    }
    return _ktggArr;
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
