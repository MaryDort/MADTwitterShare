//
//  ViewController.m
//  MADTwitterShare
//
//  Created by Mariia Cherniuk on 07.07.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *twittTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureTextView];
}

- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender {
    if (_twittTextView.isFirstResponder) {
        [_twittTextView resignFirstResponder];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Tweet your note" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
     UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         
         if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
             SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
             
             if (_twittTextView.text.length < 140) {
                 [composeVC setInitialText:_twittTextView.text];
             } else {
                 [composeVC setInitialText:[_twittTextView.text substringToIndex:140]];
             }
             [self presentViewController:composeVC animated:YES completion:nil];
         } else {
             [self alertMessage:@"You are not singed in to twitter"];
         }
     }];
    
    [alertController addAction:tweetAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)configureTextView {
    _twittTextView.layer.cornerRadius = 20.f;
    _twittTextView.layer.borderWidth = 2.f;
}

- (void)alertMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"TwitterShare" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
