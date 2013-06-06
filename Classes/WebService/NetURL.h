
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
#define HEAD_URL_STR  @"http://www.yiyaotong.cn/m/m.aspx"

#define HEADIMAGE_URL_STR				@"http://www.yiyaotong.cn/admin/AdminPage/"	 				//图片主机名
#define CreateImagePath(obj) [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",HEADIMAGE_URL_STR,obj]]

 