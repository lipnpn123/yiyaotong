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
	// Do any additional setup after loading the view.
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
        jiantouImageView.frame = CGRectMake(260, 15, 20, 20);
        jiantouImageView.backgroundColor = [UIColor redColor];
        [textViewBgView addSubview:jiantouImageView];
    }
    offy += 70;
    
    {
        UIImageView *textViewBgView = [[UIImageView alloc] init];
        textViewBgView.frame= CGRectMake(labelOffw, offy, width, 60);
        textViewBgView.image = [[UIImage imageNamed:@"dabeijingImage.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:5];
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
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}
#pragma mark UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    
     
    [picker dismissModalViewControllerAnimated:YES];
    
}
#pragma mark ----textFild

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
