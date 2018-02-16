
DECLARE @user table(
	UserId int identity(1,1), 
	UserName nvarchar(50) 
);

INSERT INTO @user SELECT (N'RM Name'); 
INSERT INTO @user SELECT (N'Credit Name'); 
INSERT INTO @user SELECT (N'Legal Name'); 
INSERT INTO @user SELECT (N'HOD Name'); 
-- SELECT * FROM @user

DECLARE @process table(
	processId int identity(1,1), 
	processName nvarchar(50)
)
INSERT INTO @process 
SELECT (N'Loan Approval'); 

-- SELECT * FROM @process;

DECLARE @Request table( 
	requestId int identity(1,1), 
	processId int, 
	title nvarchar(300), 
	Daterequested datetime default CURRENT_TIMESTAMP, 
	UserId int, 
	CurrentStateId int 
); 

-- Insert part of Process
INSERT INTO @Request 
SELECT 1, N'Request for Credit Approval', CURRENT_TIMESTAMP, 1, 1;  

-- SELECT * FROM @Request

DECLARE @RequestData table(
	requestData int identity(1,1), 
	requestId int, 
	[name] nvarchar(200), 
	[value] nvarchar(200) 
); 

INSERT INTO @RequestData 
          SELECT 1, N'Commercials', N'Reference to Commericals Details' 
UNION ALL SELECT 1, N'CP', N'Reference to CP' 
UNION ALL SELECT 1, N'CS', N'Reference to CS' 
UNION ALL SELECT 1, N'Security Details', N'Reference to Security Details' 
;

-- SELECT * FROM @RequestData;

-- Gives us the Rquestor and Request data type with reference to the data
-- SELECT 
--  p.processId,p.processName,u.UserName as 'Requested By'
-- ,r.requestId,r.title,rd.requestData,rd.name 'Request Data Type'
-- ,rd.value 'Request Data Value'
-- ,shu.UserName
-- FROM @RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId
--	INNER JOIN @process AS p ON p.processId = r.processId
--	INNER JOIN @user AS u ON u.UserId = r.UserId; 


DECLARE @Stakeholders table(
	requestId int, 
	userId int 
);

 INSERT INTO @Stakeholders
           SELECT 1, 1 
 UNION ALL SELECT 1, 2 
;

 -- Gives us Stakeholder assigned to Request
-- SELECT 
--  p.processId,p.processName,u.UserName as 'Requested By'
-- ,r.requestId,r.title,rd.requestData,rd.name 'Request Data Type' 
-- ,rd.value 'Request Data Value'
-- ,shu.UserName
-- FROM @RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId 
--	INNER JOIN @process AS p ON p.processId = r.processId 
--	INNER JOIN @user AS u ON u.UserId = r.UserId 
--	INNER JOIN @Stakeholders AS sh ON r.requestId = sh.requestId 
--	INNER JOIN @user AS shu ON shu.UserId =sh.userId; 


DECLARE @requestNote table( 
	requestNoteId int identity(1,1), 
	requestId int, 
	userId int, 
	note nvarchar(200) 
); 

 INSERT INTO @requestNote 
 SELECT 1, 1, N'Note 1' 
;

-- Gives us Request Notes to Request

-- SELECT 
--  p.processId,p.processName,u.UserName as 'Requested By' 
-- ,r.requestId,r.title,rd.requestData,rd.name 'Request Data Type' 
-- ,rd.value 'Request Data Value' 
-- ,rn.note 'Request Notes',un.UserName 'Notes Given by' 
-- FROM @RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId 
--	INNER JOIN @process AS p ON p.processId = r.processId 
--	INNER JOIN @user AS u ON u.UserId = r.UserId 
--	INNER JOIN @requestNote AS rn ON rn.requestId = r.requestId 
--	INNER JOIN @user AS un ON un.UserId = rn.userId; 

DECLARE @stateType table(
	statetypeid int identity(1,1), 
	[name] nvarchar(200) 
); 

INSERT INTO @stateType 
          SELECT N'Start' 
UNION ALL SELECT N'Normal' 
UNION ALL SELECT N'Complete' 
UNION ALL SELECT N'Denied' 
UNION ALL SELECT N'Cancelled' 
;

DECLARE @state table( 
	[stateid] int identity(1,1), 
	statetypeid int, 
	processid int, 
	[name] nvarchar(200), 
	[description] nvarchar(200) 
); 

INSERT INTO @state 
          SELECT 1, 1, N'Credit Approval Started', N'Credit Approval Started' 
UNION ALL SELECT 3, 1, N'Credit Approval Completed', N'Credit Approval Completed' 
UNION ALL SELECT 1, 1, N'Legal Approval Completed', N'Legal Approval Completed' 
UNION ALL SELECT 3, 1, N'Legal Approval Completed', N'Legal Approval Completed' 
;

-- SELECT * FROM @state; 


DECLARE @transition table( 
	 [transitionId] int -- identity(1,1) 
	,[processId] int 
	,[currentStateId] int 
	,[nextStateId] int 
); 


INSERT INTO @transition 
SELECT 1, 1, 1, 3 
;

SELECT * FROM @transition; 

DECLARE @actionType table( 
	actionTypeId int identity(1,1), 
	[Name] nvarchar(50) 
); 

INSERT INTO @actionType 
          SELECT N'Approve' 
UNION ALL SELECT N'Cancel' 
UNION ALL SELECT N'Deny' 
UNION ALL SELECT N'Restart' 
UNION ALL SELECT N'Resolve' 
; 

SELECT * FROM @actionType; 



DECLARE @action table(
	actionid int identity(1,1), 
	actionTypeId int, 
	processId int, 
	[name] nvarchar(200), 
	[description] nvarchar(200) 
); 

SELECT * FROM @action; 

DECLARE @transitionaction table( 
	transitionid int, 
	actionid int 
); 

SELECT * FROM @transitionaction; 

DECLARE @activityType table( 
	activityTypeId int identity(1,1), 
	[name] nvarchar(200) 
); 

INSERT INTO @activityType 
          SELECT N'Add Note' 
UNION ALL SELECT N'Add Stackholder' 
UNION ALL SELECT N'Send Email' 
; 


SELECT * FROM @activityType;  


DECLARE @activity table( 
	activityId int identity(1,1), 
	activityTypeId int, 
	ProcessId int, 
	[Name] nvarchar(300), 
	[Description] nvarchar(300) 
); 

SELECT * FROM @activity; 


--- Who can perform what actions and receive the activities
DECLARE @groups table( 
	groupId int identity(1,1), 
	processId int, 
	[Name] nvarchar(200) 
); 

SELECT * FROM @groups; 

DECLARE @groupmembers table(
	groupid int, 
	userid int 
); 

SELECT * FROM @groupmembers; 
-- Set of standardized representations of a person who have specific roles relative to a Request or Process 

-- Request Creator (Requester)
-- Request Stakeholders
-- Group Members
-- Process Admins

DECLARE @Target table(
	targetId int identity(1,1), 
	[name] nvarchar(200), 
	[Description] nvarchar(200) 
); 

INSERT INTO @Target	
          SELECT N'Request Creator (Requester)', N'Request Creator (Requester)' 
UNION ALL SELECT N'Request Stakeholders', N'Request Stakeholders' 
UNION ALL SELECT N'Group Members', N'Group Members' 
UNION ALL SELECT N'Process Admins', N'Process Admins' 
; 

SELECT * FROM @Target; 

-- As people who can perform Actions 
-- As people who can receive Activities 

DECLARE @actionTarget table(
	actionTargetId int identity(1,1), 
	actionId int, 
	targetId int, 
	groupId int 
); 


SELECT * FROM @actionTarget; 

DECLARE @requestAction table(
	requestAction int identity(1,1), 
	requestId int, 
	actionId int, 
	transitionId int, 
	isactive bit, 
	iscomplete bit 
); 

SELECT * FROM @requestAction;
