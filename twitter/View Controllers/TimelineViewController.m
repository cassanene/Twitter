//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  used to give the table view information
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [UIApplication sharedApplication].delegate;
    
    [self getTimeline];
// added the selector to already created refreshcontrol in the interface
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    [self.activityIndicator startAnimating];
}


- (void)getTimeline {
    // Get timeline
    //    makes API request on your behalf
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            //            because it gets tweets back from the network
            
            self.tweets = [NSArray arrayWithArray:tweets];
            
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
                
            }
            [self.tableView reloadData];
            
//            [self.activityIndicator stopAnimating];
            
        } else {
            
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
//

        // Stop the activity indicator
        [self.activityIndicator stopAnimating];
        // Hides automatically if "Hides When Stopped" is enabled
        [self.refreshControl endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// #pragma mark - Navigation
//  In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//  Get the new view controller using [segue destinationViewController].
//  Pass the selected object to the new view controller.
     UINavigationController *navigationController = [segue destinationViewController];
     ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
     composeController.delegate = self;
 }


//tbale view asks for datasource and numofrows and cellForRow
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    TweetCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet* tweet = self.tweets[indexPath.row];
//    setting local tweet cell.
    cell.tweet = tweet;
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    cell.screennameLabel.text = tweet.user.name;
    cell.tweetLabel.text = tweet.text;
    cell.retweetcountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    
    cell.favoritecountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
    cell.timestampLabel.text = tweet.createdAtString;
    return cell;
}
- (IBAction)logoutButton:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
    
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


@end
