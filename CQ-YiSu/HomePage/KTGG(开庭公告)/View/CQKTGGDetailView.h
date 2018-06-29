//
//  CQKTGGDetailView.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/28.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINSCREENwidth   [UIScreen mainScreen].bounds.size.width
#define MAINSCREENheight  [UIScreen mainScreen].bounds.size.height
#define WINDOWFirst        [[[UIApplication sharedApplication] windows] firstObject]


@interface CQKTGGDetailView : UIView
-(instancetype)initWithAlertViewHeight:(CGFloat)height;

@property(copy,nonatomic)void (^cancelBtnClick)(UIButton*);

@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ggnrLabel;
@property (strong, nonatomic) IBOutlet UILabel *fbrxm;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end
