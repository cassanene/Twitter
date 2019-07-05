//
//  TweetCell.m
//  twitter
//
//  Created by cassanene on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
    // Configure the view for the selected state
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)didTapLike:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // TODO: Update cell UI
}

[[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
    if(error){
        NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
    }
    else{
        NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
    }
}];





@end
