//
//  CQMineVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/4.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQMineVC.h"
#import "MXConstant.h"
#import "CQUserInfoVC.h"
#import "CQMineButtonCell.h"
#import "CQMainWSLACell.h"
#import "CQMainZZJHCell.h"
#import "CQMainDZSDCell.h"
#import "MQVerCodeImageView.h"
#import "CQLoginModel.h"
#import "CQCourtInfoModel.h"
#import "CQSignUpVC.h"
#import "CQPageStatisticsModel.h"
#import "CQOnlineRegistrationVC.h"
#import "CQAJCXVC.h"
#import "CQDZSDVC.h"
#import "CQZJJHListVC.h"


static NSString *ID1=@"CQMineButtonCell";
static NSString *ID2=@"CQMainWSLACell";
static NSString *ID3=@"CQMainZZJHCell";
static NSString *ID4=@"CQMainDZSDCell";





@interface CQMineVC ()<CQMainWSLACellDelegate,CQMainZZJHCellDelegate,CQMainDZSDCellDelegate>
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UITableView *mineTableView;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *loginName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *partiesBtn;
@property (strong, nonatomic) IBOutlet UIButton *lawyerBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet MQVerCodeImageView *codeImageView;
@property (strong, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) NSString *imageCodeStr;
@property (weak, nonatomic) NSString *lx;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (nonatomic ,strong) CQPageStatisticsModel *wslaModel;
@property (nonatomic ,strong) CQPageStatisticsModel *dzsdDQSModel;
@property (nonatomic ,strong) CQPageStatisticsModel *dzsdYQSModel;
@property (nonatomic ,strong) CQPageStatisticsModel *zzjhModel;


@end

@implementation CQMineVC

- (void)viewWillAppear:(BOOL)animated{
    //是否登录
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    if (!ticket) {
        self.loginView.hidden = NO;
        self.headView.hidden = YES;
        self.mineTableView.hidden = YES;
        self.mxNavigationBar.hidden = NO;
        self.mxNavigationItem.title = @"我的";
        self.loginBtn.layer.cornerRadius = 20;
        self.lx = @"1";
    }else{
        self.headView.hidden = NO;
        self.mineTableView.hidden = NO;
        self.loginView.hidden = YES;
        self.mxNavigationBar.hidden = YES;
        [self.mineTableView reloadData];
        [self loadPageStatistics];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.image = [UIImage imageNamed:@"user"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"user1"];

    self.mxNavigationBar.hidden = YES;
    [self.mineTableView registerNib:[UINib nibWithNibName:@"CQMineButtonCell" bundle:nil] forCellReuseIdentifier:ID1];
    [self.mineTableView registerNib:[UINib nibWithNibName:@"CQMainWSLACell" bundle:nil] forCellReuseIdentifier:ID2];
    [self.mineTableView registerNib:[UINib nibWithNibName:@"CQMainZZJHCell" bundle:nil] forCellReuseIdentifier:ID3];
    [self.mineTableView registerNib:[UINib nibWithNibName:@"CQMainDZSDCell" bundle:nil] forCellReuseIdentifier:ID4];

    //用户名
    self.username.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_username"];

    //隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];

    //登录验证码
    __weak __typeof(self) weakSelf = self;
    self.codeImageView.bolck = ^(NSString *imageCodeStr){//看情况是否需要
        weakSelf.imageCodeStr = imageCodeStr;
    };
    self.codeImageView.isRotation = NO;
    [self.codeImageView freshVerCode];
    
    //点击刷新验证码
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.codeImageView addGestureRecognizer:taps];
    [self.loginView addSubview: self.codeImageView];

    // Do any additional setup after loading the view from its nib.
}

//隐藏键盘
-(void)viewTapped:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

- (void)tapClick:(UITapGestureRecognizer*)taps{
    [self.codeImageView freshVerCode];
}

//统计
-(void)loadPageStatistics{
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:tj_wsla_ajxx ticket:ticket params:nil success:^(id json) {
        NSLog(@"json111111:%@",json);
        self.wslaModel = [CQPageStatisticsModel mj_objectWithKeyValues:json[@"parameters"]];
        [self.mineTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
    params1[@"sdzt"] = @"1";
    [GYHttpTool post:dzsd_yw ticket:ticket params:params1 success:^(id json) {
        NSLog(@"json:%@",json);
        self.dzsdYQSModel = [CQPageStatisticsModel mj_objectWithKeyValues:json[@"parameters"]];
//        [[NSUserDefaults standardUserDefaults] setObject:self.dzsdYQSModel.ticket forKey:@"login_ticket"];
        [self.mineTableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];

    
    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    params2[@"sdzt"] = @"2";
    [GYHttpTool post:dzsd_yw ticket:ticket params:params2 success:^(id json) {
        NSLog(@"json:%@",json);
        self.dzsdDQSModel = [CQPageStatisticsModel mj_objectWithKeyValues:json[@"parameters"]];
        NSLog(@"ticket::%@",self.dzsdDQSModel.ticket);
        [[NSUserDefaults standardUserDefaults] setObject:self.dzsdDQSModel.ticket forKey:@"login_ticket"];
        [self.mineTableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];

    [GYHttpTool post:zjjh_countTj ticket:ticket params:nil success:^(id json) {
        NSLog(@"json:%@",json);
        self.zzjhModel = [CQPageStatisticsModel mj_objectWithKeyValues:json[@"parameters"]];
        
        [self.mineTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

//当事人登录
- (IBAction)partiesLogin:(id)sender {
    self.lawyerBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.lawyerBtn.titleLabel.textColor=[UIColor darkGrayColor];
    self.partiesBtn.backgroundColor = [UIColor whiteColor];
    [self.partiesBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    self.lx = @"1";
}

//律师登录
- (IBAction)lawyerLogin:(id)sender {
    self.partiesBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.partiesBtn.titleLabel.textColor=[UIColor darkGrayColor];
    self.lawyerBtn.backgroundColor = [UIColor whiteColor];
    [self.lawyerBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];//设置按钮颜色
    self.lx = @"2";
}

//登录
- (IBAction)clickLoginBtn:(id)sender {
    if ([self.code.text caseInsensitiveCompare:self.imageCodeStr] == NSOrderedSame) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"loginName"] = self.loginName.text;
        params[@"password"] = self.password.text;
        params[@"lx"] = self.lx;
        NSLog(@"dic::%@",params);
        [GYHttpTool post:wsla_login ticket:nil params:params success:^(id json) {
            NSLog(@"json2:%@",json);
            CQLoginModel *loginModel = [CQLoginModel mj_objectWithKeyValues:json[@"parameters"]];
            if ([loginModel.flag isEqualToString:@"true"]) {
                [MBProgressHUD showSuccess:loginModel.msg];
                [self loadPageStatistics];
                [[NSUserDefaults standardUserDefaults] setObject:loginModel.ticket forKey:@"login_ticket"];
                CQCourtInfoModel *courtInfo = [CQCourtInfoModel mj_objectWithKeyValues:loginModel.courtInfo];
                [[NSUserDefaults standardUserDefaults] setObject:courtInfo.userName forKey:@"login_username"];
                self.loginView.hidden = YES;
                self.headView.hidden = NO;
                self.mineTableView.hidden = NO;
                self.mxNavigationBar.hidden = YES;
                [self loadPageStatistics];
            } else {
                [MBProgressHUD showError:loginModel.msg];
            }
            [MBProgressHUD hideHUDForView:self.view];
            
        } failure:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
    }else{
        [MBProgressHUD showError:@"验证码输入错误，请重新输入"];
    }
}

//注册
- (IBAction)clickSignUpBtn:(id)sender {
    CQSignUpVC *signUpVC = [[CQSignUpVC alloc]init];
    [self.navigationController pushViewController:signUpVC animated:YES];
}

//修改用户信息
- (IBAction)updateUserInfo:(id)sender {
    CQUserInfoVC *userInfoVC = [[CQUserInfoVC alloc]init];
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1){
        return 135;
    }else if(indexPath.section == 2){
        return 80;
    }else{
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0){
        CQMineButtonCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (!cell1) {
            cell1 = [[CQMineButtonCell alloc]init];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell1;
    } else if (indexPath.section == 1){
        CQMainWSLACell *cell2 = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!cell2) {
            cell2 = [[CQMainWSLACell alloc]init];
        }
        cell2.pageModel = self.wslaModel;
        cell2.delegate = self;
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell2;
    }else if (indexPath.section == 2){
        CQMainZZJHCell *cell3 = [tableView dequeueReusableCellWithIdentifier:ID3];
        if (!cell3) {
            cell3 = [[CQMainZZJHCell alloc]init];
        }
        cell3.pageModel = self.zzjhModel;
        cell3.delegate = self;
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell3;
    }else{
        CQMainDZSDCell *cell4 = [tableView dequeueReusableCellWithIdentifier:ID4];
        if (!cell4) {
            cell4 = [[CQMainDZSDCell alloc]init];
        }
//        cell4.pageModel = self.dzsdModel;
        cell4.dqsLabel.text = self.dzsdDQSModel.count;
        cell4.yqsLabel.text = self.dzsdYQSModel.count;
        cell4.adajLabel.text = self.wslaModel.wdaj;
        cell4.delegate = self;
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell4;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return CGFLOAT_MIN;
    }else{
        return 10;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)clickWSLABtn:(UIButton *)button {
    if(button.tag == 0){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = nil;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (button.tag == 1){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = @"0";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 2){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 3){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = @"2";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 4){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = @"3";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 5){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = @"4";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 6){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = @"5";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 7){
        CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
        vc.clztStr = @"6";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)clickZZJHBtn:(UIButton *)button{
    if (button.tag == 0) {
        CQZJJHListVC *vc = [[CQZJJHListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 1){
        CQZJJHListVC *vc = [[CQZJJHListVC alloc]init];
        vc.status = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 2){
        CQZJJHListVC *vc = [[CQZJJHListVC alloc]init];
        vc.status = @"2";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)clickDZSDBtn:(UIButton *)button{
    if (button.tag == 0) {
        CQDZSDVC *vc = [[CQDZSDVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 1){
        CQDZSDVC *vc = [[CQDZSDVC alloc]init];
        vc.sdzt = @"1";
        [self.navigationController pushViewController:vc animated:YES];

    }else if (button.tag == 2){
        CQAJCXVC *vc = [[CQAJCXVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 3){
        
    }
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


- (IBAction)login:(id)sender {
    self.loginView.hidden = NO;
    self.headView.hidden = YES;
    self.mineTableView.hidden = YES;
    self.mxNavigationBar.hidden = NO;
    self.mxNavigationItem.title = @"我的";
    self.loginBtn.layer.cornerRadius = 20;
    self.lx = @"1";
}

@end
