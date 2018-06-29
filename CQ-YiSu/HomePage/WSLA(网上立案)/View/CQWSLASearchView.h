//
//  CQWSLASearchView.h
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/11.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAINSCREENwidth   [UIScreen mainScreen].bounds.size.width
#define MAINSCREENheight  [UIScreen mainScreen].bounds.size.height
#define WINDOWFirst        [[[UIApplication sharedApplication] windows] firstObject]

@protocol  CQWSLASearchViewDelegate <NSObject>

- (void)SetCourtWithBtnTag:(UIButton *)sender;

@end



@interface CQWSLASearchView : UIView

@property(copy,nonatomic)void (^cancelBtnClick)(UIButton*);
@property(copy,nonatomic)void (^searchBtnClick)(UIButton*);
@property (strong, nonatomic) IBOutlet UIButton *dtjBtn;
@property (strong, nonatomic) IBOutlet UIButton *dscBtn;
@property (strong, nonatomic) IBOutlet UIButton *sctgBtn;
@property (strong, nonatomic) IBOutlet UIButton *ysaBtn;
@property (strong, nonatomic) IBOutlet UIButton *ylaBtn;
@property (strong, nonatomic) IBOutlet UIButton *yjaBtn;
@property (strong, nonatomic) IBOutlet UIButton *scbtgBtn;
@property (strong, nonatomic) IBOutlet UITextField *dsrTextField;

-(instancetype)initWithAlertViewHeight:(CGFloat)height;

@property (nonatomic, weak) id <CQWSLASearchViewDelegate> delegate;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
@property (strong, nonatomic) IBOutlet UIButton *fyBtn;
@property (strong, nonatomic) NSString *clzt;
@end
