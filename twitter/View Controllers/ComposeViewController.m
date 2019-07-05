//
//  ComposeViewController.m
//  twitter
//
//  Created by cassanene on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"


@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.closeButton.target = self;
    self.closeButton.action = @selector(barButtonCustomPressed:);

    // Do any additional setup after loading the view.
}

- (void) textViewDidBeginEditing:(UITextView* )textView{
    [textView setText:@""];
}

//this dismiss the module after the close button is pressed
-(IBAction)barButtonCustomPressed:(UIBarButtonItem*)btn
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetButton:(id)sender {
    [[APIManager shared] postStatusWithText:[self.composeTextView text] completion:^(Tweet *tweet, NSError *error) {
        if (tweet) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
        } else {
            
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self dismissModalViewControllerAnimated:YES];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
