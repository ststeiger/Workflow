
CREATE TABLE "user" 
(
	 UserId int identity(1,1) 
	,UserName national character varying(50) 
); 

INSERT INTO "user"(UserName) SELECT (N'RM Name');
INSERT INTO "user"(UserName) SELECT (N'Credit Name');
INSERT INTO "user"(UserName) SELECT (N'Legal Name');
INSERT INTO "user"(UserName) SELECT (N'HOD Name');
-- SELECT * FROM user

CREATE TABLE process 
(
	 process_id int identity(1,1) 
	,process_name national character varying(50) 
);

INSERT INTO process(process_name) 
SELECT (N'Loan Approval');

-- SELECT * FROM process;

CREATE TABLE Request 
( 
	 request_id int identity(1,1) 
	,process_id int 
	,title national character varying(300) 
	,date_requested datetime default CURRENT_TIMESTAMP 
	,"user_id" int 
	,current_state_id int 
);

-- Insert part of Process
INSERT INTO Request(process_id, title, date_requested, "user_id", current_state_id) 
SELECT 1, N'Request for Credit Approval', CURRENT_TIMESTAMP, 1, 1;

-- SELECT * FROM Request;

CREATE TABLE RequestData 
( 
	 request_data int identity(1,1) 
	,request_id int 
	,"name" national character varying(200) 
	,"value" national character varying(200) 
); 

INSERT INTO RequestData(request_id, "name", "value") 
          SELECT 1, N'Commercials', N'Reference to Commericals Details' 
UNION ALL SELECT 1, N'CP', N'Reference to CP' 
UNION ALL SELECT 1, N'CS', N'Reference to CS' 
UNION ALL SELECT 1, N'Security Details', N'Reference to Security Details' 
; 

-- SELECT * FROM RequestData; 

-- Gives us the Rquestor and Request data type with reference to the data
-- SELECT p.processId,p.processName,u.UserName as 'Requested By',r.requestId,r.title,rd.requestData,rd.name 'Request Data Type',rd.value 'Request Data Value'
--		--,shu.UserName
-- FROM RequestData rd 
--	INNER JOIN 
--	@Request r ON r.requestId = rd.requestId
--	INNER JOIN
--	@process p ON p.processId = r.processId
--	INNER JOIN 
--	@user u ON u.UserId = r.UserId; 


CREATE TABLE Stakeholders 
(
	 request_id int 
	,"user_id" int 
); 

 INSERT INTO Stakeholders
           SELECT 1, 1 
 UNION ALL SELECT 1, 2 
 ;


-- Gives us Stakeholder assigned to Request
-- SELECT 
	 --  p.processId, p.processName 
	 -- ,u.UserName AS 'Requested By' 
	 -- ,r.requestId, r.title,rd.requestData 
	 -- ,rd.name AS 'Request Data Type' 
	 -- ,rd.value AS 'Request Data Value' 
	 -- ,shu.UserName 
-- FROM RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId
--	INNER JOIN @process AS p ON p.processId = r.processId
--	INNER JOIN @user AS u ON u.UserId = r.UserId
--	INNER JOIN @Stakeholders AS sh ON r.requestId = sh.requestId 
--	INNER JOIN @user AS shu ON shu.UserId = sh.userId; 


CREATE TABLE requestNote 
(
	 request_note_id int identity(1,1) 
	,request_id int 
	,"user_id" int 
	,note national character varying(200) 
); 
 INSERT INTO requestNote(request_id, "user_id", note) 
 SELECT 1, 1, 'Note 1'; 

-- Gives us Request Notes to Request

-- SELECT 
--  p.processId,p.processName
-- ,u.UserName AS 'Requested By'
-- ,r.requestId,r.title,rd.requestData
-- ,rd.name AS 'Request Data Type'
-- ,rd.value AS 'Request Data Value'
-- ,rn.note AS 'Request Notes'
-- ,un.UserName AS 'Notes Given by'
-- FROM RequestData AS rd 
--	INNER JOIN @Request AS r ON r.requestId = rd.requestId
--	INNER JOIN @process AS p ON p.processId = r.processId
--	INNER JOIN @user AS u ON u.UserId = r.UserId
--	INNER JOIN @requestNote AS rn ON rn.requestId = r.requestId
--	INNER JOIN @user AS un ON un.UserId = rn.userId; 

CREATE TABLE stateType 
(
	 statetypeid int identity(1,1) 
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
	 "state_id" int identity(1,1) 
	,state_type_id int 
	,process_id int 
	,"name" national character varying(200) 
	,"description" national character varying(200) 
); 

INSERT INTO state(state_type_id, process_id, "name", "description") 
          SELECT 1, 1, N'Credit Approval Started', N'Credit Approval Started' 
UNION ALL SELECT 3, 1, N'Credit Approval Completed', N'Credit Approval Completed' 
UNION ALL SELECT 1, 1, N'Legal Approval Completed', N'Legal Approval Completed' 
UNION ALL SELECT 3, 1, N'Legal Approval Completed', N'Legal Approval Completed' 
;
-- SELECT * FROM state; 


CREATE TABLE transition 
(
	 transition_id int identity(1,1) 
	,process_id int 
	,current_state_id int 
	,next_state_id int 
); 



SET IDENTITY_INSERT transition ON
GO 

INSERT INTO transition 
(
	 transition_id
	,process_id
	,current_state_id
	,next_state_id 
)
SELECT 1, 1, 1, 3 
;

SELECT * FROM transition; 
GO

SET IDENTITY_INSERT transition OFF 
GO


CREATE TABLE actionType 
( 
	 action_type_id int identity(1,1) 
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
	 action_id int identity(1,1) 
	,action_type_id int 
	,process_id int 
	,"name" national character varying(200) 
	,"description" national character varying(200) 
); 

SELECT * FROM action; 

CREATE TABLE transitionaction  
(
	 transition_id int 
	,action_id int 
); 

SELECT * FROM transitionaction; 

CREATE TABLE activityType 
(
	 activity_type_id int identity(1,1) 
	,"name" national character varying(200) 
); 

INSERT INTO activityType("name") 
          SELECT N'Add Note' 
UNION ALL SELECT N'Add Stackholder' 
UNION ALL SELECT N'Send Email' 
;

SELECT * FROM activityType;


CREATE TABLE activity 
( 
	 activity_id int identity(1,1) 
	,activity_type_id int 
	,process_id int 
	,"name" national character varying(300) 
	,"description" national character varying(300) 
);

SELECT * FROM activity; 


--- Who can perform what actions and receive the activities 
CREATE TABLE groups 
( 
	 group_id int identity(1,1) 
	,process_id int 
	,"name" national character varying(200) 
); 

SELECT * FROM groups; 

CREATE TABLE groupmembers 
(
	 group_id int 
	,"user_id" int 
); 

SELECT * FROM groupmembers; 

-- SET of standardized representations of a person who have specific roles relative to a Request or Process

-- Request Creator (Requester)
-- Request Stakeholders
-- Group Members
-- Process Admins

CREATE TABLE Target 
(
	 targetId int identity(1,1) 
	,"name" national character varying(200) 
	,"description" national character varying(200) 
); 

INSERT INTO Target("name", "description") 
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
	 action_target_id int identity(1,1) 
	,action_id int 
	,target_id int 
	,group_id int 
);


SELECT * FROM actionTarget; 

CREATE TABLE requestAction 
( 
	 request_action int identity(1,1) 
	,request_id int 
	,action_id int 
	,transition_id int 
	,is_active bit 
	,is_complete bit 
); 

SELECT * FROM requestAction; 
