//
//  TTSocketManager.m
//  ERMS
//
//  Created by 堂堂 on 18/4/10.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import "TTSocketManager.h"

@implementation TTSocketManager


+ (TTSocketManager *)instance {
    static TTSocketManager *Instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        Instance = [[TTSocketManager alloc] init];
    });
    return Instance;
}


-(void) initSocket
{
    
    @try {
        if (_socket) {
            return;
        }
        _socket = [[JFRWebSocket alloc]initWithURL:[NSURL URLWithString:@"ws://115.29.54.18:11113/patrolapp/"] protocols:@[@"chat",@"superchat"]];
        
        _socket.delegate =self;
        [_socket connect];

    }
    @catch (NSException *exception) {
        NSLog(@"initSocket%@",exception);
    }
    @finally {
        
    }
    
}

- (void)connect {
    
    if (_socket && [_socket isConnected]) {
        
        if (_timer != nil) {
            
            [_timer invalidate];//该定时器用于自动重连
            
        }
        
    }else{
        
        [self.socket connect];
        
    }
}
- (void)disconnect {
    
    [self.socket disconnect];
    
}

-(void)setTYSocketAutoConnect:(NSTimeInterval)timeInterval{
    
    if (!(_socket && [_socket isConnected])) {
        
        [self connect];
        
    }
    
    _isAutoConnect = YES;
    
    _timeInterval = timeInterval;
    
}


      
      
      






-(void)sendData:(NSString *) data  socketBack:(void (^)(NSDictionary *data)) dataBack {
    
    
    @try {
        _dataBack = dataBack;
        if (_socket && [_socket isConnected]) {
            NSError * error;
            [_socket writeString:data];
        }
    } @catch (NSException *exception) {
        NSLog(@"sendData=%@",exception);

    }
    @finally {
        
    }
    
}





-(void)websocketDidDisconnect:(nonnull JFRWebSocket*)socket error:(nullable NSError*)error{
 
    
    @try {
        [_timer invalidate];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(connect) userInfo:nil repeats:YES];
        
        [_timer fire];
        [self connect];
    }
    @catch (NSException *exception) {
        NSLog(@"websocketDidDisconnect=%@",exception);
    }
    @finally {
        
    }

}

/**
 The websocket got a text based message.
 @param socket is the current socket object.
 @param string is the text based data that has been returned.
 */
-(void)websocket:(nonnull JFRWebSocket*)socket didReceiveMessage:(nonnull NSString*)string{
    
    NSDictionary * data;
    @try {
        data = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"didReceiveMessage=%@",exception);
    }
    @finally {
        if (_socket) {
            _dataBack(data);
            
        }
    }

}

/**
 The websocket got a binary based message.
 @param socket is the current socket object.
 @param data   is the binary based data that has been returned.
 */
-(void)websocket:(nonnull JFRWebSocket*)socket didReceiveData:(nullable NSData*)data{
    NSDictionary * backData;
    @try {
        backData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"didReceiveData%@",exception);
    }
    @finally {
        if (_socket) {
            _dataBack(backData);
            
        }
    }

}

@end
