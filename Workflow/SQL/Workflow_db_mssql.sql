
CREATE TABLE "user" 
( 
	 UserId int IDENTITY(1,1) 
	,UserName national character varying(50) 
);

INSERT INTO "user"(UserName) SELECT (N'RM Name'); 
INSERT INTO "user"(UserName) SELECT (N'Credit Name'); 
INSERT INTO "user"(UserName) SELECT (N'Legal Name'); 
INSERT INTO "user"(UserName) SELECT (N'HOD Name'); 
-- SELECT * FROM user

CREATE TABLE process 
( 
	 processId int IDENTITY(1,1) 
	,processName national character varying(50) 
)
INSERT INTO process(processName) 
SELECT (N'Loan Approval'); 

-- SELECT * FROM process;

CREATE TABLE Request 
( 
	 requestId int IDENTITY(1,1)
	,processId int
	,title national character varying(300)
	,Daterequested datetime default CURRENT_TIMESTAMP
	,UserId int
	,CurrentStateId int 
); 

-- Insert part of Process
INSERT INTO Request(processId, title, Daterequested, UserId, CurrentStateId) 
SELECT 1, N'Request for Credit Approval', CURRENT_TIMESTAMP, 1, 1;  

-- SELECT * FROM Request

CREATE TABLE RequestData 
( 
	 requestdata int IDENTITY(1, 1) 
	,requestid int 
	,"name" national character varying(200) 
	,"value" national character varying(200) 
); 

INSERT INTO RequestData(requestId, "name", "value") 
          SELECT 1, N'Commercials', N'Reference to Commericals Details' 
UNION ALL SELECT 1, N'CP', N'Reference to CP' 
UNION ALL SELECT 1, N'CS', N'Reference to CS' 
UNION ALL SELECT 1, N'Security Details', N'Reference to Security Details' 
;

-- SELECT * FROM RequestData;

-- Gives us the Rquestor and Request data type with reference to the data
-- SELECT 
--  p.processId,p.processName,u.UserName as 'Requested By'
-- ,r.requestId,r.title,rd.requestData,rd.name 'Request Data Type'
-- ,rd.value 'Request Data Value'
-- ,shu.UserName
-- FROM RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId
--	INNER JOIN @process AS p ON p.processId = r.processId
--	INNER JOIN @user AS u ON u.UserId = r.UserId; 


CREATE TABLE Stakeholders 
( 
	 requestId int 
	,userId int 
);

 INSERT INTO Stakeholders 
           SELECT 1, 1 
 UNION ALL SELECT 1, 2 
;

 -- Gives us Stakeholder assigned to Request
-- SELECT 
--  p.processId,p.processName,u.UserName as 'Requested By'
-- ,r.requestId,r.title,rd.requestData,rd.name 'Request Data Type' 
-- ,rd.value 'Request Data Value'
-- ,shu.UserName
-- FROM RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId 
--	INNER JOIN @process AS p ON p.processId = r.processId 
--	INNER JOIN @user AS u ON u.UserId = r.UserId 
--	INNER JOIN @Stakeholders AS sh ON r.requestId = sh.requestId 
--	INNER JOIN @user AS shu ON shu.UserId =sh.userId; 


CREATE TABLE requestNote 
( 
	 requestNoteId int IDENTITY(1,1) 
	,requestId int 
	,userId int 
	,note national character varying(200) 
); 

 INSERT INTO requestNote(requestId, userId, note) 
 SELECT 1, 1, N'Note 1' 
;

-- Gives us Request Notes to Request

-- SELECT 
--  p.processId,p.processName,u.UserName as 'Requested By' 
-- ,r.requestId,r.title,rd.requestData,rd.name 'Request Data Type' 
-- ,rd.value 'Request Data Value' 
-- ,rn.note 'Request Notes',un.UserName 'Notes Given by' 
-- FROM RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId 
--	INNER JOIN @process AS p ON p.processId = r.processId 
--	INNER JOIN @user AS u ON u.UserId = r.UserId 
--	INNER JOIN @requestNote AS rn ON rn.requestId = r.requestId 
--	INNER JOIN @user AS un ON un.UserId = rn.userId; 

CREATE TABLE stateType 
( 
	 statetypeid int IDENTITY(1,1) 
	,"name" national character varying(200) 
); 

INSERT INTO stateType("name") 
          SELECT N'Start' 
UNION ALL SELECT N'Normal' 
UNION ALL SELECT N'Complete' 
UNION ALL SELECT N'Denied' 
UNION ALL SELECT N'Cancelled' 
;

CREATE TABLE state 
( 
	 "stateid" int IDENTITY(1,1) 
	,statetypeid int 
	,processid int 
	,"name" national character varying(200) 
	,"description" national character varying(200) 
); 

INSERT INTO state(statetypeid, processid, "name", "description") 
          SELECT 1, 1, N'Credit Approval Started', N'Credit Approval Started' 
UNION ALL SELECT 3, 1, N'Credit Approval Completed', N'Credit Approval Completed' 
UNION ALL SELECT 1, 1, N'Legal Approval Completed', N'Legal Approval Completed' 
UNION ALL SELECT 3, 1, N'Legal Approval Completed', N'Legal Approval Completed' 
;

-- SELECT * FROM state; 


CREATE TABLE transition 
( 
	 transitionId int IDENTITY(1,1) 
	,processId int 
	,currentStateId int 
	,nextStateId int 
); 


SET IDENTITY_INSERT transition ON
GO 

INSERT INTO transition(transitionId, processId, currentStateId, nextStateId)
SELECT 1, 1, 1, 3 
;
GO

SET IDENTITY_INSERT transition OFF 
GO 

SELECT * FROM transition; 

CREATE TABLE actionType 
( 
	 actionTypeId int IDENTITY(1,1) 
	,"name" national character varying(50) 
); 

INSERT INTO actionType("name") 
          SELECT N'Approve' 
UNION ALL SELECT N'Cancel' 
UNION ALL SELECT N'Deny' 
UNION ALL SELECT N'Restart' 
UNION ALL SELECT N'Resolve' 
; 

SELECT * FROM actionType; 



CREATE TABLE action 
( 
	 actionid int IDENTITY(1,1) 
	,actionTypeId int 
	,processId int 
	,"name" national character varying(200) 
	,"description" national character varying(200) 
); 

SELECT * FROM action; 

CREATE TABLE transitionaction 
( 
	 transitionid int 
	,actionid int 
); 

SELECT * FROM transitionaction; 

CREATE TABLE activityType 
( 
	 activityTypeId int IDENTITY(1,1)
	,"name" national character varying(200) 
); 

INSERT INTO activityType 
          SELECT N'Add Note' 
UNION ALL SELECT N'Add Stackholder' 
UNION ALL SELECT N'Send Email' 
; 


SELECT * FROM activityType;  


CREATE TABLE activity 
( 
	 activityId int IDENTITY(1,1) 
	,activityTypeId int 
	,ProcessId int 
	,"name" national character varying(300) 
	,"description" national character varying(300) 
); 

SELECT * FROM activity; 


--- Who can perform what actions and receive the activities
CREATE TABLE groups 
(  
	 groupId int IDENTITY(1,1) 
	,processId int 
	,"name" national character varying(200) 
); 

SELECT * FROM groups; 

CREATE TABLE groupmembers 
( 
	 groupid int 
	,userid int 
); 

SELECT * FROM groupmembers; 
-- Set of standardized representations of a person who have specific roles relative to a Request or Process 

-- Request Creator (Requester)
-- Request Stakeholders
-- Group Members
-- Process Admins

CREATE TABLE Target 
( 
	 targetId int IDENTITY(1,1) 
	,"name" national character varying(200) 
	,"description" national character varying(200) 
); 

INSERT INTO Target 
          SELECT N'Request Creator (Requester)', N'Request Creator (Requester)' 
UNION ALL SELECT N'Request Stakeholders', N'Request Stakeholders' 
UNION ALL SELECT N'Group Members', N'Group Members' 
UNION ALL SELECT N'Process Admins', N'Process Admins' 
; 

SELECT * FROM Target; 

-- As people who can perform Actions 
-- As people who can receive Activities 

CREATE TABLE actionTarget 
( 
	 actionTargetId int IDENTITY(1,1) 
	,actionId int 
	,targetId int 
	,groupId int 
); 


SELECT * FROM actionTarget; 

CREATE TABLE requestAction 
( 
	 requestAction int IDENTITY(1,1) 
	,requestId int 
	,actionId int 
	,transitionId int 
	,isactive bit 
	,iscomplete bit 
); 

SELECT * FROM requestAction;
