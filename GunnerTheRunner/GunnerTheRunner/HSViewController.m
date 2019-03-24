//
//  HSViewController.m
//  GunnerTheRunner
//
//  Created by Gagan Heer on 2019-03-23.
//

#import "HSViewController.h"

@interface HSViewController () {

    __weak IBOutlet UIButton *backButton;
    __weak IBOutlet UILabel *scoreLabel;
    NSUserDefaults *_prefs;
    NSMutableArray *_scores;
    NSNumber *score1;
    NSNumber *score2;
    NSNumber *score3;
    NSNumber *score4;
    NSNumber *score5;
    NSMutableString *scorePrinter;
}
@end

@implementation HSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    backButton.layer.cornerRadius = 10;
    scorePrinter = [NSMutableString stringWithString:@""];
    _prefs = [NSUserDefaults standardUserDefaults];
    _scores = [_prefs objectForKey:@"highscores"];
    _scores = [NSMutableArray arrayWithArray:[_scores sortedArrayUsingSelector: @selector(compare:)]];
    score1 = [_scores objectAtIndex:4];
    score2 = [_scores objectAtIndex:3];
    score3 = [_scores objectAtIndex:2];
    score4 = [_scores objectAtIndex:1];
    score5 = [_scores objectAtIndex:0];
    [scorePrinter appendFormat:@"%s %@ %s %@ %s %@ %s %@ %s %@", "Score 1: ", score1, "\nScore 2: ", score2, "\nScore 3: ", score3, "\nScore 4: ", score4, "\nScore 5: ", score5];
    [scoreLabel setText:scorePrinter];
}

- (IBAction)backToMain:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
}

@end
