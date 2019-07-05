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
        NSLog(@"COunt - 1");
        self.favoriteButton.selected = NO;
        NSLog(@"YOU TAPPED 😘");
        self.favoritecountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    }
    
    else {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        NSLog(@"Count is: %d", self.tweet.favoriteCount);
        NSLog(@"Count +1");
        self.favoriteButton.selected = YES;
        NSLog(@"YOU UNTAPPED 😞");
        self.favoritecountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    }
    // TODO: Update cell UI
//    [self refreshData];
}

//-(void)refreshData {
//    _favoritecountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
//}





@end
