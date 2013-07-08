//
//  ShoppingCartViewController.m
//  HundredMillion 
//
//  Created by betty on 13-7-7.
//
//

#define sendHeight  30
#define sendverticalHeight 10
#define textField_x 100
#define textField_width 180

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableView.h"
@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController

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
    // Do any additional setup after loading the view from its nib.
    self.selfTittleLabel.text = @"药品订单";
    [self createRightBarBtn:@"确定" action:@selector(rightButtonClicked:) withImageName:nil];
    
    //加载配送信息
    [self addSendMedcineMessageView];
    
    //添加表
    ShoppingCartTableView *tableView = [[ShoppingCartTableView alloc] initWithFrame:CGRectMake(0, 220, 320, self.view.bounds.size.height-220)];
    tableView.fatherViewController =self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.wfBgImageView addSubview:tableView];

}

-(void)addSendMedcineMessageView
{
    UIView *sendView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 220)];
    [self.wfBgImageView addSubview:sendView];
    sendView.backgroundColor=[UIColor clearColor];
    
    UILabel  *sendModel =NewLabelWithDefaultSize(18);
    sendModel.text=@"配送方式:";
    [sendView addSubview:sendModel];
    sendModel.frame =CGRectMake(10, 10, 80, sendHeight);
    sendModel.textColor = [UIColor blueColor];
    
    UILabel  *sendTime =NewLabelWithDefaultSize(18);
    sendTime.text=@"配送时间:";
    [sendView addSubview:sendTime];
    sendTime.frame =CGRectMake(10, 10+sendHeight+sendverticalHeight, 80, sendHeight);
    sendTime.textColor = [UIColor blueColor];
    
    
    UILabel  *sendRange =NewLabelWithDefaultSize(18);
    sendRange.text=@"发送范围:";
    [sendView addSubview:sendRange];
    sendRange.frame =CGRectMake(10, 10+2*sendHeight+2*sendverticalHeight, 80, sendHeight);
    sendRange.textColor = [UIColor blueColor];
    
    
    UILabel  *sendAddress =NewLabelWithDefaultSize(18);
    sendAddress.text=@"联系地址:";
    [sendView addSubview:sendAddress];
    sendAddress.frame =CGRectMake(10, 3*sendHeight+3*sendverticalHeight+10, 80, sendHeight);
    sendAddress.textColor = [UIColor blueColor];
    UITextField *sendAddressField  =[[UITextField alloc] initWithFrame:CGRectMake(textField_x,3* sendHeight+3*sendverticalHeight+10, textField_width, sendHeight)];
    sendAddressField.backgroundColor =[UIColor greenColor];
    sendAddressField.placeholder= @" ";
    sendAddressField.background =[UIImage imageNamed:@"input.png"]
    ;
    sendAddressField.delegate=self;
    sendAddressField.textAlignment = UITextAlignmentLeft;
    sendAddressField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [sendView addSubview:sendAddressField];
    
    
    UILabel  *sendContact =NewLabelWithDefaultSize(18);
    sendContact.text=@"联系方式:";
    [sendView addSubview:sendContact];
    sendContact.frame =CGRectMake(10,4* sendHeight+4*sendverticalHeight+10, 80, sendHeight);
    sendContact.textColor = [UIColor blueColor];
    
    
   UITextField *sendContactField  =[[UITextField alloc] initWithFrame:CGRectMake(textField_x,4* sendHeight+4*sendverticalHeight+10, textField_width, sendHeight)];
    sendContactField.backgroundColor =[UIColor greenColor];
    sendContactField.placeholder= @" ";
    sendContactField.background =[UIImage imageNamed:@"input.png"]
    ;
    sendContactField.delegate=self;
    sendContactField.textAlignment = UITextAlignmentLeft;
    sendContactField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [sendView addSubview:sendContactField];
    
}


-(void)rightButtonClicked:(UIButton *)btn
{
  
    
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	[textField resignFirstResponder];
	return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
