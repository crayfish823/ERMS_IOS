//
//  Const.h
//  JJWL_IOS
//
//  Created by 堂堂 on 18/3/22.
//  Copyright © 2018年 堂堂. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVICE_URL @"http://106.12.22.139:9090/CACWebAPI/api/"

#define HTTP_LOGIN @"GetToken"
#define HTTP_DOWNLOAD @"Document/DownLoadSingleFile"
#define HTTP_PROJECTS @"ProjectInfo/GetEntitys"
#define HTTP_HX @"ProjectIOList/GetPageProjectIOListViewlx"
#define HTTP_HXZ @"TagGroupInfo/GetPageMonthHistoryTagCodeRecView"
#define HTTP_DOCUMENT @"Document/GetOperationManualView"
//设备
#define HTTP_DEVICE @"ProjectInfo/GetCACIolistByProInfoId"


#define HTTP_WB @"MachineMaintenanceRec/Insert"

#define HTTP_BJ @"LocalAlarmInfo/GetAlarmRecordPage"
#define HTTP_MESSAGE @"Msg/GetMsgPageEntitys"


#define HTTP_MAIN2_SEARCH1 @"HistoryTagCodeRec/GetPageHistoryTagCodeRecTreadsView"
#define HTTP_MAIN2_SEARCH2 @"HistoryTagCodeRec/GetPageEnergyDayView"
#define HTTP_MAIN2_SEARCH3 @"HistoryTagCodeRec/GetPageAITagView"
#define HTTP_MAIN2_SEARCH4 @"HistoryTagCodeRec/GetPageDI0TagView"

#define HTTP_MAIN2_ADD @"ProjectIOList/GetInfoByProNameAndTagTypeName"


#define HTTP_MAIN4 @"/appi/sensor"
#define HTTP_DEIVCES @"/appi/user_boxes"
#define HTTP_MAP_ALL @"/appi/map_boxes"



#define LOGIN_NAME @"login_name"
#define LOGIN_PWD @"login_pwd"
#define LOGIN_TOKEN @"login_token"
#define LOGIN_ROLES @"login_riles"

#define LOGIN_USER_NAME @"login_user_name"
#define DEVICE_ID @"device_id"
#define DEVICE_NAME @"device_name"
#define DATE_START @"date_start"
#define DATE_END @"date_end"
#define URL @"url"
#define MESSAGE @"message"
#define INDEX @"index"
@interface Const : NSObject

@end
