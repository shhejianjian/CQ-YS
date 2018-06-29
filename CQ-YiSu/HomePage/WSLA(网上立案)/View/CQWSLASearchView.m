//
//  CQWSLASearchView.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/11.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQWSLASearchView.h"

@implementation CQWSLASearchView

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
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CQWSLASearchView" owner:self options:nil];
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
        __weak CQWSLASearchView *weakSelf = self;
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
    __weak CQWSLASearchView *weakSelf = self;
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

- (IBAction)selectFY:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(SetCourtWithBtnTag:)]) {
        [self.delegate SetCourtWithBtnTag:sender];
    }
    
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

- (IBAction)clickDTJBtn:(id)sender {
    self.clzt = @"0";
    [self.dtjBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [self.dscBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.sctgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ysaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ylaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.yjaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.scbtgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
}

- (IBAction)clickDSCBtn:(id)sender {
    self.clzt = @"1";
    [self.dscBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [self.dtjBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.sctgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ysaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ylaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.yjaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.scbtgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
}

- (IBAction)clickSCTGBtn:(id)sender {
    self.clzt = @"2";
    [self.sctgBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [self.dscBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.dtjBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ysaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ylaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.yjaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.scbtgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
}

- (IBAction)clickYSABtn:(id)sender {
    self.clzt = @"3";
    [self.ysaBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [self.dscBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.dtjBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.sctgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ylaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.yjaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.scbtgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
}

- (IBAction)clickYLABtn:(id)sender {
    self.clzt = @"4";
    [self.ylaBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [self.dscBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.dtjBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.sctgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ysaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.yjaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.scbtgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
}

- (IBAction)clickYJABtn:(id)sender {
    self.clzt = @"5";
    [self.yjaBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [self.dscBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.dtjBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.sctgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ysaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ylaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.scbtgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
}

- (IBAction)clickSCBTGBtn:(id)sender {
    self.clzt = @"6";
    [self.scbtgBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    [self.dscBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.dtjBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.sctgBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ysaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.ylaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
    [self.yjaBtn setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
}

@end
