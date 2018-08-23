SELECT ParentID, geometry::ConvexHullAggregate(VolumeShape).STArea() 
FROM location WHERE ParentID IN (SELECT ID FROM Structure WHERE TypeID='1') 
GROUP BY ParentID

SELECT ParentID, geometry::ConvexHullAggregate(VolumeShape).STArea() 
FROM location WHERE ParentID IN (6117) 
GROUP BY ParentID
