//
//  CQSSZNVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQSSZNVC.h"
#import "MXConstant.h"

@interface CQSSZNVC ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CQSSZNVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"诉讼指南";
    
    [self loadWebView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)loadWebView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"app/11sszn.html" ofType:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:filePath]]];
    
    self.mxNavigationItem.leftItem = [[MXBarButtonItem alloc] initWIthImage:@"top_返回" handler:^{
        if (self.webView.canGoBack == YES) {
            [self.webView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
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
