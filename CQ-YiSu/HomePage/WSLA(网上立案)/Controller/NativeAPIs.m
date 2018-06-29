//
//  NativeAPIs.m
//  CQ-YiSu
//
//  Created by 何键键 on 2018/6/25.
//  Copyright © 2018年 金鑫. All rights reserved.
//

#import "NativeAPIs.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "MXConstant.h"
#import <CommonCrypto/CommonDigest.h>


@interface NativeAPIs ()

@property (nonatomic, copy) NSString *bcAjbs;
@property (nonatomic, copy) NSString *bcAjlb;
@property (nonatomic, copy) NSString *bcSpcx;

@end



@implementation NativeAPIs
#pragma mark - NativeApisProtocol

//static NSString *bcAjbs;
//static NSString *bcAjlb;
//static NSString *bcSpcx;

- (NSString *)getajbs {
    NSLog(@"11111111111111");
    NSString *ajbsStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"bcAjbs"];
    NSLog(@"bcajbs:%@",ajbsStr);
    if([ajbsStr isEqualToString:@"null"]){
        return @"";
    } else {
        return ajbsStr;
    }
}

- (NSString *)getajlb {
     NSLog(@"22222222222222");
    NSString *ajlbStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"bcAjlb"];
    if([ajlbStr isEqualToString:@"null"]){
        return @"";
    } else {
        return ajlbStr;
    }
}

- (NSString *)getspcx {
     NSLog(@"333333333333");
    NSString *spcxStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"bcSpcx"];
    if([spcxStr isEqualToString:@"null"]){
        return @"";
    } else {
        return spcxStr;
    }
}

- (void)setajbs:(NSString *)ajbs {
     NSLog(@"44444444444444");
//    self.bcAjbs = @"11111111ajbs";
    NSLog(@"setajbs::%@",ajbs);
    if(ajbs){
        [[NSUserDefaults standardUserDefaults] setObject:ajbs forKey:@"bcAjbs"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"bcAjbs"];
    }
//    self.bcAjbs = ajbs;
}

- (void)setajlb:(NSString *)ajlb {
     NSLog(@"55555555555555");
    if(ajlb){
        [[NSUserDefaults standardUserDefaults] setObject:ajlb forKey:@"bcAjlb"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"bcAjlb"];
    }

//    self.bcAjlb = @"222222222ajlb";
//    self.bcAjlb = ajlb;

}

- (void)setspcx:(NSString *)spcx {
     NSLog(@"66666666666666");
    if(spcx){
        [[NSUserDefaults standardUserDefaults] setObject:spcx forKey:@"bcSpcx"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"bcSpcx"];
    }
//    self.bcSpcx = @"333333333spcx";
//    self.bcSpcx = spcx;

}

- (NSString *)getparams:(NSString *)bam:(NSString *)json{
    NSLog(@"%@",json);
     NSLog(@"777777777777777");
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithDictionary:[self dictionaryWithJsonString:json]];
    NSDictionary *forJsonDic = [NSDictionary dictionaryWithDictionary:jsonDic];
    for (id object in forJsonDic) {
        if([jsonDic[object] isKindOfClass:[NSString class]]){
             NSLog(@"string::%@",jsonDic[object]);
        } else {
            jsonDic[object] = [self dictionaryToJson:jsonDic[object]];
            NSLog(@"object::%@",jsonDic[object]);
        }
    }
    
    NSString *randCodeStr = [self get8bitString];//随机字符串
    NSString *timeStr = [self getTimeNow];
    NSString *thirdFlowStr = [self get32bitString];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    NSString *pastMD5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@",uuid,bam,thirdFlowStr,appid,randCodeStr,md5key];
    NSString *newMD5Str = [self md5HexDigest:pastMD5Str];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    paramsDic[@"thirdFlow"] = thirdFlowStr;
    paramsDic[@"busiCode"] = bam;
    paramsDic[@"loginName"] = @"";
    paramsDic[@"appId"] = appid;
    paramsDic[@"secM"] = newMD5Str;
    paramsDic[@"randCode"] = randCodeStr;
    paramsDic[@"time"] = timeStr;
    paramsDic[@"seqM"] = @"";
    paramsDic[@"uuid"] = uuid;
    paramsDic[@"version"] = version;
    paramsDic[@"ticket"] = ticket;
    paramsDic[@"parameters"] = jsonDic;
    NSString *paramsDicStr = [self dictionaryToJson:paramsDic];
    NSLog(@"urlStr:::%@",paramsDicStr);
    return paramsDicStr;
}


- (void)paramToApp:(NSString *)json:(NSString *)code{
    NSLog(@"%@--%@",json,code);
     NSLog(@"888888888888888");
    if(code){
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"codeNotification" object:code];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"codeNotification" object:code userInfo:[self dictionaryWithJsonString:json]];
    }
//    NSString *str = @"111";
//    return str;
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//获取系统当前时间，精确到秒
- (NSString *)getTimeNow{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    return timeNow;
}

- (NSString *)get32bitString{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('a' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

- (NSString *)get8bitString{
    
    //自动生成8位随机密码
    NSTimeInterval random=[NSDate timeIntervalSinceReferenceDate];
    NSString *randomString = [NSString stringWithFormat:@"%.6f",random];
    NSString *randompassword = [[randomString componentsSeparatedByString:@"."]objectAtIndex:1];
    
    return randompassword;
    
}

- (NSString *)md5HexDigest:(NSString*)input
{
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
