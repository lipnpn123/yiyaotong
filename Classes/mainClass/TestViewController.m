    //
//  TestViewController.m
//  HundredMillion 
//
//  Created by 李 碰碰 on 12-4-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestViewController.h"
#import "GlobalPointer.h"


@implementation TestViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIButton *btn = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
	btn.frame = CGRectMake(100,100,100,100);
	[btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
	
	UIButton *btn2 = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
	btn2.frame = CGRectMake(220,200,100,100);
	[btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn2];
	
    WSUserMethod *globalWebRequest = [[WSUserMethod alloc] init];
	[globalWebRequest testRequest];
}
 

-(void)faildSuc:(id)res
{
	PPwriteObject(res);
    [self showNomalNotice:@"123"];
}

-(void)requestSuc:(id)res
{
	PPwriteObject(res);
    [self showNomalNotice:@"234"];

}
-(void)btnAction
{
    [self showNomalNotice:@"234"];

}

-(void)btnAction2
{
    [self showNomalNotice:@"234"];

}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
