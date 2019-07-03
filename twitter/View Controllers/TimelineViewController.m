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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>


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
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    [self.activityIndicator startAnimating];
    
    
    

    
    
    
    
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

        } else {

            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        

        
        // Stop the activity indicator
        // Hides automatically if "Hides When Stopped" is enabled
        [self.activityIndicator stopAnimating];

    }];
    
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl

//- (void)beginRefresh:(UIRefreshControl *)refreshControl {
//
//    // Create NSURL and NSURLRequest
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//                                                          delegate:nil
//                                                     delegateQueue:[NSOperationQueue mainQueue]];
//    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//                                                // ... Use the new data to update the data source ...
//
//                                                // Reload the tableView now that there is new data
//                                                [self.tableView reloadData];
//
//                                                // Tell the refreshControl to stop spinning
//                                                [refreshControl endRefreshing];
//
//                                            }];
//
//    [task resume];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//tbale view asks for datasource and numofrows and cellForRow
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    TweetCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet* tweet = self.tweets[indexPath.row];
    
    
    cell.usernameLabel.text = tweet.user.name;
    cell.screennameLabel.text = tweet.user.screenName;
    cell.tweetLabel.text = tweet.text;
    

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


@end
