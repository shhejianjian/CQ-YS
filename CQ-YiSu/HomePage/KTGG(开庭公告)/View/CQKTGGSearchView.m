//
//  CQKTGGSearchView.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/28.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQKTGGSearchView.h"

@implementation CQKTGGSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithAlertViewHeight:(CGFloat)height
{
    self=[super init];
    if (self) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CQKTGGSearchView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.center = CGPointMake(MAINSCREENwidth - 150, MAINSCREENheight/2);
        self.bounds = CGRectMake(0, 0, 300, MAINSCREENheight);
    }
    return self;
}

- (void)show:(BOOL)animated{
    if (animated)
    {
        self.transform = CGAffineTransformScale(self.transform,0,0);
        __weak CQKTGGSearchView *weakSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)hide:(BOOL)animated{
    NSLog(@"hide");
    __weak CQKTGGSearchView *weakSelf = self;
    [UIView animateWithDuration:animated ?0.3: 0 animations:^{
        weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1,1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration: animated ?0.3: 0 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,0.2,0.2);
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
        }];
    }];
}
- (IBAction)clickSearchBtn:(id)sender {
    [self hide:YES];
    if (self.searchBtnClick) {
        self.searchBtnClick(sender);
    }
}

- (IBAction)clickCancelBtn:(id)sender {
    [self hide:YES];
    if (self.cancelBtnClick) {
        self.cancelBtnClick(sender);
    }
    
}
- (IBAction)clickGGRQBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ChooseRQWithBtnTag:)]) {
        [self.delegate ChooseRQWithBtnTag:sender];
    }
    
}
- (IBAction)clickXZFYBtn:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SetCourtWithBtnTag:)]) {
        [self.delegate SetCourtWithBtnTag:sender];
    }
}


@end
