//
//  CQOnlineRegistrationCell.m
//  CQ-YiSu
//
//  Created by 金鑫 on 2018/6/5.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "CQOnlineRegistrationCell.h"

@interface CQOnlineRegistrationCell ()
@property (strong, nonatomic) IBOutlet UILabel *jrzydhLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *ajlbmcLabel;
@property (strong, nonatomic) IBOutlet UILabel *clztmcLabel;

@property (strong, nonatomic) IBOutlet UIButton *tjBtn;
@property (strong, nonatomic) IBOutlet UIButton *xgBtn;
@property (strong, nonatomic) IBOutlet UIButton *scBtn;


@end

@implementation CQOnlineRegistrationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tjBtn.layer setBorderWidth:1.0];
    self.tjBtn.layer.borderColor=[UIColor colorWithRed:239/255.0 green:104/255.0 blue:25/255.0 alpha:1].CGColor;
    self.tjBtn.layer.cornerRadius = 5;

    [self.xgBtn.layer setBorderWidth:1.0];
    self.xgBtn.layer.borderColor=[UIColor colorWithRed:239/255.0 green:104/255.0 blue:25/255.0 alpha:1].CGColor;
    self.xgBtn.layer.cornerRadius = 5;
    
    [self.scBtn.layer setBorderWidth:1.0];
    self.scBtn.layer.borderColor=[UIColor colorWithRed:239/255.0 green:104/255.0 blue:25/255.0 alpha:1].CGColor;
    self.scBtn.layer.cornerRadius = 5;

    // Initialization code
}

-(void)setWslaModel:(CQOnlineRegistrationModel *)wslaModel{
    _wslaModel = wslaModel;
    self.jrzydhLabel.text = wslaModel.jrzydh;
    self.timeLabel.text = wslaModel.sysTime;
    self.fymcLabel.text = wslaModel.fymc;
    self.ajlbmcLabel.text = wslaModel.ajlbmc;
    self.clztmcLabel.text = wslaModel.clztmc;

}



- (IBAction)clickDeleteBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickDeleteBtn:)]) {
        [self.delegate clickDeleteBtn:sender.tag];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
