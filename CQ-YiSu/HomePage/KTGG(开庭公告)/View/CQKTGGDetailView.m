//
//  CQKTGGDetailView.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/28.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQKTGGDetailView.h"

@implementation CQKTGGDetailView

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
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CQKTGGDetailView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.layer.cornerRadius = 5;
        self.center = CGPointMake(MAINSCREENwidth/2, MAINSCREENheight/2-80);
        self.bounds = CGRectMake(0, 0, MAINSCREENwidth-30-30, height);


    }
    return self;
}



- (void)show:(BOOL)animated{
    if (animated)
    {
        self.transform = CGAffineTransformScale(self.transform,0,0);
        __weak CQKTGGDetailView *weakSelf = self;
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
    __weak CQKTGGDetailView *weakSelf = self;
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

- (IBAction)clickCloseBnt:(id)sender {
    [self hide:YES];
    if (self.cancelBtnClick) {
        self.cancelBtnClick(sender);
    }
}



@end
