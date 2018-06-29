//
//  CQKTGGSearchView.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/28.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINSCREENwidth   [UIScreen mainScreen].bounds.size.width
#define MAINSCREENheight  [UIScreen mainScreen].bounds.size.height
#define WINDOWFirst        [[[UIApplication sharedApplication] windows] firstObject]


@protocol  CQKTGGSearchViewDelegate <NSObject>

- (void)SetCourtWithBtnTag:(UIButton *)sender;
- (void)ChooseRQWithBtnTag:(UIButton *)sender;


@end


@interface CQKTGGSearchView : UIView

@property (nonatomic, weak) id <CQKTGGSearchViewDelegate> delegate;
@property(copy,nonatomic)void (^cancelBtnClick)(UIButton*);
@property(copy,nonatomic)void (^searchBtnClick)(UIButton*);
-(instancetype)initWithAlertViewHeight:(CGFloat)height;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end
