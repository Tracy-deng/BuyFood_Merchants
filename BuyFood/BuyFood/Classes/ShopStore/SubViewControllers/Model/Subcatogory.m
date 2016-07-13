#import "Subcatogory.h"

@implementation Subcatogory


-(void)encodeWithCoder:(NSCoder *)aCoder{
  [aCoder encodeObject:_pagesize forKey:@"pagesize"];
  [aCoder encodeObject:_categoryname forKey:@"categoryname"];
//  [aCoder encodeObject:_userid forKey:@"userid"];
  [aCoder encodeObject:_categoryid forKey:@"categoryid"];
  [aCoder encodeObject:_markettypeid forKey:@"markettypeid"];
  [aCoder encodeObject:_modifytime forKey:@"modifytime"];
  [aCoder encodeObject:_pic forKey:@"pic"];
  [aCoder encodeObject:_threecategoryname forKey:@"threecategoryname"];
  [aCoder encodeObject:_pageindex forKey:@"pageindex"];
  [aCoder encodeObject:_subcategoryname forKey:@"subcategoryname"];
  [aCoder encodeObject:_remark forKey:@"remark"];
  [aCoder encodeObject:_threecategoryid forKey:@"threecategoryid"];
  [aCoder encodeObject:_subcategoryid forKey:@"subcategoryid"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
 self = [super init];
   if(self){
      _pagesize =   [aDecoder decodeObjectForKey:@"pagesize"];
      _categoryname =   [aDecoder decodeObjectForKey:@"categoryname"];
//      _userid =   [aDecoder decodeObjectForKey:@"userid"];
      _categoryid =   [aDecoder decodeObjectForKey:@"categoryid"];
      _markettypeid =   [aDecoder decodeObjectForKey:@"markettypeid"];
      _modifytime =   [aDecoder decodeObjectForKey:@"modifytime"];
      _pic =   [aDecoder decodeObjectForKey:@"pic"];
      _threecategoryname =   [aDecoder decodeObjectForKey:@"threecategoryname"];
      _pageindex =   [aDecoder decodeObjectForKey:@"pageindex"];
      _subcategoryname =   [aDecoder decodeObjectForKey:@"subcategoryname"];
      _remark =   [aDecoder decodeObjectForKey:@"remark"];
      _threecategoryid =   [aDecoder decodeObjectForKey:@"threecategoryid"];
      _subcategoryid =   [aDecoder decodeObjectForKey:@"subcategoryid"];
  }
return self;
}@end