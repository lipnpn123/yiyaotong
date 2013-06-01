//
//  WSCustomMethod.m
//  Yoho
//
//  Created by ncg ncg-1 on 11-9-27.
//  Copyright 2011 ncg. All rights reserved.
//

#import "WSCustomMethod.h"
#import "GlobalDataInfo.h"

@implementation WSCustomMethod

@synthesize requestDictionary;

-(id)init
{
	if (self = [super init]) {
		requestDictionary = [[NSMutableDictionary alloc] init];
	}
	return self;
}

-(void)dealloc
{
	setFree(requestDictionary);
	[super dealloc];
}
 

@end
