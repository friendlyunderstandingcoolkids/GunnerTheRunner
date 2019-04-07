//
//  HowViewController.m
//  GunnerTheRunner
//
//  Created by Gagandeep Heer on 2019-04-06.
//

#import "HowViewController.h"

@interface HowViewController () {
    
    __weak IBOutlet UIButton *backButton;
}
@end

@implementation HowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    backButton.layer.cornerRadius = 10;
}

- (IBAction)backToMain:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
}

@end

