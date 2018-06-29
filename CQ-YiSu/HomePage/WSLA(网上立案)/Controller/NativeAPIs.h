//
//  NativeAPIs.h
//  CQ-YiSu
//
//  Created by 何键键 on 2018/6/25.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
// 声明与js交互的协议
@protocol NativeApisProtocol <JSExport> // 遵守JSExport协议

// 调用获取ajbs
- (NSString *)getajbs;
// 设置ajbs到app
- (void)setajbs:(NSString *)ajbs;

// 调用获取ajlb
- (NSString *)getajlb;
// 设置ajlb到app
- (void)setajlb:(NSString *)ajlb;

// 调用获取spcx
- (NSString *)getspcx;
// 设置spcx到app
- (void)setspcx:(NSString *)spcx;

//向app出入数据
- (NSString *)getparams:(NSString *)bam:(NSString *)json;
- (void)paramToApp:(NSString *)json:(NSString *)code;


@end

@interface NativeAPIs : NSObject<NativeApisProtocol>
@property(weak, nonatomic) JSContext *jsContext;
@property(weak, nonatomic) UIViewController *vc;

@end
