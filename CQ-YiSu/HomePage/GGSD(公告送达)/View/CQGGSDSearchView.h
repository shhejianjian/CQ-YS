//
//  CQGGSDSearchView.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/27.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINSCREENwidth   [UIScreen mainScreen].bounds.size.width
#define MAINSCREENheight  [UIScreen mainScreen].bounds.size.height
#define WINDOWFirst        [[[UIApplication sharedApplication] windows] firstObject]


@protocol  CQGGSDSearchViewDelegate <NSObject>

- (void)SetCourtWithBtnTag:(UIButton *)sender;
- (void)ChooseRQWithBtnTag:(UIButton *)sender;


@end


@interface CQGGSDSearchView : UIView

@property (nonatomic, weak) id <CQGGSDSearchViewDelegate> delegate;
@property(copy,nonatomic)void (^cancelBtnClick)(UIButton*);
@property(copy,nonatomic)void (^searchBtnClick)(UIButton*);
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextField *ahqcLabel;

@property (strong, nonatomic) IBOutlet UITextField *dsrmcLabel;
-(instancetype)initWithAlertViewHeight:(CGFloat)height;


- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end
