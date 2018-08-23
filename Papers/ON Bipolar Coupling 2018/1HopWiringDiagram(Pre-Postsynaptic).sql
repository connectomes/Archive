--This query grabs all synapses of a given cell, whether it is pre or post synaptic in the synapse.
SELECT QueryStruct.ID AS QuerySideID, QueryStruct.Label AS QuerySideLabel, 
	   Targ.TypeID AS QuerySideType, Targ.Confidence as QuerySideConfidence,
	   'Post' AS PreorPost,
	   StLk.Bidirectional AS Bidirectional, StLk.TargetID AS QuerySideSynapseID, StLk.SourceID AS OtherSideSynapseID,
	   Src.TypeID AS OtherSideType, Src.Confidence as OtherSideConfidence, SrcParent.ID AS OtherSideID, SrcParent.Label AS OtherSideLabel
FROM StructureLink AS StLK
INNER JOIN Structure Targ ON Targ.ID = STLK.TargetID
INNER JOIN Structure Src ON Src.ID = STLK.SourceID
INNER JOIN Structure SrcParent ON SrcParent.ID = Src.ParentID
INNER JOIN Structure QueryStruct ON QueryStruct.ID = Targ.ParentID
WHERE QueryStruct.ID = 7043 /*or whatever cell you want to query for*/ 

UNION

SELECT QueryStruct.ID AS QuerySideID, QueryStruct.Label AS QuerySideLabel, 
	   Src.TypeID AS QuerySideType, Src.Confidence as QuerySideConfidence, 
	   'Pre' AS PreorPost,
	   StLk.Bidirectional AS Bidirectional, StLk.SourceID AS QuerySideSynapseID, StLk.TargetID AS OtherSideSynapseID,
	   Targ.TypeID AS OtherSideType, Targ.Confidence as OtherSideConfidence,
	   TargParent.ID AS OtherSideID, TargParent.Label AS OtherSideLabel
FROM StructureLink AS StLK
INNER JOIN Structure Targ ON Targ.ID = STLK.TargetID
INNER JOIN Structure Src ON Src.ID = STLK.SourceID
INNER JOIN Structure QueryStruct ON QueryStruct.ID = Src.ParentID
INNER JOIN Structure TargParent ON TargParent.ID = Targ.ParentID
WHERE QueryStruct.ID = 7043 /*or whatever cell you want to query for*/ 

ORDER BY OtherSideID