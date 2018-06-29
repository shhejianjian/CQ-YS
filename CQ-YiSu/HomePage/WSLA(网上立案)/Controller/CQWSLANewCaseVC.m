//
//  CQWSLANewCaseVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/12.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQWSLANewCaseVC.h"
#import "MXConstant.h"

@interface CQWSLANewCaseVC ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CQWSLANewCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
    //加载网页
    [self loadWebView];
    // 自动对页面进行缩放以适应屏幕
    self.webView.scalesPageToFit = YES;
    // 需要在代理方法中与js进行交互
    self.webView.delegate = self;


    
    // Do any additional setup after loading the view from its nib.
}

//加载网页
-(void)loadWebView{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"app/1.html" ofType:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:filePath]]];
    
    self.mxNavigationItem.leftItem = [[MXBarButtonItem alloc] initWIthImage:@"top_返回" handler:^{
        if (self.webView.canGoBack == YES) {
            [self.webView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 获取当前网页的标题
    NSString *titleStr = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.mxNavigationItem.title = titleStr;

    // 还可以直接调用js定义的方法
    // 比如getShareUrl()为js端定义好的方法，返回值为分享的url
    // 我们就可以通过调用这个方法在returnStr中拿到js返回的分享地址
    NSString *returnStr = [webView stringByEvaluatingJavaScriptFromString:@"getajlb"];
    NSLog(@"aj::%@",returnStr);
    
//    // 还可以为js端提供完整的原生方法供其调用（记得导入#import <JavaScriptCore/JavaScriptCore.h>）
//    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    // 可以定义供js调用的方法, testMethod为js调用的方法名
//    context[@"testMethod"] = ^() {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"js调用方法" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alert show];
//        });
//    };
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
