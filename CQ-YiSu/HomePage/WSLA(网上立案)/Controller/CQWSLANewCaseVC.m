//
//  CQWSLANewCaseVC.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/12.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQWSLANewCaseVC.h"
#import "MXConstant.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NativeAPIs.h"


@interface CQWSLANewCaseVC ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) JSContext *jsContext;

@property (strong, nonatomic) MXBarButtonItem *firstLeftItem;
@property (strong, nonatomic) MXBarButtonItem *secondLeftItem;
@property (strong, nonatomic) MXBarButtonItem *rightItem;

@end

@implementation CQWSLANewCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItem];
    //加载网页
    [self loadWebView];
    // 自动对页面进行缩放以适应屏幕
    self.webView.scalesPageToFit = YES;
    // 需要在代理方法中与js进行交互
    self.webView.delegate = self;
    if(!self.ajbsStr){
        self.ajbsStr = @"";
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(codeNotification:) name:@"codeNotification" object:nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)codeNotification:(NSNotification *)notification{
    //使用object处理消息
    NSString *info = [notification object];
    
    NSDictionary  *dic = [notification userInfo];
    NSLog(@"接收 object传递的消息：%@--%@",info,dic[@"buttonnr"]);
    self.mxNavigationItem.title = dic[@"title"];
    if([dic[@"button1"] isEqualToString:@"true"]){
        self.firstLeftItem.hidden = NO;
    } else {
        self.firstLeftItem.hidden = YES;
    }
    if([dic[@"button2"] isEqualToString:@"true"]){
        self.secondLeftItem.hidden = NO;
    } else {
        self.secondLeftItem.hidden = YES;
    }
    if([dic[@"button3"] isEqualToString:@"true"]){
        self.rightItem.hidden = NO;
    } else {
        self.rightItem.hidden = YES;
    }
    [self.rightItem setTitle:dic[@"buttonnr"] forState:UIControlStateNormal];
    if([info isEqualToString:@"1000"]){
        
    } else if([info isEqualToString:@"1001"]){
        
    } else if([info isEqualToString:@"1002"]){
        
    } else if([info isEqualToString:@"3001"]){
        
    } else if([info isEqualToString:@"3002"]){
        
    } else if([info isEqualToString:@"3003"]){
        
    } else if([info isEqualToString:@"999"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}



//加载网页
-(void)loadWebView{
    
    NSLog(@"loadWebView");
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"app/1.html" ofType:nil];
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:filePath]]];
    NSURL *url = [[NSURL alloc]init];
    NSLog(@"ajbs:%@",self.ajbsStr);
    if(!self.ajbsStr){
        url = [NSURL URLWithString:@"http://www.cqfygzfw.com/dzfy-web-app/page/wsla/message.jsp"];
    } else {
        url = [NSURL URLWithString:@"http://www.cqfygzfw.com/dzfy-web-app/page/wsla/mainjbxx.jsp"];
        
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    //    [self setNaviApi];
    
}

- (void)setNavigationItem{
    self.firstLeftItem = [[MXBarButtonItem alloc]initWIthImage:@"top_返回" handler:^{
        NSLog(@"123goback");
        if (self.webView.canGoBack == YES) {
            [self.webView goBack];
            //            [self.webView stringByEvaluatingJavaScriptFromString:@"$App.button('3001')"];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    self.secondLeftItem = [[MXBarButtonItem alloc]initWIthImage:@"top_返回" handler:^{
        [self.webView stringByEvaluatingJavaScriptFromString:@"$App.button('3002')"];
    }];
    self.rightItem = [[MXBarButtonItem alloc]initWithTitle:@"保存" handler:^{
        NSLog(@"123456");
        [self.webView stringByEvaluatingJavaScriptFromString:@"$App.button('3003')"];
    }];
    self.mxNavigationItem.rightItem = _rightItem;
    self.mxNavigationItem.leftItems = @[_firstLeftItem,_secondLeftItem];
}

-(void)setNaviApi:(UIWebView *)webView{
    NSLog(@"1234567890");
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NativeAPIs *nativeAPIs = [[NativeAPIs alloc] init];
    // 将NativeAPIs模型注入JS
    self.jsContext[@"NativeApis"] = nativeAPIs;
    nativeAPIs.jsContext = self.jsContext;
    nativeAPIs.vc = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        [JSContext currentContext].exception = exception;
        NSLog(@"exception:%@",exception);
    };
    [webView stringByEvaluatingJavaScriptFromString:@"setajbs()"];
    [webView stringByEvaluatingJavaScriptFromString:@"getfzcs()"];
    [webView stringByEvaluatingJavaScriptFromString:@"getjh()"];
    [webView stringByEvaluatingJavaScriptFromString:@"getajbs()"];
    [webView stringByEvaluatingJavaScriptFromString:@"getspcx()"];
    [webView stringByEvaluatingJavaScriptFromString:@"setspcx()"];
    [webView stringByEvaluatingJavaScriptFromString:@"getajlb()"];
    [webView stringByEvaluatingJavaScriptFromString:@"setajlb()"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"$App.reload()"];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"startWebView");
    [self setNaviApi:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finishWebView");
    //    __weak typeof(self) weakSealf = self;
    //    self.jsContext[@"getjh"] = ^{
    //        JSValue *callback = weakSealf.jsContext[@"callback"];
    //        [callback callWithArguments:@[@"1001"]];
    //    };
    [self setNaviApi:webView];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartWebView");
    //    [self setNaviApi:webView];
    return YES;
    
}

@end
