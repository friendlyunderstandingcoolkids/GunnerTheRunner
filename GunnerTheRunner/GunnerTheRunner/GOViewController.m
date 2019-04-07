//
//  GOViewController.m
//  GunnerTheRunner
//
//  Created by Renzo Pamplona on 2019-04-06.
//

#import "GOViewController.h"

@interface GOViewController () {
    
    __weak IBOutlet UIButton *backButton;
    __weak IBOutlet UILabel *scoreLabel;
    __weak IBOutlet UILabel *Message;
    __weak IBOutlet UILabel *EnemyLabel;
    NSMutableString *score;
    NSUserDefaults *_prefs;
    BOOL newHighScore;
    NSString *scoreMsg;
}
@end

@implementation GOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _prefs = [NSUserDefaults standardUserDefaults];
    backButton.layer.cornerRadius = 10;
    newHighScore = false;
    scoreMsg = @"New HighScore Achieved!";
    
    NSInteger lastscore = [_prefs integerForKey:@"lastscore"];
    NSInteger enemycount = [_prefs integerForKey:@"enemycount"];
    
    //COMPARING AND ADDING HIGHSCORE
    NSMutableArray *scores = [_prefs objectForKey:@"highscores"];
    NSNumber *newScore = [NSNumber numberWithInteger:(int)lastscore];
    NSLog(@"%@", scores);
    scores = [NSMutableArray arrayWithArray:[scores sortedArrayUsingSelector: @selector(compare:)]];
    NSLog(@"%@", scores);
    NSLog(@"%@", newScore);
    NSLog(@"%@", [scores objectAtIndex:0]);
    NSString *scoreNum = [NSString stringWithFormat:@"%d",(int)lastscore];
    if([scores objectAtIndex:0] < newScore){
        [scores replaceObjectAtIndex:0 withObject:newScore];
        Message.text = scoreMsg;
    }
    else{
        Message.text = @" ";
    }
    scoreLabel.text = scoreNum;
    EnemyLabel.text = [NSString stringWithFormat:@"Enemies Defeated: %ld", (long)enemycount];
    NSLog(@"%@", scores);
    [_prefs setObject:scores forKey:@"highscores"];
    [_prefs synchronize];
}


- (IBAction)BackButPress:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
}

@end

