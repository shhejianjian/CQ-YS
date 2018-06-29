//
//  HJConst.h
//  SxLsPtProhect
//
//  Created by 何键键 on 17/10/12.
//  Copyright © 2017年 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HGGrayColor HGColor(175, 175, 175)
#define HGBlueColor HGColor(80, 189, 250)
#define HGGlobalColor HGColor(237, 237, 237)



//根目录地址
extern NSString *const BaseUrl;
extern NSString *const fileUrl;

extern NSString *const appid;
extern NSString *const uuid;
extern NSString *const md5key;
extern NSString *const version;



extern NSString *const wsla_login;//登录接口

extern NSString *const wsla_list;//网上立案列表
extern NSString *const wsla_delete_jbxx;//网上立案列表删除

extern NSString *const wsla_ms;

extern NSString *const select_fy;//法院列表

extern NSString *const dzsd_yw;//电子送达列表

extern NSString *const wdaj_list;//我的案件列表

extern NSString *const wsla_clsc_list;//材料上传列表

extern NSString *const tj_wsla_ajxx;//页面统计网上立案

extern NSString *const zjjh_countTj;//页面统计证据交换

extern NSString *const dzsd_file;//电子送达文件PDF

extern NSString *const zjjh_list;//证据交换列表

extern NSString *const wsla_smrz_list;//实名验证列表

extern NSString *const ggsd_list;//公告送达列表

extern NSString *const ktgg_list;//开庭公告列表


