//
//  UserDefaultUtil.m
//  HaierGMS_APP
//
//  Created by 堂堂 on 16/9/19.
//  Copyright © 2016年 堂堂. All rights reserved.
//

#import "UserDefaultUtil.h"



@implementation UserDefaultUtil


+(void) saveData:(NSString *)value key:(NSString *) key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:value forKey:key];
}
+(NSString *) getData:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    return [user objectForKey:key];
}
+(NSString *) getUserId{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    return [user objectForKey:USER_ID];
}
@end
