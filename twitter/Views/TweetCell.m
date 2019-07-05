//
//  TweetCell.m
//  twitter
//
//  Created by cassanene on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "TimelineViewController.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateSelected];
    
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateSelected];
    
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
}
    // Configure the view for the selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)didTapLike:(id)sender {
    // TODO: Update the local tweet model
    if (self.tweet.favorited == YES) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        self.favoriteButton.selected = NO;
        self.favoritecountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
        
        [self networkCall];
    }
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        self.favoriteButton.selected = YES;
        self.favoritecountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
        [self networkCall];
    }
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        self.retweetButton.selected = NO;
        self.retweetcountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
        
        [self networkCall];
    }
    else {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        self.retweetButton.selected = YES;
        self.retweetcountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
        
        [self networkCall];
    }
    
}


-(void)networkCall {
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];

}



@end


