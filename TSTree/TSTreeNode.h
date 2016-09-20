//
//  TSTree.h
//  TSTree
//
//  Created by Punit Kulkarni on 9/20/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTreeNode : NSObject

- (void)parseDataSet:(NSArray *)dataSet;
- (NSSet*)findValuesForTerm:(NSString*)value;

@end
