//
//  CQGGSDVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/27.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQGGSDVC.h"
#import "MXConstant.h"
#import "CQGGSDCell.h"
#import "CQGGSDModel.h"
#import "CQGGSDSearchView.h"
#import "CQOnlineRegistrationModel.h"
#import "BRPickerView.h"
#import "BRInfoModel.h"

static NSString *ID=@"CQGGSDCell";


@interface CQGGSDVC ()<CQGGSDSearchViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ggsdArr;
@property (copy, nonatomic) NSString *sfsx;
@property (strong, nonatomic) IBOutlet UIView *ysxView;
@property (strong, nonatomic) IBOutlet UIView *sxView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) CQGGSDSearchView *alert;
@property (nonatomic, strong) NSMutableArray *dmmsArr;
@property (nonatomic, strong) NSMutableArray *fydmArr;
@property (strong, nonatomic) NSString *fydm;
@property (strong, nonatomic) NSString *ggrq;

@property (nonatomic, strong) BRInfoModel *infoModel;


@end

@implementation CQGGSDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"公告送达";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CQGGSDCell" bundle:nil] forCellReuseIdentifier:ID];
    self.sfsx = @"1";
    [self loadList:self.sfsx];
    self.sxView.hidden = YES;

    self.mxNavigationItem.rightItem = [[MXBarButtonItem alloc] initWIthImage:@"tub_31" handler:^{
        __weak CQGGSDVC *weakSelf = self;
        [self createBackgroundView];
        weakSelf.alert = [[CQGGSDSearchView alloc] initWithAlertViewHeight:355];
        [self.view addSubview:weakSelf.alert];
        weakSelf.alert.delegate = self;
        weakSelf.alert.cancelBtnClick = ^void(UIButton *button){
            [weakSelf.bgView removeFromSuperview];
        };
        weakSelf.alert.searchBtnClick = ^void(UIButton *button) {
            [weakSelf.ggsdArr removeAllObjects];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"ggrq"] = self.ggrq;
            params[@"fydm"] = self.fydm;
            params[@"dsrmc"] = weakSelf.alert.dsrmcLabel.text;
            params[@"ahqc"] = weakSelf.alert.ahqcLabel.text;
            params[@"page"] = @"1";
            params[@"pageSize"] = @"10";
            [GYHttpTool post:ggsd_list ticket:nil params:params success:^(id json) {
                NSLog(@"json:%@",json);
                NSArray *arr = [CQGGSDModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
                for (CQGGSDModel *model in arr) {
                    [weakSelf.ggsdArr addObject:model];
                }
                [weakSelf.tableView reloadData];
            } failure:^(NSError *error) {
            }];
            [self.bgView removeFromSuperview];
        };
    }];

    // Do any additional setup after loading the view from its nib.
}

-(void)loadList:(NSString *)sfsx{
    [self.ggsdArr removeAllObjects];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"sfsx"] = sfsx;
    [GYHttpTool post:ggsd_list ticket:nil params:params success:^(id json) {
        NSLog(@"json:%@",json);
        NSArray *arr = [CQGGSDModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (CQGGSDModel *model in arr) {
            [self.ggsdArr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    }];
    
}


-(void)createBackgroundView{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENwidth, MAINSCREENheight)];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    self.bgView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgView];
}

- (IBAction)clickYSXBtn:(id)sender {
    self.sfsx = @"1";
    self.sxView.hidden = YES;
    self.ysxView.hidden = NO;
    [self loadList:self.sfsx];
}

- (IBAction)clickWSXBtn:(id)sender {
    self.sfsx = @"2";
    self.sxView.hidden = NO;
    self.ysxView.hidden = YES;
    [self loadList:self.sfsx];
}



#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ggsdArr.count;
}

- (CQGGSDCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQGGSDCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[CQGGSDCell alloc]init];
    }
    cell.ggsdModel = self.ggsdArr[indexPath.row];
    //    cell.delegate = self;
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

- (NSMutableArray *)ggsdArr {
    if(_ggsdArr == nil) {
        _ggsdArr = [[NSMutableArray alloc] init];
    }
    return _ggsdArr;
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

- (BRInfoModel *)infoModel {
    if (!_infoModel) {
        _infoModel = [[BRInfoModel alloc]init];
    }
    return _infoModel;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        self.alert.dateLabel.text = self.infoModel.birthdayStr = selectValue;
        self.alert.dateLabel.textColor = [UIColor blackColor];
        self.ggrq = selectValue;
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}




@end
