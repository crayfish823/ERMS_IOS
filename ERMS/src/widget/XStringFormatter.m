//
//  XStringFormatter.m
//  ERMS
//
//  Created by tangtang on 2018/8/21.
//  Copyright © 2018年 tangtang. All rights reserved.
//

#import "XStringFormatter.h"
@implementation XStringFormatter


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    
    return [NSString stringWithFormat:@"%@",_data[(int) value]];
}
@end
