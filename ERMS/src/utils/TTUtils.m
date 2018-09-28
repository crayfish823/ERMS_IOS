//
//  TTUtils.m
//  safe_app_ios
//
//  Created by 堂堂 on 17/3/7.
//  Copyright © 2017年 堂堂. All rights reserved.
//

#import "TTUtils.h"

@implementation TTUtils

//获取路径
+(void)getSavePath{
    
}
//保存照片
+(BOOL)saveImage:(UIImage *)image{
    
    return NO;
}
//保存录像
+(BOOL)saveVideo:(NSData *)data{
    return NO;
}

//判断字符串是否为空
+(BOOL)isEmpty:(NSString *)text{
    if (text != nil && ![text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}
//返回@“”
+(NSString *)checkEmpty:(NSString *)text{
    if (text != nil && ![text isEqualToString:@""]) {
        return text;
    }else{
        return @"";
    }
}
//转json字符串
+(NSString*)dictionaryToJson:(id)dic

{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:nil error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//颜色转图片
+(UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return theImage;
}
//字符串转json
+(id)stringToJSON:(NSString *)data{
    
    return [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}
//NSData转json
+(id)dataToJSON:(NSData *)data{
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

+(NSString *)getTime{
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    return curTime;
}
+(NSString *)urlEncode:(NSString *) content{
    return [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}
//图片压缩
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}

+(NSString *) dateUTCToNow:(NSString *)date oldSf:(NSString *)oldSf nowSf:(NSString *)nowSf{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:oldSf];
    
    NSDate *localDate = [dateFormatter dateFromString:date];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:localDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:localDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate * destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:localDate] ;
    
    NSDateFormatter *nowFormatter = [[NSDateFormatter alloc] init];
    
    [nowFormatter setDateFormat:nowSf];
    
    return [nowFormatter stringFromDate:destinationDateNow];
    
}
+(NSString *) dateNowToUTC:(NSString *)date oldSf:(NSString *)oldSf nowSf:(NSString *)nowSf{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:oldSf];
    
    NSDate *localDate = [dateFormatter dateFromString:date];
    
    
    
    NSDateFormatter *utcdateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    
    [utcdateFormatter setTimeZone:timeZone];
    
    [utcdateFormatter setDateFormat:nowSf];
    
    NSString *dateString = [utcdateFormatter stringFromDate:localDate];

    
    return dateString;
}

+(NSString *)getYYYYMMDD{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    return  [df stringFromDate:[NSDate new]];
}
@end
