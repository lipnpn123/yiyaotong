//
//  MyConnectPersonViewController.m
//  TMShopPRJ
//
//  Created by 罗 乐华建 on 13-10-9.
//  Copyright (c) 2013年 李 鹏鹏. All rights reserved.
//
#import "NSString+TKUtilities.h"

#import "MyConnectPersonViewController.h"
#import "MyConnectTableView.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <malloc/malloc.h>
#import "TKAddressBook.h"

@interface MyConnectPersonViewController ()
@property (nonatomic,strong)MyConnectTableView *mainTableView;
@property (nonatomic,strong)UIImageView *textFildImageView;
@property (nonatomic,strong)UITextField *inputtextFild;
@property (nonatomic,strong)UIButton *searchButton;

@end

@implementation MyConnectPersonViewController

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
    
    if (self.textFildImageView == nil)
    {
        self.textFildImageView = [[UIImageView alloc] init];
    }
    self.textFildImageView.image = [UIImage imageNamed:@"textFildBgImage_1.png"];
    self.textFildImageView.frame = CGRectMake(10, 7, 260/10*9, 30/10*9);
    [self.wfBgImageView addSubview:self.textFildImageView];
    
    if (self.inputtextFild == nil)
    {
        self.inputtextFild = [[UITextField alloc] init];
    }
    
    self.inputtextFild.delegate = self;
    [self.inputtextFild setBorderStyle:UITextBorderStyleNone];
    self.inputtextFild.frame = CGRectMake(40, 7, 260/10*9-40,  30/10*9);
    self.inputtextFild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputtextFild.font = NewFontWithBoldSize(14);
//    self.inputtextFild.backgroundColor = [UIColor redColor];
    self.inputtextFild.clearButtonMode = UITextFieldViewModeAlways;
    [self.wfBgImageView addSubview:self.inputtextFild];
    
    if (self.searchButton == nil)
    {
        self.searchButton = [[UIButton alloc] init];
    }
    [self.searchButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton setImage:[UIImage imageNamed:@"sousuoButtonImage.png"] forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = NewFontWithBoldSize(14);
    self.searchButton.frame = CGRectMake(250, 5, 60, 30);
    [self.wfBgImageView addSubview:self.searchButton];

    if (self.mainTableView == nil)
    {
        self.mainTableView= [[MyConnectTableView alloc] initWithFrame:CGRectMake(0,44, 320, Dev_ScreenHeight-Dev_ToolbarHeight- Dev_StateHeight-44) style:UITableViewStylePlain];

    }
    [self.mainTableView reloadTableData];
    [self.wfBgImageView addSubview:self.mainTableView];
    
    [self logConnect];
	// Do any additional setup after loading the view.
}

-(void)logConnect
{
    // Create addressbook data model
    NSMutableArray *addressBookTemp = [NSMutableArray array];
    ABAddressBookRef addressBooks = ABAddressBookCreate();
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    
    for (NSInteger i = 0; i < nPeople; i++)
    {
        TKAddressBook *addressBook = [[TKAddressBook alloc] init];
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        CFStringRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        
        /*
         Save thumbnail image - performance decreasing
         UIImage *personImage = nil;
         if (person != nil && ABPersonHasImageData(person)) {
         if ( &ABPersonCopyImageDataWithFormat != nil ) {
         // iOS >= 4.1
         CFDataRef contactThumbnailData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
         personImage = [[UIImage imageWithData:(NSData*)contactThumbnailData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactThumbnailData);
         CFDataRef contactImageData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatOriginalSize);
         CFRelease(contactImageData);
         
         } else {
         // iOS < 4.1
         CFDataRef contactImageData = ABPersonCopyImageData(person);
         personImage = [[UIImage imageWithData:(NSData*)contactImageData] thumbnailImage:CGSizeMake(44, 44)];
         CFRelease(contactImageData);
         }
         }
         [addressBook setThumbnail:personImage];
         */
        
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((id)CFBridgingRelease(abLastName) != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        addressBook.rowSelected = NO;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = [(__bridge NSString*)value telephoneWithReformat];
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        [addressBookTemp addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    NSLog(@"addressBookTemp  %@",addressBookTemp);
    
    CFRelease(allPeople);
    CFRelease(addressBooks);

    
}

-(void)searchButtonAction
{
    
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
    self.mainTableView = nil;
    self.textFildImageView = nil;
    self.inputtextFild = nil;
    self.searchButton = nil;
//    [super dealloc];
}

@end
