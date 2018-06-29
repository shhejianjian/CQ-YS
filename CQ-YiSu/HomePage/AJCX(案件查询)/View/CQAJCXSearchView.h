//
//  CQAJCXSearchView.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINSCREENwidth   [UIScreen mainScreen].bounds.size.width
#define MAINSCREENheight  [UIScreen mainScreen].bounds.size.height
#define WINDOWFirst        [[[UIApplication sharedApplication] windows] firstObject]


@interface CQAJCXSearchView : UIView

@property(copy,nonatomic)void (^cancelBtnClick)(UIButton*);
@property(copy,nonatomic)void (^searchBtnClick)(UIButton*);

-(instancetype)initWithAlertViewHeight:(CGFloat)height;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;


@property (strong, nonatomic) IBOutlet UITextField *yuangaoTextField;

@property (strong, nonatomic) IBOutlet UITextField *beigaoTextField;

@end
