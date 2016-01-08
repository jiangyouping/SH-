//
//  SHComposeViewController.m
//  SH微博
//
//  Created by juan on 15/11/10.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHComposeViewController.h"
#import "SHTextView.h"
#import "SHComposeToolBar.h"
#import "SHComposePhotosView.h"

#import "SHComposeTool.h"

#import "MBProgressHUD+MJ.h"

#import "SHHomeViewController.h"

@interface SHComposeViewController ()<UITextViewDelegate,SHComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) SHTextView *textView;
@property (nonatomic,weak) SHComposeToolBar *toolBar;
@property (nonatomic,weak) UIBarButtonItem *rightItem;
@property (nonatomic,weak) SHComposePhotosView *photosView;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation SHComposeViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    
    return _images;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}

// 添加相册视图
- (void)setUpPhotosView
{
    SHComposePhotosView *photosView = [[SHComposePhotosView alloc] initWithFrame:CGRectMake(10, 70, self.view.width - 20, self.view.height-70)];
    
    _photosView = photosView;
    
    [_textView addSubview:photosView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条
    [self setUpNavgationBar];
    
    //设置textView
    [self setUpTextView];
    
    //添加工具条
    [self setUpToolBar];
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加相册视图
    [self setUpPhotosView];
}

#pragma mark - 键盘的Frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note
{
    // 获取键盘弹出的动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
    } else{
        // 弹出键盘
        // 工具条往上移动258
        
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

#pragma mark - 设置导航条
- (void)setUpNavgationBar
{
    self.title = @"发微博";
    
    //left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(cancel)];
    
    //right
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:0 target:self action:@selector(compose)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    //监听按钮的点击事件
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
}

//取消
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发送
- (void)compose
{
    if (self.images.count) {
        [self sendPicture];
    } else{
        [self sendText];
    }
}

#pragma mark - 发送文字微博
- (void)sendText
{
    // 提示用户发送成功
    [SHComposeTool composeWithStatus:_textView.text success:^{
        [MBProgressHUD showSuccess:@"发送成功"];
        
        //[self dismissViewControllerAnimated:YES completion:nil];
        SHHomeViewController *home = [[SHHomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
        [home refresh];
        
    } failure:^(NSError *error) {
        SHLog(@"发送失败:%@",error);
    }];
}

#pragma mark - 发送带图片的微博
- (void)sendPicture
{
    UIImage *image = self.images[0];
    
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = NO;
    
    [SHComposeTool composeWithStatus:status image:image success:^{
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
        
    } failure:^(NSError *error) {
        SHLog(@"%@",error);
        
        _rightItem.enabled = YES;
    }];
}

#pragma mark - 点击工具条按钮的时候调用
- (void)composeToolBar:(SHComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    switch (index) {
        case 0:{
            // 弹出系统的相册
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            
            // 设置相册类型,相册集
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            imagePicker.delegate = self;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - 选择图片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    
    _photosView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled = YES;
}

#pragma mark - 添加textView
- (void)setUpTextView
{
    SHTextView *textView = [[SHTextView alloc]initWithFrame:self.view.bounds];
    _textView = textView;
    
    textView.placeHolder = @"请输入";
    [self.view addSubview:textView];
    
    textView.alwaysBounceVertical = YES;
    
    /**
     *  Observer:谁需要监听通知
     *  name：监听的通知的名称
     *  object：监听谁发送的通知，nil:表示谁发送我都监听
     */
    
    // 监听文本框的输入
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    // 监听拖拽
    _textView.delegate = self;
                            
}

#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

// 判断下textView有木有内容
- (void) textChange
{
    if (_textView.text.length) {
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
    } else{
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
    }
}

- (void) setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    SHComposeToolBar *composeToolBar = [[SHComposeToolBar alloc]initWithFrame:CGRectMake(0, y, self.view.width, h)];
    
    _toolBar = composeToolBar;
    _toolBar.delegate = self;
    [self.view addSubview:composeToolBar];
    
                                        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
