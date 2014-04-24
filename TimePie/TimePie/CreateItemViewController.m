//
//  CreateItemViewController.m
//  TimePie
//
//  Created by Storm Max on 3/27/14.
//  Copyright (c) 2014 TimePieOrg. All rights reserved.
//

#import "CreateItemViewController.h"
#import "BasicUIColor+UIPosition.h"
#import <QuartzCore/QuartzCore.h>

@interface CreateItemViewController ()

@end

@implementation CreateItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavBar];
    [self initMainVessel];
    [NSTimer scheduledTimerWithTimeInterval:0.033f target:self
                                   selector:@selector(mainLoop:) userInfo:nil repeats:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(respondInput:) withObject:self afterDelay:0.033f];
}

- (void) mainLoop: (id) sender
{
    if(inputField.text.length > 0) initInputLabel.text = @"";
    else initInputLabel.text = @"名称";
    [NSTimer scheduledTimerWithTimeInterval:0.033f target:self
                                   selector:@selector(mainLoop:) userInfo:nil repeats:NO];
}

- (void)respondInput:(id)sender
{
    [inputField becomeFirstResponder];
}

- (void)initNavBar
{
    UIButton *tempBtn_cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 22)];
    [tempBtn_cancel setImage:[UIImage imageNamed:@"CIVC_cancelButton"] forState:UIControlStateNormal];
    [tempBtn_cancel addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:tempBtn_cancel];
    UIButton *tempBtn_confirm = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 22)];
    [tempBtn_confirm setImage:[UIImage imageNamed:@"CIVC_confirmButton"] forState:UIControlStateNormal];
    [tempBtn_confirm addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc] initWithCustomView:tempBtn_confirm];
    
    self.title = @"新建事项";
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = confirmButton;
    [self navigationController].navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: MAIN_UI_COLOR};
}

- (void)initMainVessel
{
    _CIVC_mainVessel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _CIVC_mainVessel.separatorInset = UIEdgeInsetsZero;
    _CIVC_mainVessel.dataSource = self;
    _CIVC_mainVessel.delegate = self;
    _CIVC_mainVessel.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    [self.view addSubview:_CIVC_mainVessel];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    NSInteger row = indexPath.row;
    tagTextArray = [[NSMutableArray alloc] initWithObjects:@"工作",@"学习", nil];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if (row == 0)
    {
        [self initTextFieldInView:cell];
    }
    else if(row >= 1 && row <= 2)
    {
        [self initTagCellView:cell withIndexPath:indexPath];
    }
    else if(row == 3)
    {
        [self initAddTagButtonInView:cell];
    }
    else
    {
        [self initRoutineCell:cell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

#pragma mark - target selector
- (void)cancelButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)routineButtonPressed:(id)sender
{
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"AddRoutineButtonNormal"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    } else {
        [sender setImage:[UIImage imageNamed:@"AddRoutineButtonActive"] forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
}

- (void)addTagButtonPressed:(id)sender
{
    
}

#pragma mark - utilities methods
- (void)initTextFieldInView:(UIView*)view
{
    colorTag = [[UIView alloc] initWithFrame:CGRectMake(10, 14, 20, 20)];
    colorTag.backgroundColor = PINKNO04;
    [self setRoundedView:colorTag toDiameter:16];
    [view addSubview:colorTag];
    inputField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH, 48)];
    [view addSubview:inputField];
    initInputLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 48)];
    initInputLabel.text = @"名称";
    initInputLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
    [view addSubview:initInputLabel];
}

-(void)setRoundedView:(UIView *)roundedView toDiameter:(float)newSize;
{
    roundedView.clipsToBounds = YES;
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}

- (void)initTagCellView:(UIView*)view withIndexPath:(NSIndexPath*)indexPath
{
    UILabel *tempTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 48)];
    tempTagLabel.text = [tagTextArray objectAtIndex:indexPath.row - 1];
    [view addSubview:tempTagLabel];
}

- (void)initAddTagButtonInView:(UIView*)view
{
    addTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 48)];
    addTagLabel.text = @"新建标签";
    addTagLabel.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.0];
    [view addSubview:addTagLabel];
}

- (void)initRoutineCell:(UIView*)view
{
    routineButton = [[UIButton alloc] initWithFrame:CGRectMake(0, -1, SCREEN_WIDTH, 48)];
    [routineButton setImage:[UIImage imageNamed:@"AddRoutineButtonNormal"] forState:UIControlStateNormal];
    [routineButton addTarget:self action:@selector(routineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:routineButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
