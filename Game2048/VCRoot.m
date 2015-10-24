//
//  VCRoot.m
//  Game2048
//
//  Created by qianfeng on 14-8-25.
//  Copyright (c) 2014年 gao. All rights reserved.
//

#import "VCRoot.h"

@interface VCRoot ()

@end

@implementation VCRoot

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _arrayLabels = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *scoreLabel = [[UILabel alloc] init];
    scoreLabel.frame = CGRectMake(35, 40, 250, 40);
    scoreLabel.layer.backgroundColor = [UIColor orangeColor].CGColor;
    scoreLabel.layer.cornerRadius = 3;
    scoreLabel.font = [UIFont systemFontOfSize:30];
    scoreLabel.text = @"最大值为:";
    [self.view addSubview:scoreLabel];
    
    _MAXScore = [[UILabel alloc] init];
    _MAXScore.frame = CGRectMake(125, 0, 125, 40);
//    _MAXScore.text = @"0";
    _MAXScore.font = [UIFont systemFontOfSize:30];
    _MAXScore.textAlignment = NSTextAlignmentCenter;
    [scoreLabel addSubview:_MAXScore];
    
    //创建背景视图
    _bgView = [[UIView alloc] init];
    _bgView.frame = CGRectMake(35, 100, 250, 250);
    _bgView.layer.backgroundColor = [UIColor colorWithRed:0.861 green:0.572 blue:0.285 alpha:1.000].CGColor;
    _bgView.layer.cornerRadius = 3;
    //关闭手势操作
    _bgView.userInteractionEnabled = NO;
    
    //在背景视图上添加16个label用于显示数字
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(10+j*60, 10+i*60, 50, 50);
            label.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
            label.layer.cornerRadius = 3;
            label.tag = 1+4*i+j;
            label.font = [UIFont systemFontOfSize:30];
            label.textAlignment = NSTextAlignmentCenter;
            [_bgView addSubview:label];
        }
    }
    //添加背景视图
    [self.view addSubview:_bgView];
    
    //创建开始按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startBtn.frame = CGRectMake(130, 370, 60, 30);
    startBtn.layer.backgroundColor = [UIColor orangeColor].CGColor;
    startBtn.layer.cornerRadius = 3;
    [startBtn setTitle:@"开始游戏" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(btnStart) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startBtn];
    
    //创建4个方向的滑动手势
    for (int i = 0; i < 4; i++) {
        UISwipeGestureRecognizer *sw = [[UISwipeGestureRecognizer alloc] init];
        switch (i) {
            case 0:sw.direction = UISwipeGestureRecognizerDirectionRight; break;
            case 1:sw.direction = UISwipeGestureRecognizerDirectionLeft;  break;
            case 2:sw.direction = UISwipeGestureRecognizerDirectionUp;    break;
            case 3:sw.direction = UISwipeGestureRecognizerDirectionDown;  break;
        }
        [sw addTarget:self action:@selector(swAct:)];
        [_bgView addGestureRecognizer:sw];
    }
}
//滑动手势
- (void)swAct:(UISwipeGestureRecognizer *)sw
{
    switch (sw.direction) {
        case 1:
            [self right];
            NSLog(@"right!");
            break;
        case 2:
            [self left];
            NSLog(@"left!");
            break;
        case 4:
            [self up];
            NSLog(@"up!");
            break;
        case 8:
            [self down];
            NSLog(@"down!");
            break;
    }
    
    for (int i = 1; i <= 16; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:i];
        if (label.text!=nil) {
            switch ([label.text intValue]) {
                case 2:label.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 4:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.751 blue:0.589 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 8:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.723 blue:0.339 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 16:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.519 blue:0.418 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 32:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.313 blue:0.191 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 64:label.backgroundColor = [UIColor colorWithRed:0.953 green:0.184 blue:0.127 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 128:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.829 blue:0.246 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 256:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.945 blue:0.209 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 512:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.490 blue:0.724 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                case 1024:label.backgroundColor = [UIColor colorWithRed:0.883 green:0.000 blue:0.883 alpha:1.000];label.font = [UIFont systemFontOfSize:20];break;
                case 2048:label.backgroundColor = [UIColor purpleColor];label.font = [UIFont systemFontOfSize:20];break;
                case 4096:label.backgroundColor = [UIColor colorWithRed:0.420 green:1.000 blue:0.428 alpha:1.000];label.font = [UIFont systemFontOfSize:20];break;
                case 8192:label.backgroundColor = [UIColor colorWithRed:0.300 green:1.000 blue:0.782 alpha:1.000];label.font = [UIFont systemFontOfSize:20];break;
                case 16384:label.backgroundColor = [UIColor blueColor];label.font = [UIFont systemFontOfSize:16];break;
                default:break;
            }
        }
        else
            label.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
        if (label.text != nil && [label.text intValue]>maxScore) {
            maxScore = [label.text intValue];
        }
    }
    _MAXScore.text = [NSString stringWithFormat:@"%d",maxScore];
}
BOOL isStart = NO;
//开始按钮
- (void)btnStart
{
    if (isStart == NO) {
        //开启手势操作
        _bgView.userInteractionEnabled = YES;
        UILabel *label = (UILabel *)[self.view viewWithTag:arc4random()%16+1];
        label.text = @"2";
        [self putNum];
        isStart = YES;
        for (int i = 1; i <= 16; i++) {
            UILabel *label = (UILabel *)[self.view viewWithTag:i];
            if (label.text!=nil) {
                switch ([label.text intValue]) {
                    case 2:label.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                    case 4:label.backgroundColor = [UIColor colorWithRed:1.000 green:0.751 blue:0.589 alpha:1.000];label.font = [UIFont systemFontOfSize:30];break;
                }
            }
            else
                label.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
            if (label.text != nil && [label.text intValue]>maxScore) {
                maxScore = [label.text intValue];
            }
        }
        _MAXScore.text = [NSString stringWithFormat:@"%d",maxScore];
    }
}
//生成新数字
- (void)putNum
{
    for (int i = 0; i < 16; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:i+1];
        if (label.text == nil) {
            [_arrayLabels addObject:label];
        }
    }
    if (_arrayLabels.count == 0) {
        return;
    }
    int index = arc4random()%(_arrayLabels.count);
    UILabel *label = _arrayLabels[index];
    if (arc4random()%8>6) {
        label.text = @"4";
    }
    else
        label.text = @"2";
    
    if (_arrayLabels.count == 1) {
        //横向比较
        for (int i = 0; i < 4; i++) {
            int temp = 0;
            for (int j = 0; j < 4; j++) {
                UILabel *label = (UILabel *)[self.view viewWithTag:1+4*i+j];
                if ([label.text intValue] == temp) {
                    [_arrayLabels removeAllObjects];
                    return;
                }
                temp = [label.text intValue];
            }
        }
        //纵向比较
        for (int i = 0; i < 4; i++) {
            int temp = 0;
            for (int j = 0; j < 4; j++) {
                UILabel *label = (UILabel *)[self.view viewWithTag:1+i+4*j];
                if ([label.text intValue] == temp) {
                    [_arrayLabels removeAllObjects];
                    return;
                }
                temp = [label.text intValue];
            }
        }

        [self gameover];
    }
    [_arrayLabels removeAllObjects];
}
//游戏结束
- (void)gameover
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"GameOver" message:@"游戏结束,是否重玩一局!!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重玩", nil];
    //显示对话框
    [alertView show];
}
//当点击一个对话框的按钮时调用此协议函数
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    for (int i = 0; i < 16; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:i+1];
        label.text = nil;
        label.backgroundColor = [UIColor colorWithWhite:0.746 alpha:1.000];
    }
    isStart = NO;
    //cancelButton的索引值为0
    if (buttonIndex == 0) {
        //关闭手势操作
        _bgView.userInteractionEnabled = NO;
        maxScore = 0;
        _MAXScore.text = nil;
    }
    else
    {
        [self btnStart];
    }
}

//向右滑
- (void)right
{
    isChangeR = NO;
    //先全部右移到顶
    [self moveRight];
    //再进行叠加
    for (int i = 0; i < 4; i++)
    {
        for (int j = 3; j > 0; j--)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+4*i+j];//取第一个
            NSLog(@"label(%d) = %@",label.tag,label.text);
            if (label.text != nil)
            {
                //第一个不为空取第二个
                UILabel *label1 = (UILabel *)[self.view viewWithTag:1+4*i+j-1];
                NSLog(@"label1(%d) = %@",label1.tag,label1.text);
                if (label1.text != nil) {
                    //第二个也不为空比较
                    if ([label.text intValue] == [label1.text intValue])
                    {
                        label.text = [NSString stringWithFormat:@"%d",[label.text intValue]*2];
                        NSLog(@"相加后(%d) = %@",label.tag,label.text);
                        label1.text = nil;
                        [self moveRight];
                        isChangeR = YES;
                    }
                }
                else{
                    break;
                }
            }
            else{
                break;
            }
        }
    }
    if (isChangeR) {
        [self putNum];
    }
}
//右移
- (void)moveRight
{
    for (int i = 0; i < 4; i++)
    {
        int index = i*4+4;
        for (int j = 3; j >= 0; j--)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+4*i+j];
            if (label.text != nil)
            {
                UILabel *label1 = (UILabel *)[self.view viewWithTag:index];
                if (label != label1)
                {
                    label1.text = label.text;
                    label.text = nil;
                    isChangeR = YES;
                }
                index--;
            }
        }
    }
}

//向左滑
- (void)left
{
    isChangeL = NO;
    //先全部左移到顶
    [self moveLeft];
    //再进行叠加
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+4*i+j];//取第一个
            NSLog(@"label(%d) = %@",label.tag,label.text);
            if (label.text != nil)
            {
                //第一个不为空取第二个
                UILabel *label1 = (UILabel *)[self.view viewWithTag:1+4*i+j+1];
                NSLog(@"label1(%d) = %@",label1.tag,label1.text);
                if (label1.text != nil) {
                    //第二个也不为空比较
                    if ([label.text intValue] == [label1.text intValue])
                    {
                        label.text = [NSString stringWithFormat:@"%d",[label.text intValue]*2];
                        NSLog(@"相加后(%d) = %@",label.tag,label.text);
                        label1.text = nil;
                        [self moveLeft];
                        isChangeL = YES;
                    }
                }
                else{
                    break;
                }
            }
            else{
                break;
            }
        }
    }

    if (isChangeL) {
        [self putNum];
    }
}
//左移
- (void)moveLeft
{
    for (int i = 0; i < 4; i++)
    {
        int index = i*4+1;
        for (int j = 0; j < 4; j++)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+4*i+j];
            if (label.text != nil)
            {
                UILabel *label1 = (UILabel *)[self.view viewWithTag:index];
                if (label != label1)
                {
                    label1.text = label.text;
                    label.text = nil;
                    isChangeL = YES;
                }
                index++;
            }
        }
    }
}

//向上滑
- (void)up
{
    isChangeU = NO;
    //先全部上移到顶
    [self moveUp];
    //再进行叠加
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+i+4*j];//取第一个
            NSLog(@"label(%d) = %@",label.tag,label.text);
            if (label.text != nil)
            {
                //第一个不为空取第二个
                UILabel *label1 = (UILabel *)[self.view viewWithTag:1+i+4*j+4];
                NSLog(@"label1(%d) = %@",label1.tag,label1.text);
                if (label1.text != nil) {
                    //第二个也不为空比较
                    if ([label.text intValue] == [label1.text intValue])
                    {
                        label.text = [NSString stringWithFormat:@"%d",[label.text intValue]*2];
                        NSLog(@"相加后(%d) = %@",label.tag,label.text);
                        label1.text = nil;
                        [self moveUp];
                        isChangeU = YES;
                    }
                }
                else{
                    break;
                }
            }
            else{
                break;
            }
        }
    }

    if (isChangeU) {
        [self putNum];
    }
}
//上移
- (void)moveUp
{
    for (int i = 0; i < 4; i++)
    {
        int index = i+1;
        for (int j = 0; j < 4; j++)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+i+4*j];
            if (label.text != nil)
            {
                UILabel *label1 = (UILabel *)[self.view viewWithTag:index];
                if (label != label1)
                {
                    label1.text = label.text;
                    label.text = nil;
                    isChangeU = YES;
                }
                index += 4;
            }
        }
    }

}

//向下滑
- (void)down
{
    isChangeD = NO;
    //先全部下移到顶
    [self moveDown];
    //再进行叠加
    for (int i = 0; i < 4; i++)
    {
        for (int j = 3; j > 0; j--)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+i+4*j];//取第一个
            NSLog(@"label(%d) = %@",label.tag,label.text);
            if (label.text != nil)
            {
                //第一个不为空取第二个
                UILabel *label1 = (UILabel *)[self.view viewWithTag:1+i+4*j-4];
                NSLog(@"label1(%d) = %@",label1.tag,label1.text);
                if (label1.text != nil) {
                    //第二个也不为空比较
                    if ([label.text intValue] == [label1.text intValue])
                    {
                        label.text = [NSString stringWithFormat:@"%d",[label.text intValue]*2];
                        NSLog(@"相加后(%d) = %@",label.tag,label.text);
                        label1.text = nil;
                        [self moveDown];
                        isChangeD = YES;
                    }
                }
                else{
                    break;
                }
            }
            else{
                break;
            }
        }
    }

    if (isChangeD) {
        [self putNum];
    }
}
//下移
-(void)moveDown
{
    for (int i = 0; i < 4; i++)
    {
        int index = i+13;
        for (int j = 3; j >= 0; j--)
        {
            UILabel *label = (UILabel *)[self.view viewWithTag:1+i+4*j];
            if (label.text != nil)
            {
                UILabel *label1 = (UILabel *)[self.view viewWithTag:index];
                if (label != label1)
                {
                    label1.text = label.text;
                    label.text = nil;
                    isChangeD = YES;
                }
                index -= 4;
            }
        }
    }

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
