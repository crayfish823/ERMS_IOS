//
//  TTSocketManager.h
//  ERMS
//
//  Created by 堂堂 on 18/4/10.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFRWebSocket.h"
@interface TTSocketManager : NSObject<JFRWebSocketDelegate>

@property (strong,nonatomic)JFRWebSocket *socket;
@property(strong) void (^dataBack) (NSDictionary *)  ;
@property NSTimer *timer;
@property NSTimeInterval timeInterval;
@property bool isAutoConnect;
+ (TTSocketManager *)instance;
-(void) initSocket;
-(void)sendData:(NSString *) data  socketBack:(void (^)(NSDictionary *data)) dataBack ;
@end
