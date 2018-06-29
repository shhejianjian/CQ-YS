//
//  CQSMRZVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/20.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQSMRZVC.h"
#import "MXConstant.h"
#import "ZZYPhotoHelper.h"


@interface CQSMRZVC ()
@property (strong, nonatomic) IBOutlet UILabel *mcLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sczImage;
@property (strong, nonatomic) IBOutlet UIImageView *zmzImage;
@property (strong, nonatomic) IBOutlet UIImageView *bmzImage;
@property (nonatomic, copy) NSString *tempFilename;
@property (strong, nonatomic) IBOutlet UIButton *sczBtn;
@property (strong, nonatomic) IBOutlet UIButton *zmcBtn;
@property (strong, nonatomic) IBOutlet UIButton *bmzBtn;


@end

@implementation CQSMRZVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sczBtn.layer.cornerRadius = 5;
    self.zmcBtn.layer.cornerRadius = 5;
    self.bmzBtn.layer.cornerRadius = 5;

    self.mxNavigationItem.title = @"实名认证";
    [self loadList];
    // Do any additional setup after loading the view from its nib.
}


-(void)loadList{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    [GYHttpTool post:wsla_smrz_list ticket:nil params:params success:^(id json) {
        NSLog(@"json:%@",json);
    } failure:^(NSError *error) {
    }];
}

- (IBAction)clickSCZBtn:(id)sender {

}

- (IBAction)clickZMZBtn:(id)sender {
    
}

- (IBAction)clickBMZBtn:(id)sender {
    
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
