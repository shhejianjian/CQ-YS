//
//  CQHomePageVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/4.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQHomePageVC.h"
#import "MXConstant.h"
#import "CQHomeImageCell.h"
#import "CQButtonListCell.h"
#import "CQOnlineRegistrationVC.h"
#import "CQReleaseDocumentsCell.h"
#import "CQActionGuideCell.h"
#import "CQButtonGroupCell.h"
#import "CQSSFJSVC.h"
#import "CQFBWSVC.h"
#import "CQSSZNVC.h"
#import "CQDZSDVC.h"
#import "CQAJCXVC.h"
#import "CQZJJHListVC.h"
#import "CQGGSDVC.h"
#import "CQKTGGVC.h"

static NSString *ID1=@"CQHomeImageCell";
static NSString *ID2=@"CQButtonListCell";
static NSString *ID3=@"CQReleaseDocumentsCell.h";
static NSString *ID4=@"CQActionGuideCell";
static NSString *ID5=@"CQButtonGroupCell";


@interface CQHomePageVC ()<CQButtonListCellDelegate,CQButtonGroupCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *homePageTableView;

@end

@implementation CQHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"易诉-重庆网上智能法院";
    self.tabBarItem.image = [UIImage imageNamed:@"shouye0"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"shouye1"];

    [self.homePageTableView registerNib:[UINib nibWithNibName:@"CQHomeImageCell" bundle:nil] forCellReuseIdentifier:ID1];
    [self.homePageTableView registerNib:[UINib nibWithNibName:@"CQButtonListCell" bundle:nil] forCellReuseIdentifier:ID2];
    [self.homePageTableView registerNib:[UINib nibWithNibName:@"CQReleaseDocumentsCell" bundle:nil] forCellReuseIdentifier:ID3];
    [self.homePageTableView registerNib:[UINib nibWithNibName:@"CQActionGuideCell" bundle:nil] forCellReuseIdentifier:ID4];
    [self.homePageTableView registerNib:[UINib nibWithNibName:@"CQButtonGroupCell" bundle:nil] forCellReuseIdentifier:ID5];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else if (indexPath.section ==1){
        return 180;
    }else{
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0){
        CQHomeImageCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (!cell1) {
            cell1 = [[CQHomeImageCell alloc]init];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell1;
    } else if (indexPath.section == 1){
        CQButtonListCell *cell2 = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!cell2) {
            cell2 = [[CQButtonListCell alloc]init];
        }
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.delegate = self;
        cell = cell2;
    }else if (indexPath.section == 2){
        CQReleaseDocumentsCell *cell3 = [tableView dequeueReusableCellWithIdentifier:ID3];
        if (!cell3) {
            cell3 = [[CQReleaseDocumentsCell alloc]init];
        }
        cell = cell3;
    }else if (indexPath.section == 3){
        CQActionGuideCell *cell4 = [tableView dequeueReusableCellWithIdentifier:ID4];
        if (!cell4) {
            cell4 = [[CQActionGuideCell alloc]init];
        }
        cell = cell4;
    }else{
        CQButtonGroupCell *cell5 = [tableView dequeueReusableCellWithIdentifier:ID5];
        if (!cell5) {
            cell5 = [[CQButtonGroupCell alloc]init];
        }
        cell5.delegate = self;

        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell5;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if (section == 4){
        return CGFLOAT_MIN;
    }else{
        return 10;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        CQFBWSVC *vc = [[CQFBWSVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3){
        CQSSZNVC *vc = [[CQSSZNVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //取消点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//首页按钮跳转
-(void)clickOnlineRegistrationBtn:(UIButton *)button{
    CQOnlineRegistrationVC *vc = [[CQOnlineRegistrationVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickSSFJSBtn:(UIButton *)button{
    CQSSFJSVC *vc = [[CQSSFJSVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickDZSDBtn:(UIButton *)button{
    CQDZSDVC *vc = [[CQDZSDVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickAJCXBtn:(UIButton *)button{
    CQAJCXVC *vc = [[CQAJCXVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickZJJHBtn:(UIButton *)button{
    CQZJJHListVC *vc = [[CQZJJHListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickGGSDBtn:(UIButton *)button{
    CQGGSDVC *vc = [[CQGGSDVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickKTGGBtn:(UIButton *)button{
    CQKTGGVC *vc = [[CQKTGGVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
