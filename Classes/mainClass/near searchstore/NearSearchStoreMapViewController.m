//
//  NearSearchStoreMapViewController.m
//  HundredMillion 
//
//  Created by li pnpn on 13-6-3.
//
//
#import "BMapKit.h"

#import "NearSearchStoreMapViewController.h"
@interface NearSearchStoreMapViewController ()
{
    BMKMapView *mainMapView;
    BOOL isFouce;
}
@end

@implementation NearSearchStoreMapViewController

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
    mainMapView = [[BMKMapView alloc] initWithFrame:NomalView_Frame];
    [mainMapView addZoomButton];
    mainMapView.delegate = self;
    mainMapView.showsUserLocation = YES;
    mainMapView.zoomLevel = 14;
    [self.wfBgImageView addSubview:mainMapView];
    
    
    
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:@"search_store_position"];
    [entity appendRequestParameter:@"" withKey:@"key"];
    
	[self.wsUserMethod nomoalRequestWithEntity:entity];
}
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"1111");
    if (!isFouce)
    {
        isFouce = YES;
        [mainMapView setCenterCoordinate:userLocation.coordinate];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
