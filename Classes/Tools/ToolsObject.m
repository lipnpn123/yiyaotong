//
//  ToolsObject.m
//  JC
//
//  Created by Tim on 11-2-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToolsObject.h"


@implementation ToolsObject

#pragma mark -
#pragma mark 检测网络连接状况
/*
 此函数用于判断网络连接状况
 连接正常返回YES
 无连接返回NO
 
 需要注意的是：函数为底层调用，只能判断手机是否接入网络，不能判断其他网络问题（如服务器响应与否）
 */
+ (BOOL) connectedToNetwork
{
	//创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	//获得连接的标志
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	//如果不能获取连接标志，则不能连接网络，直接返回
	if (!didRetrieveFlags)
	{
		return NO;
	}
	//根据获得的连接标志进行判断
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL isWWAN = flags & kSCNetworkReachabilityFlagsIsWWAN;
	return (isReachable && (!needsConnection || isWWAN)) ? YES : NO;
}

#pragma mark -
#pragma mark 错误提示
/*
 此函数为错误提示框，用于各种错误提示消息
 */

+(void)ErrorAlert:(NSString*)errorMsg withTitle:(NSString*)titleMsg;
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleMsg 
													message:errorMsg
												   delegate:nil
										  cancelButtonTitle:@"确定"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}



#pragma mark -
#pragma mark 获取随机字符串
/*
 此函数用于获取一个随机字符串
 1.用于webservice发送时的分隔符
 2.用于全局常量中标识链接的字符串头
 */
+ (NSString *)generateBoundaryString
{
    CFUUIDRef       uuid;
    CFStringRef     uuidStr;
    NSString *      result;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSString stringWithFormat:@"Boundary-%@", uuidStr];
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}


#pragma mark -
#pragma mark 时间转换函数模块
/*
 此函数模块用于转换时间戳为格式化时间
 
 输入参数：1970自今的秒数时间戳
 输出参数：格式化的时间字符串
 错误处理：如果传入时间戳为空，返回空字符串
 */


//转换时间格式，精确到秒数
+ (NSString*)convertTimeStyleToSecond:(NSString*)timeStr;
{			
	if (timeStr) {
		NSDate *date=[NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
		NSString* timeString = [formatter stringFromDate:date];
		[formatter release];
		return timeString;
	}
	else {
		NSLog(@"传入时间戳为空");
		return @"";
	}
	
}


//转换时间格式，精确到分钟
+ (NSString*)convertTimeStyleToMin:(NSString*)timeStr 
{			
	if (timeStr) {
		NSDate *date=[NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
		NSString* timeString = [formatter stringFromDate:date];
		[formatter release];
		return timeString;
	}
	else {
		NSLog(@"传入时间戳为空");
		return @"";
	}
	
}
 
//日期性质转换为 秒数的形式
+(int)convertMinStyleToTime:(NSString *)timeStr
{
    int timeLengh = 0;
    if (timeStr)
    {
        NSArray *timeArray = [timeStr componentsSeparatedByString:@":"];
        if (timeArray && [timeArray count]==3) 
        {
            int hours = [[timeArray objectAtIndex:0] intValue];
            int minutes = [[timeArray objectAtIndex:1] intValue];
            int secondes = [[timeArray objectAtIndex:2] intValue];
            timeLengh = hours * 3600 + minutes *60 + secondes;
        }
        else if (timeArray && [timeArray count]==1)  
        {
            timeLengh = [[timeArray objectAtIndex:0] intValue];
        }
    }
    return  timeLengh;
}



//秒数转换为日期性质的形式
+(NSString *)convertSecondToDay:(int)second
{
	int timeOut = second;
	int hours = timeOut/(60*60);
	if (hours > 60)
	{
		hours = hours%60;
	}
	
	int minutes = timeOut/(60);
	if (minutes > 60)
	{
		minutes = minutes%60;
	}
	
	int seconds = timeOut%(60);
	NSString *	hourStr;
	NSString *	minuteStr;
	NSString *	secondStr;
	
//   如果小时再0-9中,会前面补0
	if (hours < 10)
	{
		hourStr = [NSString stringWithFormat:@"0%d",hours];	
	}
	else 
	{
		hourStr = [NSString stringWithFormat:@"%d",hours];	
	}
	
//   如果分钟再0-9中,会前面补0
	if (minutes < 10)
	{
		minuteStr = [NSString stringWithFormat:@"0%d",minutes];	
	}
    else if(minutes >= 60)
    {
        minuteStr = [NSString stringWithFormat:@"00"];	
    }
	else 
	{
		minuteStr = [NSString stringWithFormat:@"%d",minutes];	
	}
	
	if (seconds < 10)
	{
		secondStr = [NSString stringWithFormat:@"0%d",seconds];	
	}
    else if(seconds >= 60)
    {
        secondStr = [NSString stringWithFormat:@"00"];	
    }
	else 
	{
		secondStr = [NSString stringWithFormat:@"%d",seconds];	
	}
	
	NSString *timeString = [NSString stringWithFormat:@"%@ : %@ : %@",hourStr,minuteStr,secondStr];
	return timeString;
}

//转换时间格式，精确到天数
+ (NSString*)convertTimeStyleToDay:(NSString*)timeStr
{			
	if (timeStr) {
		NSDate *date=[NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy-MM-dd"];
		NSString* timeString = [formatter stringFromDate:date];
		[formatter release];
		return timeString;
	}
	else {
		NSLog(@"传入时间戳为空");
		return @"";
	}
	
}


/*
 根据时间戳返回显示时间
 */
+ (NSString*)timestamp:(NSString*)stringOfCreatedAt
{
	
	NSString*timestamp;
	// Convert timestamp string to UNIX time
    //
    struct tm created;
	time_t createdAt;
    
	if (stringOfCreatedAt) {
//		if (strptime([stringOfCreatedAt UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
//			get = strptime([stringOfCreatedAt UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
//		}
		setlocale(LC_TIME,   "en_US.iso88591 ");   //*********注意，必须注意环境变量 
		strptime([stringOfCreatedAt UTF8String], "%Y　%m　%d　%H　%M　%S", &created);
		createdAt = mktime(&created);//获取传入字符串的时间戳
	}
	
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
	
	NSLog(@"%@",[NSDate dateWithTimeIntervalSinceNow:3]);
	
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
		timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
    }
    else if (distance < 60 * 60) {  
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "minute ago" : "minutes ago"];
    }  
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "hour ago" : "hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "day ago" : "days ago"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "week ago" : "weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];        
        timestamp = [dateFormatter stringFromDate:date];
    }
    return timestamp;
}

#pragma mark -
#pragma mark 图片处理模块
/*
 此函数用于图片缩放
 输入参数：(CGSize)需要缩放的尺寸,(UIImage*)需要缩放的图片对象
 输出参数：缩放后的图片
 */

+(UIImage*)scaleToSize:(CGSize)size withImg:(UIImage*)img
{  
    // 创建一个bitmap的context  
    // 并把它设置成为当前正在使用的context  
    UIGraphicsBeginImageContext(size);  
    // 绘制改变大小的图片  
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];  
    // 从当前context中创建一个改变大小后的图片  
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
    // 使当前的context出堆栈  
    UIGraphicsEndImageContext();  
    // 返回新的改变大小后的图片  
    return scaledImage;  
}

/*
 此函数用于将图片变灰
 输入参数：(UIImage *)需要改变的图片
 输出参数：(UIImage *)变色后的图片
 */
+ (UIImage *) convertToGrayStyle:(UIImage *)img 
{
    int kRed = 1;
    int kGreen = 2;
    int kBlue = 4;
    int colors = kGreen;
    int m_width = img.size.width;
    int m_height = img.size.height;
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [img CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // now convert to grayscale
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height);
    for(int y = 0; y < m_height; y++) {
        for(int x = 0; x < m_width; x++) {
            uint32_t rgbPixel=rgbImage[y*m_width+x];
            uint32_t sum=0,count=0;
            if (colors & kRed) {sum += (rgbPixel>>24)&255;
                count++;
            } if (colors & kGreen) {
                sum += (rgbPixel>>16)&255; count++;
            } if (colors & kBlue) {sum += (rgbPixel>>8)&255;
                count++;
            } m_imageData[y*m_width+x]=sum/count;
        }
    }
    free(rgbImage);
    // convert from a gray scale image back into a UIImage
    uint8_t *result = (uint8_t *) calloc(m_width * m_height *sizeof(uint32_t), 1);
    // process the image back to rgb
    for(int i = 0; i < m_height * m_width; i++) {
        result[i*4]=0;
        int val=m_imageData[i];
        result[i*4+1]=val;
        result[i*4+2]=val;
        result[i*4+3]=val;
    }
    // create a UIImage
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    // make sure the data will be released by giving it to an autoreleased NSData
    [NSData dataWithBytesNoCopy:result length:m_width * m_height];
    return resultUIImage;
}

+(UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor 
{
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
	
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
	
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*
 图片修改成圆角的view
 注：需要导入QuartzCore框架 导入头文件#import <QuartzCore/QuartzCore.h>
 输入参数：需要改变的view
 输出参数：经过圆角处理的view
 */
+(UIView *)getRoundView:(UIView *)aView
{
	//圆角 边框的宽度 
 	aView.layer.borderWidth = 1.0f;
	//是否允许弯曲
 	aView.layer.masksToBounds=YES;
	//要弯的弧度
 	aView.layer.cornerRadius=5;
	//边框的颜色 
 	aView.layer.borderColor = [[UIColor clearColor] CGColor];
	return aView;
}

//设置个边框并且给个颜色
+(UIView *)setButtnBorderColor:(UIView *)aView viewColor:(UIColor *)color
{
	
 	[aView.layer setMasksToBounds:YES];
	aView.clipsToBounds = YES;
	//圆角 边框的宽度 
 	aView.layer.borderWidth = 2;
	//是否允许弯曲
 	aView.layer.masksToBounds=NO;
	//要弯的弧度
 	aView.layer.cornerRadius=8.0;
	//边框的颜色 
 	aView.layer.borderColor = [color CGColor];
	return aView;
}

//返回一个阴影的view
+(UIView *)getShadowView:(UIView *)aView
{
     //UIView设置阴影
    [[aView layer] setShadowOffset:CGSizeMake(1, 1)];
    [[aView layer] setShadowRadius:5];
    [[aView layer] setShadowOpacity:2];
    [[aView layer] setShadowColor:[UIColor blackColor].CGColor];
    //UIView设置边框
    [[aView layer] setCornerRadius:5];
    [[aView layer] setBorderWidth:2];
    [[aView layer] setBorderColor:[UIColor whiteColor].CGColor];
	return aView;
}
#pragma mark -
#pragma mark 字体处理函数模块
/*
 此函数用于返回一个label的自适应size
 输入参数：(NSString*)需要得到size的字符串，(CGFloat)规定的宽度，(CGFloat)字体大小
 输出参数：自适应后的size
 */
+(CGSize)getLabelSize:(NSString*)string withWidth:(CGFloat)width withFont:(CGFloat)fontSize
{
	CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize]
					 constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode: UILineBreakModeWordWrap];
	return size;
}

/*
 此函数用于返回一个label的自适应size
 注：传入的label需要设置好字体和宽度
 输入参数：(UILabel*)label需要自适应的label
 输出参数：自适应后的size
 */
+(CGSize)getLabelSize:(UILabel*)label
{
//	CGFloat fontSize = label.font.pointSize;
//	CGFloat width = label.frame.size.width;
//	NSString* string = label.text;
//	CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:fontSize]
//					 constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode: UILineBreakModeWordWrap];
	CGSize size = [label.text sizeWithFont:label.font
								 constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode: UILineBreakModeWordWrap];
	return size;
	
}
/*
 此函数用于返回一个label的自适应size
 注：传入的label需要设置好字体和宽度
 输入参数：(NSString*)需要得到size的字符串，(CGFloat)规定的宽度 
 输出参数：自适应后的size
 */
+(CGSize)getLabelSize:(UILabel*)label withWidth:(CGFloat)width  
{
	CGSize size = [label.text sizeWithFont:label.font
						 constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode: UILineBreakModeWordWrap];
	return size;
}
#pragma mark -
#pragma mark 判断模块
/*
 判断该email是否合法
 输入参数：要判断的内容
 输出参数：true为合法，false为不合法
 */
//+(BOOL)isisMatchedEmail:(NSString *)str
//{
//	//	return  [str isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
//	str = [str lowercaseString];
//	//return [str isMatchedByRegex:@"([a-z0-9]*[-_.]?[a-z0-9]+)*@[a-z0-9]+([-_.]?[a-z0-9]+)*[.][a-z]{2,3}([.][a-z]{2})?"];
//	return [str isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
//}



/*
 判断JSon解析出来的Object是否为NSNull类型
 输入参数：需要判断的Object
 输出参数：true为非空值，false为空值
 */
+(BOOL)checkNullValue:(id)object
{
	return ![object isKindOfClass:[NSNull class]];
}

/*
 判断JSon解析出来的Object是否为NSNull类型
 输入参数：需要判断的Object
 输出参数：返回一个经过格式化的NSString类型
 */
+(NSString *)checkNullValueForString:(id)object
{
	if([object isKindOfClass:[NSNull class]])
	{
		return @"";
	}	
	else if(!object)
	{
		return @"";// (NSString *)object;
	}
    else
	{	
		return [NSString stringWithFormat:@"%@",object];// (NSString *)object;
	}	
}

/*
 过滤字符串中的&nbsp;换行。
 输入参数：需要过滤的字符串
 输出参数：过滤完成的字符串
 */
+(NSString *)checkNewlineValue:(NSString *)str
{
	return [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:[NSString stringWithFormat:@"%c",'\n']];// (NSString *)object;
}

/*
 判断设备是iphone还是ipad
 输出参数：Yes为Ipone，false为ipad
 */
+(BOOL)getDevieIsPhone
{
	UIDevice *myDevice = [UIDevice currentDevice];
	if ([[myDevice model] isEqualToString:@"iPad"])
	{
		return NO;
	}
	else  
	{
		return YES;
	}
}



+(int)getRandomNumber:(int)from to:(int)to 
{
    
    return(int)(from + arc4random() % (to-from+1));
}

@end
