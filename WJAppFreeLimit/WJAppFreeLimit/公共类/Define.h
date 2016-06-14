//
//  Define.h
//  YTLimitFree
//
//  Created by 余婷 on 16/6/11.
//  Copyright © 2016年 余婷. All rights reserved.
//

#ifndef Define_h
#define Define_h

/*
 界面类型
 */
#define kLimitType    @"limited"
#define kReduceType   @"down"
#define kFreeType     @"free"
#define kHotType      @"up"
#define kSubjectType  @"subject"

#pragma mark - 请求接口

//限免接口
#define kLimitUrl @"http://www.1000phone.net:8088/app/iAppFree/api/limited.php"
//page 分页
//number 数量
//search 搜索关键字
//cate_id 分类


//降价接口
#define kReduceUrl @"http://www.1000phone.net:8088/app/iAppFree/api/reduce.php?"
//page 分页
//number 数量
//search 搜索关键字
//cate_id 分类

//免费页面接口
#define kFreeUrl @"http://www.1000phone.net:8088/app/iAppFree/api/free.php"
//page 分页
//number 数量
//search 搜索关键字
//cate_id 分类

//专题页面接口
#define kSubjectUrl @"http://1000phone.net:8088/app/iAppFree/api/topic.php"
//page 分页
//number 数量


//热榜页面接口
#define kHotUrl @"http://1000phone.net:8088/app/iAppFree/api/hot.php"
//page 分页
//number 数量
//search 搜索关键字
//cate_id 分类


//分类界面接口
#define kCateUrl @"http://1000phone.net:8088/app/iAppFree/api/appcate.php"

//详情页面接口
//http://iappfree.candou.com:8080/free/applications/561692374?currency=rmb 
#define kDetailUrl @"http://iappfree.candou.com:8080/free/applications/%@?currency=rmb"

//周边使用应用接口:
//参数longitude,latitude填写经度和纬度。
#define kNearAppUrl @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=%lf&latitude=%lf"





#endif /* Define_h */



