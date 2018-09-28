//
//  NSString+URL.h
//  kitchen_app_ios
//
//  Created by 堂堂 on 2018/7/29.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(URL)
/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

@end
