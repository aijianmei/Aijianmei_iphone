//
//  WorkoutDetailViewController.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-6.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "Article.h"


@interface WorkoutDetailViewController :PPViewController

{
    Article *_article;
}

@property(nonatomic, retain) Article *article;


@end
