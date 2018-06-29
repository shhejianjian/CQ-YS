//
//  CQSignUpVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/6.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQSignUpVC.h"
#import "MXConstant.h"

@interface CQSignUpVC ()
@property (strong, nonatomic) IBOutlet UITextField *telPhone;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UIImageView *manImage;
@property (strong, nonatomic) IBOutlet UIImageView *womanImage;
@property (strong, nonatomic) IBOutlet UITextField *idCard;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *code;
@property (strong, nonatomic) IBOutlet UIButton *signUpBtn;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation CQSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"注册";
    [self.codeBtn.layer setMasksToBounds:YES];
    self.codeBtn.layer.cornerRadius = 10.0f;
    [self.codeBtn.layer setBorderWidth:1.0];//边框宽度
    self.codeBtn.layer.borderColor=[UIColor darkGrayColor].CGColor;
    self.signUpBtn.layer.cornerRadius = 20;


    // Do any additional setup after loading the view from its nib.
}


- (IBAction)clickManBtn:(id)sender {
    self.manImage.image = [UIImage imageNamed:@"selected"];
    self.womanImage.image = [UIImage imageNamed:@"unselected"];
}

- (IBAction)clickWomanBtn:(id)sender {
    self.womanImage.image = [UIImage imageNamed:@"selected"];
    self.manImage.image = [UIImage imageNamed:@"unselected"];
}

//注册
- (IBAction)clickSignUpBtn:(id)sender {
    
}
//发送验证码
- (IBAction)clickSendCodeBtn:(id)sender {
    
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
