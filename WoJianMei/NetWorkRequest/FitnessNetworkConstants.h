//
//  FitnessNetworkConstants.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#ifndef WoJianMei_FitnessNetworkConstants_h
#define WoJianMei_FitnessNetworkConstants_h


#endif



// Output Format
#define FORMAT_FITNESS_JSON          1
#define FORMAT_FITNESS_PB            2   // protocol buffer


#define URL_SERVICE                 @"http://59.34.17.68:8012/service/"

#define URL_FITNESS_QUERY_VERSION    (URL_SERVICE@"iphoneVersion.txt")

#define PARA_FITNESS_APP_VERSION             @"app_version"
#define PARA_FITNESS_APP_DATA_VERSION        @"app_data_version"

#define PARA_FITNESS_APP_UPDATE_TITLE        @"app_update_title"
#define PARA_FITNESS_APP_UPDATE_CONTENT      @"app_update_content"

///用户登陆
#define SERVER_URL                          (GlobalGetServerURL())


// request parameters
#define PARA_USERID @"uid"
#define AUCODE      @"aucode"
#define AIJIANMEI   @"aijianmei"
#define PARA_AUACT  @"auact"
#define PARA_SNSID  @"snsid"






// User Errors
#define ERROR_LOGINID_EXIST             20001
#define ERROR_DEVICEID_BIND            	20002
#define ERROR_DEVICE_NOT_BIND 			20003
#define ERROR_LOGINID_DEVICE_BOTH_EXIST 20004
#define ERROR_USERID_NOT_FOUND          20005
#define ERROR_CREATE_USER				20006
#define ERROR_USER_GET_NICKNAME 		20007
#define ERROR_EMAIL_EXIST				20008
#define ERROR_EMAIL_VERIFIED			10002
#define ERROR_PASSWORD_NOT_MATCH        20010
#define ERROR_EMAIL_NOT_VALID        	20011
#define ERROR_DEVICE_TOKEN_NULL         20012
#define ERROR_USER_EMAIL_NOT_FOUND      20013






#define METHOD_REGISTERUSER @"ru"
#define METHOD @"m1"                    // set by Benson, use m1 for security
#define METHOD_TEST @"test"
#define METHOD_ONLINESTATUS @"srpt"
#define METHOD_REGISTRATION @"reg"



#define PARA_USERS @"users"
#define PARA_USERID @"uid"
#define PARA_CREATOR_USERID @"cuid"
#define PARA_LOGINID @"lid"
#define PARA_LOGINIDTYPE @"lty"
#define PARA_USERTYPE @"uty"
#define PARA_PASSWORD @"userpassword"
#define PARA_REGISTER_TYPE  @"usertype"
#define PARA_NEW_PASSWORD @"npwd"
#define PARA_EMAIL @"email"


//文章传入参数
#define PARA_LISTTYPE     @"listtype"
#define PARA_CATEGORY     @"category"
#define PARA_TYPE         @"type"
#define PARA_START        @"start"
#define PARA_OFFSET       @"offset"
#define PARA_CATEID       @"cateid"
#define PARA_UID          @"uid"


#define PARA_ARTICLE_ID                   @"id"
#define PARA_ARTICLE_CHANNLE              @"channel"
#define PARA_ARTICLE_CHANNLE_TYPE         @"channelType"













#define REGISTER_TYPE_EMAIL     1
#define REGISTER_TYPE_SINA      2
#define REGISTER_TYPE_QQ        3
#define REGISTER_TYPE_RENREN    4
#define REGISTER_TYPE_FACEBOOK  5
#define REGISTER_TYPE_TWITTER   6

#define LOGIN_USER_BY_EMAIL     100


#define PARA_DEVICETOKEN @"dto"
#define PARA_DEVICEID @"did"

#define PARA_COUNTRYCODE @"cc"
#define PARA_LANGUAGE @"lang"
#define PARA_DEVICEMODEL @"dm"



extern NSString* GlobalGetServerURL();










