declare @SetA integer_list

declare @SetB integer_list

 

insert into @SetA select ID from Structure where Label = 'CBb4'

insert into @SetB select ID from Structure where Label = 'CBb4w'

 

Select CS.A_ID as AID, CS.B_ID as BID, SSVA.ConvexHull ConvexHullA, SSVB.ConvexHull ConvexHullB, SSVA.ConvexHull.STIntersection(SSVB.ConvexHull) as Intersection, SSVA.ConvexHull.STIntersection(SSVB.ConvexHull).STArea() / SSVA.ConvexHull.STArea() as Overlap

from (select A.ID as A_ID, B.ID as B_ID from @SetA A, @SetB B) CS

       inner join StructureSpatialCache SSVA ON SSVA.ID = CS.A_ID

       inner join StructureSpatialCache SSVB ON SSVB.ID = CS.B_ID

       WHERE SSVB.ConvexHull.STIntersects(SSVA.ConvexHull) = 1