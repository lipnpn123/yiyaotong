
//
//  FDURLConnection.h
//  ifudi
//
//  Created by ncg ncg-2 on 11-7-7.
//  Copyright 2011 ngc. All rights reserved.
//

//超时链接的时间限制秒数
#define NETWORK_TIMEOUT 20	 //创建链接超时
#define NETWORK_POSTDATA_TIMEOUT 60	 //创建数据传输超时


//#define HEAD_URL_STR        @"http://58.17.31.108:8004/api"			//主机名
//#define HEAD_URL_STR  @"http://202.75.213.134:8012/api"
#define HEAD_URL_STR  @"http://192.168.0.31:8080"

#define HEADIMAGE_URL_STR				@"http://192.168.0.31:8080"	 				//图片主机名
#define CreateImagePath(obj) [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",HEADIMAGE_URL_STR,obj]]

//1.1提交注册信息
#define XTaskRegisterPath @"/xtask/user/register"

//注册成功添加用户详细信息 请求 PUT:/xtask/user/update
#define XTaskRegisterPath2 @"/xtask/user/update"

//1.2 用户登录
#define XTaskLoginPath2 @"/xtask/user/login"

//1.3 用户信息
#define XTaskGetUserInfo @"/xtask/user/get/"


 
//1.4用户项目
#define XTaskProjectQuery       @"/xtask/project/query"

//1.5用户分组
#define XtaskGroupList @"/xtask/lists/query/"

//1.6用户联系人
#define XtasklinkmanList @"/xtask/user/linkman/"

//1.7添加用户联系人
#define XtasklinkAddmanList     @"/xtask/user/linkman/"

//1.8 删除联系人
#define XtasklinkDeletemanList  @"/xtask/user/linkman/"

//1.9添加用户分组
#define XtaskaddGroupList       @"/xtask/lists/add"

//1.10删除用户分组
#define XtaskGroupDeleteList    @"/xtask/user/lists/"

//1.11修改用户信息
#define XtaskGroupDeleteList    @"/xtask/user/lists/"


//2.1 新建任务
#define XtaskNewtaskPath        @"/xtask/newtask"

//2.2 查看任务
#define XtaskTaskDetailPath  @"/xtask/task/"

//2.4 添加评论
#define XtaskAddCommentPath     @"/xtask/task/commentnew"

//2.18 任务检索列表
#define XtasksearchTaskPath     @"/xtask/search"

#define XtaskMoveTaskPath       @"/xtask/task/"
//2.20任务分配
#define XtaskdelegateTaskPath   @"/xtask/task/delegate/"
//2.22 任务拒绝
#define XtaskRejectTaskPath     @"/xtask/task/reject"

//2.5 修改任务
#define XtaskChangeTaskPath     @"/xtask/task/"

//2.6 完成任务
#define XtaskResolveTaskPath     @"/xtask/task/resolve/"


#define XtaskClaimTaskPath      @"/xtask/task/claim/"
 
//2.18 任务检索列表
#define  XtaskSearchPath             @"/xtask/search"

//用户任务
#define XTaskLists     @"/xtask/task/lists"


//5.2 用户动态
#define XTaskActivityDongPath @"/xtask/activity/"
