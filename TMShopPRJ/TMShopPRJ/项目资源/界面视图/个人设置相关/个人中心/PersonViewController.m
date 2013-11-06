//
//  PersonViewController.m
//  TMShopPRJ
//
//  Created by lipengpeng on 13-10-29.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()
@property (nonatomic,strong)UIScrollView *mainScrollView;

@end

@implementation PersonViewController

#define nametextFildTag                     1111111
#define phonetextFildTag                    1111112
#define emailtextFildTag                    1111113
#define changePassWordFildTag               1111114
#define newPassWordtextFildTag              1111115
#define shurePassWordtextFildTag            1111116

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
    
    [self createRightBarBtn:nil action:@selector(shureAction) withImageName:@"shureNavBarButtonImage.png"];
    
    self.rightBarBtn.size = CGSizeMake(32, 32);
    self.rightBarBtn.origin = CGPointMake(280, 6);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 12, 20, 20);
    imageView.image = [UIImage imageNamed:@"titleIconImage.png"] ;
    [self.wfTitleImageView addSubview:imageView];
    
    UIButton *_titlebutton = nil;
    if (!_titlebutton)
    {
        _titlebutton = [[UIButton alloc] init];
        _titlebutton.frame = CGRectMake(110, 7, 120, 30);
        [_titlebutton setTitle:@"Xtask工作" forState:UIControlStateNormal];
        [_titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.wfTitleImageView addSubview:_titlebutton];
    [self createMainView];
    if (!self.wsUserMethod)
    {
        self.wsUserMethod = [[WSUserMethod alloc] init];
    }
    self.wsUserMethod.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
	// Do any additional setup after loading the view.
}

-(void)shureAction
{
#define nametextFildTag                     1111111
#define phonetextFildTag                    1111112
#define emailtextFildTag                    1111113
#define changePassWordFildTag               1111114
#define newPassWordtextFildTag              1111115
#define shurePassWordtextFildTag            1111116

    UITextField *nametextFild = (UITextField *)[self.mainScrollView viewWithTag:nametextFildTag];
    UITextField *phonetextFild = (UITextField *)[self.mainScrollView viewWithTag:phonetextFildTag];
    UITextField *emailtextFild = (UITextField *)[self.mainScrollView viewWithTag:emailtextFildTag];
    UITextField *changePassWordFild = (UITextField *)[self.mainScrollView viewWithTag:changePassWordFildTag];
    UITextField *newPassWordtextFild = (UITextField *)[self.mainScrollView viewWithTag:newPassWordtextFildTag];
    UITextField *shurePassWordtextFild = (UITextField *)[self.mainScrollView viewWithTag:shurePassWordtextFildTag];
//
    NSString *nameText = checkNullValue(nametextFild.text);
    NSString *phonetext = checkNullValue(phonetextFild.text);
    NSString *emailtext = checkNullValue(emailtextFild.text);
    NSString *changePassWord = checkNullValue(changePassWordFild.text);
    NSString *newPassWord = checkNullValue(newPassWordtextFild.text);
    NSString *shurePassWord = checkNullValue(shurePassWordtextFild.text);
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XtaskGroupbatchupdateList];
     
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:[UserEntity shareGlobalUserEntity].personUid forKey:@"id"];
//    [dic setValue:@"lipnpn" forKey:@"loginname"];
    [dic setValue:phonetext forKey:@"mobile"];
    [dic setValue:emailtext forKey:@"email"];
    [dic setValue:nameText forKey:@"name"];
    [dic setValue:newPassWord forKey:@"password"];
    
    NSArray *array = [NSArray arrayWithObject:dic];
    [entity appendRequestParameter:array withKey:@"updateBeanids"];
    
    
    entity.requestMethod = @"post";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
}

-(void)createMainView
{
    if (!self.mainScrollView)
    {
        self.mainScrollView = [[UIScrollView alloc] init];
    }
    self.mainScrollView.frame = CGRectMake(10, 10, 300, self.wfBgImageView.height-20);
    [self.wfBgImageView addSubview:self.mainScrollView];

    int offy = 10;
    int labelOffw =0;
    int width = 320;
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.frame = CGRectMake(0, 0, self.mainScrollView.width, self.mainScrollView.height);
    bgImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:bgImageView];
    
    {
        UIButton *textViewBgView = [[UIButton alloc] init];
        textViewBgView.frame= CGRectMake(labelOffw, offy, width, 60);
        [textViewBgView setBackgroundImage:[[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5] forState:UIControlStateNormal];
        [textViewBgView setBackgroundImage:[[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5] forState:UIControlStateHighlighted];
        [textViewBgView addTarget:self action:@selector(headImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
        
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.frame = CGRectMake(20, 15, 30, 30);
        iconImageView.image = [UIImage imageNamed:@"login_press_tx.png"];
        [textViewBgView addSubview:iconImageView];
        
        UILabel *titleLabel  = NewLabelWithDefaultSize(14);
        titleLabel.frame = CGRectMake(60, 15, width, 30);
        titleLabel.text = @"上传头像";
        [textViewBgView addSubview:titleLabel];
        
        UIImageView *jiantouImageView = [[UIImageView alloc] init];
        jiantouImageView.frame = CGRectMake(260, 20, 20, 20);
        jiantouImageView.image = [UIImage imageNamed:@"jiantouImage.png"];
//        jiantouImageView.backgroundColor = [UIColor redColor];
        [textViewBgView addSubview:jiantouImageView];
    }
    offy += 70;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(labelOffw, offy, width, 60);
        textViewBgView.image = [[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        textViewBgView.userInteractionEnabled= YES;
        //    textViewBgView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:textViewBgView];
  
        int off = 10;
        
        UILabel *loginNameTileLabel  = NewLabelWithBoldSize(12);
        loginNameTileLabel.frame = CGRectMake(20, off, 50, 30);
        loginNameTileLabel.text = @"登陆名";
        [textViewBgView addSubview:loginNameTileLabel];
        
        UILabel *loginNameLabel  = NewLabelWithBoldSize(12);
        loginNameLabel.frame = CGRectMake(100, off, 180, 30);
        loginNameLabel.text = @"登陆名";
        [textViewBgView addSubview:loginNameLabel];
        
        off += 33;
        {
        UIImageView *lineImageView = [[UIImageView alloc] init];
        lineImageView.frame = CGRectMake(5, off , 305, 1);
        lineImageView.backgroundColor = RGBCOLOR(224, 231, 238, 1);
        [textViewBgView addSubview:lineImageView];
        
        off += 5;
        }
        
        UILabel *nameTitleLabel  = NewLabelWithBoldSize(12);
        nameTitleLabel.frame = CGRectMake(20, off, 50, 30);
        nameTitleLabel.text = @"姓名";
        [textViewBgView addSubview:nameTitleLabel];
        
        {
            UIImageView *inputBgView = [[UIImageView alloc] init];
            inputBgView.frame = CGRectMake(90, off+5, 200, 20);
            inputBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
            //    textViewBgView.backgroundColor = [UIColor redColor];
            [textViewBgView addSubview:inputBgView];
        }
        
        UITextField *nametextFild = [[UITextField alloc] init];
        nametextFild.delegate = self;
        nametextFild.frame = CGRectMake(100, off+5, 180, 20);
        nametextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nametextFild.font = NewFontWithDefaultSize(14);
        nametextFild.tag = nametextFildTag;
        [textViewBgView addSubview:nametextFild];
        
        off += 33;
        {
            UIImageView *lineImageView = [[UIImageView alloc] init];
            lineImageView.frame = CGRectMake(5, off , 305, 1);
            lineImageView.backgroundColor = RGBCOLOR(224, 231, 238, 1);
            [textViewBgView addSubview:lineImageView];
            
            off += 5;
        }
        
        UILabel *phoneTitleLabel  = NewLabelWithBoldSize(12);
        phoneTitleLabel.frame = CGRectMake(20, off, 50, 30);
        phoneTitleLabel.text = @"电话";
        [textViewBgView addSubview:phoneTitleLabel];
      
        {
            UIImageView *inputBgView = [[UIImageView alloc] init];
            inputBgView.frame = CGRectMake(90, off+5, 200, 20);
            inputBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
            //    textViewBgView.backgroundColor = [UIColor redColor];
            [textViewBgView addSubview:inputBgView];
        }
        
        UITextField *phonetextFild = [[UITextField alloc] init];
        phonetextFild.tag = phonetextFildTag;
        phonetextFild.frame = CGRectMake(100, off+5, 180, 20);
        phonetextFild.font = NewFontWithDefaultSize(14);
        phonetextFild.delegate = self;
        [textViewBgView addSubview:phonetextFild];
        
        off += 33;
        {
            UIImageView *lineImageView = [[UIImageView alloc] init];
            lineImageView.frame = CGRectMake(5, off , 305, 1);
            lineImageView.backgroundColor = RGBCOLOR(224, 231, 238, 1);
            [textViewBgView addSubview:lineImageView];
            
            off += 5;
        }
        
        UILabel *emailTitleLabel  = NewLabelWithBoldSize(12);
        emailTitleLabel.frame = CGRectMake(20, off, 50, 30);
        emailTitleLabel.text = @"邮箱";
        [textViewBgView addSubview:emailTitleLabel];
        
        {
            UIImageView *inputBgView = [[UIImageView alloc] init];
            inputBgView.frame = CGRectMake(90, off+5, 200, 20);
            inputBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10];
            //    textViewBgView.backgroundColor = [UIColor redColor];
            [textViewBgView addSubview:inputBgView];
        }
        
        UITextField *emailtextFild = [[UITextField alloc] init];
        emailtextFild.frame = CGRectMake(100, off+5, 180, 20);
        emailtextFild.tag = emailtextFildTag;
        emailtextFild.font = NewFontWithDefaultSize(14);
        emailtextFild.delegate = self;
        [textViewBgView addSubview:emailtextFild];
        off += 50;
        
        textViewBgView.frame= CGRectMake(labelOffw, offy, width, off);

        offy += off;
    }
    
    {

        
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(labelOffw, offy, width, 60);
        textViewBgView.image = [[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
        //    textViewBgView.backgroundColor = [UIColor redColor];
        textViewBgView.userInteractionEnabled= YES;
        [bgImageView addSubview:textViewBgView];
        
        int off = 10;
        
        UILabel *chagePassTitleLabel  = NewLabelWithBoldSize(12);
        chagePassTitleLabel.frame = CGRectMake(20, off, 100, 30);
        chagePassTitleLabel.text = @"修改密码";
        [textViewBgView addSubview:chagePassTitleLabel];
        
        off += 30;
        
        UILabel *changePassWordTitleLabel  = NewLabelWithBoldSize(12);
        changePassWordTitleLabel.frame = CGRectMake(20, off, 70, 30);
        changePassWordTitleLabel.text = @"修改密码";
        [textViewBgView addSubview:changePassWordTitleLabel];
        
        {
            UIImageView *inputBgView = [[UIImageView alloc] init];
            inputBgView.frame = CGRectMake(90, off+5, 200, 20);
            inputBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
            //    textViewBgView.backgroundColor = [UIColor redColor];
            [textViewBgView addSubview:inputBgView];
        }
        
        UITextField *changePassWordFild = [[UITextField alloc] init];
        changePassWordFild.delegate = self;
        changePassWordFild.frame = CGRectMake(100, off+5, 180, 20);
        changePassWordFild.tag = changePassWordFildTag;
        changePassWordFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        changePassWordFild.font = NewFontWithDefaultSize(14);
        [textViewBgView addSubview:changePassWordFild];
        
        off += 33;
        {
            UIImageView *lineImageView = [[UIImageView alloc] init];
            lineImageView.frame = CGRectMake(5, off , 305, 1);
            lineImageView.backgroundColor = RGBCOLOR(224, 231, 238, 1);
            [textViewBgView addSubview:lineImageView];
            
            off += 5;
        }
        
        UILabel *newPassWordTitleLabel  = NewLabelWithBoldSize(12);
        newPassWordTitleLabel.frame = CGRectMake(20, off, 50, 30);
        newPassWordTitleLabel.text = @"新密码";
        [textViewBgView addSubview:newPassWordTitleLabel];
        
        {
            UIImageView *inputBgView = [[UIImageView alloc] init];
            inputBgView.frame = CGRectMake(90, off+5, 200, 20);
            inputBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
            //    textViewBgView.backgroundColor = [UIColor redColor];
            [textViewBgView addSubview:inputBgView];
        }
        
        UITextField *newPassWordtextFild = [[UITextField alloc] init];
        newPassWordtextFild.frame = CGRectMake(100, off+5, 180, 20);
        newPassWordtextFild.tag = newPassWordtextFildTag;
        newPassWordtextFild.font = NewFontWithDefaultSize(14);
        newPassWordtextFild.delegate = self;
        [textViewBgView addSubview:newPassWordtextFild];
        
        off += 33;
        {
            UIImageView *lineImageView = [[UIImageView alloc] init];
            lineImageView.frame = CGRectMake(5, off , 305, 1);
            lineImageView.backgroundColor = RGBCOLOR(224, 231, 238, 1);
            [textViewBgView addSubview:lineImageView];
            
            off += 5;
        }
        
        UILabel *shurePassWordTitleLabel  = NewLabelWithBoldSize(12);
        shurePassWordTitleLabel.frame = CGRectMake(20, off, 70, 30);
        shurePassWordTitleLabel.text = @"确认新密码";
        [textViewBgView addSubview:shurePassWordTitleLabel];
        
        {
            UIImageView *inputBgView = [[UIImageView alloc] init];
            inputBgView.frame = CGRectMake(90, off+5, 200, 20);
            inputBgView.image = [[UIImage imageNamed:@"priority-icon_plk.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:10];
            //    textViewBgView.backgroundColor = [UIColor redColor];
            [textViewBgView addSubview:inputBgView];
        }
        
        UITextField *shurePassWordtextFild = [[UITextField alloc] init];
        shurePassWordtextFild.frame = CGRectMake(100, off+5, 180, 20);
        shurePassWordtextFild.font = NewFontWithDefaultSize(14);
        shurePassWordtextFild.tag = shurePassWordtextFildTag;
        shurePassWordtextFild.delegate = self;
        [textViewBgView addSubview:shurePassWordtextFild];
        off += 60;
        
        textViewBgView.frame= CGRectMake(labelOffw, offy, width, off);
        
        offy += off;
    }
    
    
    if (offy <_mainScrollView.height)
    {
        [_mainScrollView setContentSize:CGSizeMake(self.mainScrollView.width, _mainScrollView.height+1)];
        bgImageView.frame = CGRectMake(0, 0, self.mainScrollView.width, _mainScrollView.height+1);
    }
    else
    {
        [self.mainScrollView setContentSize:CGSizeMake(self.mainScrollView.width, offy)];
        bgImageView.frame = CGRectMake(0, 0, self.mainScrollView.width, offy);
    }
}
- (void)keyboardDidHide:(NSNotification*)notification
{
    
    [UIView animateWithDuration:0.35 animations:^{
        self.mainScrollView.frame = NomalView_Frame;
    }];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    [UIView animateWithDuration:0.35 animations:^{
        self.mainScrollView.frame = CGRectMake(0, 0, 320, Dev_ScreenHeight - Dev_StateHeight-44-225);
    }];
    
}
-(void)headImageButtonAction
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"获取头像方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍摄",@"照片库获取", nil] ;
    [sheet showInView:self.wfBgImageView];
}
#pragma mark ----UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
    else if (buttonIndex == 1)
    {

        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void)uploadImageMethod:(UIImage *)image
{
    UserRequestEntity *entity = [[UserRequestEntity alloc] init];
    [entity setRequestAction:XTasktUploadImagePath];
 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dabeijingImage" ofType:@"png"];
    [entity appendFileRequestParameter:path withKey:@"pictureid"];
    [entity appendRequestParameter:[UserEntity shareGlobalUserEntity].personUid withKey:@"id"];
    
    
    entity.requestMethod = @"post";
    [self.wsUserMethod nomoalRequestWithEntity:entity withTag:1];
    
}
#pragma mark UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    
    [self uploadImageMethod:aImage];
    [picker dismissModalViewControllerAnimated:YES];
    
}
#pragma mark ----textFild
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:textField.tag inSection:0];
    
    CGRect rect = [textField superview].frame;
    rect.origin.y += textField.origin.y;
    [self.mainScrollView setContentOffset:CGPointMake(0, rect.origin.y - 80) animated:YES];
    //    [self  scrollRectToVisible:rect animated:YES];
    
    
    return YES;
}
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
