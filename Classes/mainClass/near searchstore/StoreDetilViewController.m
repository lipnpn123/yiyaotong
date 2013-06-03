//
//  StoreDetilViewController.m
//  HundredMillion 
//
//  Created by li pnpn on 13-6-3.
//
//

#import "StoreDetilViewController.h"

@interface StoreDetilViewController ()

@end

@implementation StoreDetilViewController
@synthesize storeCode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.wsUserMethod = [[WSUserMethod alloc] init];
    self.wsUserMethod.delegate = self;
    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"get_store"];
    [entity appendRequestParameter:self.storeCode withKey:@"storecode"];
 
	[self.wsUserMethod nomoalRequestWithEntity:entity];
}

- (void)requestFinished:(ASIFormDataRequest *)aRequest
{
   
    
}


- (void)requestFailed:(ASIFormDataRequest *)aRequest
{
     
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
