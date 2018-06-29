//
//  CQUserInfoVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/7.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQUserInfoVC.h"
#import "MXConstant.h"
#import "BRPickerView.h"

@interface CQUserInfoVC ()

@property (strong, nonatomic) IBOutlet UITextField *telPhone;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *idCard;
@property (strong, nonatomic) IBOutlet UITextField *address;

@end

@implementation CQUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"修改用户信息";

    //隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    //保存用户信息
    self.mxNavigationItem.rightItem = [[MXBarButtonItem alloc] initWithTitle:@"保存" handler:^{
        NSLog(@"...");
    }];

    // Do any additional setup after loading the view from its nib.
}

//隐藏键盘
-(void)viewTapped:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

//选择性别
- (IBAction)chooseGender:(id)sender {
    NSArray *dataSource = @[@"男", @"女"];
    __weak typeof(self) weakSelf = self;
    [BRStringPickerView showStringPickerWithTitle:@"性别" dataSource:dataSource defaultSelValue:weakSelf.gender.text resultBlock:^(id selectValue) {
        weakSelf.gender.text = selectValue;
        weakSelf.gender.textColor = [UIColor blackColor];
    }];
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
