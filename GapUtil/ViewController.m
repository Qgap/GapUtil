
#import "ViewController.h"
#import <Masonry.h>
#import "MZTimerLabel.h"
#import "Header.h"
#import "Validator.h"
#import "DataCenter.h"

@interface ViewController ()

@property (nonatomic, strong)UITextField *phoneField;
@property (nonatomic, strong)UITextField *codeField;
@property (nonatomic, strong)UILabel *countTimeLabel;
@property (nonatomic, strong)UIButton *registerButton;
@property (nonatomic, strong)DataCenter *dataCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.dataCenter = [DataCenter shareInstance];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.phoneField becomeFirstResponder];
}

#pragma mark - Action && Net

- (void)countGetCodeTime {
    if (![Validator isValidateMobile:self.phoneField.text]) {
        NSLog(@"----please input right mobile phone");
        return;
    }
    
    __weak __typeof(&*self) weakSelf = self;
    self.countTimeLabel.userInteractionEnabled = NO;
    MZTimerLabel *countdownLabel = [[MZTimerLabel alloc] initWithLabel:self.countTimeLabel  andTimerType:MZTimerLabelTypeTimer];
    countdownLabel.timeFormat = @"ss'秒后重发";
    [countdownLabel reset];
    [countdownLabel setCountDownTime:60];
    countdownLabel.textType = attributedText;
    [countdownLabel startWithEndingBlock:^(NSTimeInterval countTime) {
        weakSelf.countTimeLabel.userInteractionEnabled = YES;
        weakSelf.countTimeLabel.text = @"获取验证码";
    }];
}

- (void)registerAction {

    NSString *phoneString = [NSString stringWithFormat:@"%@,8888",self.phoneField.text];
    
    [self.dataCenter.sessionManage POST:SIGNUP parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:[phoneString dataUsingEncoding:NSUTF8StringEncoding] name:@"safe_mobile"];
        [formData appendPartWithFormData:[self.codeField.text dataUsingEncoding:NSUTF8StringEncoding] name:@"password"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"responseObject :%@",jsonData);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)textFieldsChange:(UITextField *)sender {
    if (self.codeField.text.length >= 4 && [Validator isValidateMobile:self.phoneField.text]) {
        self.registerButton.enabled = YES;
    } else {
        self.registerButton.enabled = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UI

- (void)setUpUI {
    __weak __typeof(&*self) weakSelf = self;
    self.phoneField = [[UITextField alloc] init];
    self.phoneField.placeholder = @"请输入手机号";
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.phoneField];

    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(30);
    }];
    
    self.codeField = [[UITextField alloc] init];
    self.codeField.placeholder = @"请输入验证码";
    self.codeField.keyboardType = UIKeyboardTypeNumberPad;
    [self.codeField addTarget:self action:@selector(textFieldsChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeField];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.phoneField.mas_bottom).with.offset(10);
        make.left.mas_equalTo(weakSelf.phoneField.mas_left);
        make.height.equalTo(weakSelf.phoneField.mas_height);
        make.width.mas_equalTo(257.5);
    }];
    
    self.countTimeLabel = [[UILabel alloc] init];
    self.countTimeLabel.font = [UIFont systemFontOfSize:15];
    self.countTimeLabel.textAlignment = NSTextAlignmentRight;
    self.countTimeLabel.text = @"获取验证码";
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countGetCodeTime)];
    [self.countTimeLabel addGestureRecognizer:tapGesture];
    self.countTimeLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.countTimeLabel];
    [self.countTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.codeField.mas_right);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(weakSelf.phoneField.mas_height);
        make.top.mas_equalTo(weakSelf.phoneField.mas_bottom).with.offset(10);
    }];

    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.registerButton];
    [self.registerButton setAdjustsImageWhenDisabled:NO];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    self.registerButton.enabled = NO;
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeField.mas_bottom).offset(30);
        make.left.mas_equalTo(weakSelf.phoneField.mas_left);
        make.right.mas_equalTo(weakSelf.phoneField.mas_right);
    }];
}

@end

