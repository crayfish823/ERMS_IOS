//
//  UserDefaultUtil.h
//  HaierGMS_APP
//
//  Created by 堂堂 on 16/9/19.
//  Copyright © 2016年 堂堂. All rights reserved.
//

#import <Foundation/Foundation.h>
#define USER_PHONE @"user_phone"
#define USER_PWD @"user_pwd"
#define USER_ID @"user_id"
#define USER_STATUS @"user_status"
#define USER_NAME @"user_name"
#define USER_CARTEAM @"user_car_team"
#define USER_PHOTO @"user_photo"
#define USER_FIRST @"user_first"

#define PEOPLE_LAB1 @"people_lab1"
#define PEOPLE_LAB2 @"people_lab2"
#define PEOPLE_LAB3 @"people_lab3"
@interface UserDefaultUtil : NSObject

+(void) saveData:(NSString *)value key:(NSString *) key;
+(NSString *) getData:(NSString *)key;
+(NSString *) getUserId;
@end
