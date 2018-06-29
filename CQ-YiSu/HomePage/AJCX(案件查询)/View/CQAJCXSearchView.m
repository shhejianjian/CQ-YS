//
//  CQAJCXSearchView.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/13.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQAJCXSearchView.h"

@implementation CQAJCXSearchView

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
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CQAJCXSearchView" owner:self options:nil];
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
        __weak CQAJCXSearchView *weakSelf = self;
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
    __weak CQAJCXSearchView *weakSelf = self;
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
- (IBAction)clickCancelBtn:(id)sender {
    [self hide:YES];
    if (self.cancelBtnClick) {
        self.cancelBtnClick(sender);
    }
}

- (IBAction)clickSearchBtn:(id)sender {
    [self hide:YES];
    if (self.searchBtnClick) {
        self.searchBtnClick(sender);
    }

}


@end
