-- 1. Create and Use the Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DemoDB')
BEGIN
    CREATE DATABASE DemoDB;
END
GO

USE DemoDB;
GO

-- 2. Create Tables (Batch separated by GO)

CREATE TABLE tblAIRequest (
	Id uniqueidentifier NOT NULL,
	[Type] int NULL,
	AIParameter int NULL,
	Name varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InputUrl nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OutputUrl nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NULL,
	UserId uniqueidentifier NULL,
	CreatedDate datetime DEFAULT getdate() NULL,
	ProcessedDate datetime NULL,
	CONSTRAINT PK_tblAIRequest PRIMARY KEY (Id)
);
GO

CREATE TABLE tblAnnotationFormats (
	Id uniqueidentifier NOT NULL,
	Name varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NULL,
	Description varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblAnnotationFormats PRIMARY KEY (Id)
);
GO

CREATE TABLE tblAnnotationTypes (
	Id uniqueidentifier NOT NULL,
	Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NULL,
	CreatedBy uniqueidentifier NULL,
	CreatedOn datetime DEFAULT getdate() NULL,
	CONSTRAINT PK_tblAnnotationTypes PRIMARY KEY (Id)
);
GO

CREATE TABLE tblApp (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsActive bit NOT NULL,
	ShortDesc varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LongDesc varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ReleaseDate datetime NOT NULL,
	InsertedOn datetime NOT NULL,
	UpdatedOn datetime NOT NULL,
	InsertedBy uniqueidentifier NOT NULL,
	UpdatedBy uniqueidentifier NOT NULL,
	Version varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ProfileImageUrl varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AppDetailImageUrl varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AppConfigFileName varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Price decimal(18,2) NULL,
	DeveloperId uniqueidentifier NULL,
	TotalDownloads int NULL,
	TotalActive int NULL,
	SOrder int NULL,
	VideoUrl varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblApp PRIMARY KEY (Id)
);
GO

CREATE TABLE tblAppUpdate (
	Id int IDENTITY(1,1) NOT NULL,
	OSType int NOT NULL,
	Version nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsMandatory bit NOT NULL,
	CONSTRAINT PK_tblAppUpdate PRIMARY KEY (Id)
);
GO

CREATE TABLE tblAppUser (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	AppId uniqueidentifier NOT NULL,
	UserId uniqueidentifier NOT NULL,
	IsActive bit NULL,
	InsertedOn datetime NULL,
	UpdatedOn datetime NULL,
	UpdatedBy uniqueidentifier NULL,
	CONSTRAINT PK_tblAppUser PRIMARY KEY (Id)
);
GO

CREATE TABLE tblBlocks (
	Id uniqueidentifier NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] int NULL,
	Config nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Sorder int NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MetaData nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Category nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsLive bit DEFAULT 1 NOT NULL,
	CONSTRAINT tblBlocks_pk PRIMARY KEY (Id)
);
GO

CREATE TABLE tblBoundaryParameters (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceApplicationId uniqueidentifier NOT NULL,
	PolygonPoints varbinary(MAX) NOT NULL,
	FrameWidth int DEFAULT 1280 NULL,
	FrameHeight int DEFAULT 720 NULL,
	MinTrackingConfidence int DEFAULT 60 NOT NULL,
	StartTime datetime NULL,
	EndTime datetime NULL,
	CONSTRAINT PK_tblBoundaryParameters PRIMARY KEY (Id)
);
GO

CREATE TABLE tblCamera (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OrganisationId uniqueidentifier NULL,
	CONSTRAINT PK_Camera PRIMARY KEY (Id)
);
GO

CREATE TABLE tblDemoAnalysis (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	ClientId uniqueidentifier NULL,
	CPId uniqueidentifier NULL,
	ApplicationName nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StartTime datetime NULL,
	EndTime datetime NULL,
	CONSTRAINT PK_tblDemoAnalysis PRIMARY KEY (Id)
);
GO

CREATE TABLE tblDeviceTags (
	Id uniqueidentifier NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit NULL,
	Sorder int NULL,
	CONSTRAINT PK_tblDeviceTags PRIMARY KEY (Id)
);
GO

CREATE TABLE tblFireLayouts (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OrganizationId uniqueidentifier NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Url nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Sorder int NULL,
	CONSTRAINT PK_tblFireLayouts PRIMARY KEY (Id)
);
GO

CREATE TABLE tblHailstormImages (
	Id uniqueidentifier NOT NULL,
	Name varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ImagePath nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Resolution varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Size] decimal(18,2) NULL,
	IsSynced bit DEFAULT 0 NOT NULL,
	CreatedOn datetime NULL,
	ThumbPath nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ImageKey nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblHailstromImages PRIMARY KEY (Id)
);
GO

CREATE TABLE tblHmapAnalysis (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	AppUserId uniqueidentifier NULL,
	BaseImage varbinary(MAX) NULL,
	DeviceId uniqueidentifier NULL,
	CONSTRAINT PK_HmapAnalysis PRIMARY KEY (Id)
);
GO

CREATE TABLE tblImage (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Filename varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Extension varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ObjectId uniqueidentifier NOT NULL,
	Sorder int DEFAULT 1 NOT NULL,
	CONSTRAINT PK_tblImage PRIMARY KEY (Id)
);
GO

CREATE TABLE tblInsuranceInfo (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OwnerName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	MobileNo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Address varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IssuedOn datetime NOT NULL,
	ExpiresOn datetime NOT NULL,
	Make varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Model varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblInsuranceInfo PRIMARY KEY (Id)
);
GO

CREATE TABLE tblLayouts (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OrganizationId uniqueidentifier NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Url nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Sorder int NULL,
	CONSTRAINT PK_tblLayouts PRIMARY KEY (Id)
);
GO

CREATE TABLE tblLiveDemoApp (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	AppName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	BaseUrl nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsActive bit NOT NULL,
	[Index] int NOT NULL,
	CONSTRAINT PK_tblLiveDemoApp PRIMARY KEY (Id)
);
GO

CREATE TABLE tblLiveDemoObject (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsActive bit NOT NULL,
	CONSTRAINT PK_tblObject PRIMARY KEY (Id)
);
GO

CREATE TABLE tblLogs (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	ReferenceId uniqueidentifier NULL,
	[Timestamp] datetime NOT NULL,
	LogType int NOT NULL,
	LogInfo varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Source] int NOT NULL,
	IsSynced bit DEFAULT 0 NULL,
	CONSTRAINT PK_tblLogs PRIMARY KEY (Id)
);
GO

CREATE TABLE tblModel (
	Id uniqueidentifier NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Pricing int NULL,
	Description nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	isActive bit DEFAULT 0 NOT NULL,
	isDefault bit DEFAULT 0 NOT NULL,
	Sorder int NULL,
	ModelName nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT tblModel_pk PRIMARY KEY (Id)
);
GO

CREATE TABLE tblModelOptions (
	Id uniqueidentifier NOT NULL,
	Name varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NULL,
	Description varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AnnotationTypeId uniqueidentifier NULL,
	CONSTRAINT PK_tblModelOptions PRIMARY KEY (Id)
);
GO

CREATE TABLE tblNotification (
	Id int IDENTITY(1,1) NOT NULL,
	Title nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Message nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Content nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ContentType int NULL,
	Tag nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Sound varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedDate datetime NOT NULL,
	ObjectId uniqueidentifier NULL,
	AuthorId uniqueidentifier NULL,
	UserId uniqueidentifier NULL,
	OrganizationId uniqueidentifier NULL,
	Code nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ObjectType int NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NOT NULL,
	IsCompleted bit NULL,
	IsCleared bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblNotification PRIMARY KEY (Id)
);
GO

CREATE TABLE tblObjectDetectionApp (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Objects varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AppId uniqueidentifier NULL,
	CONSTRAINT PK_ObjectDetectionApps PRIMARY KEY (Id)
);
GO

CREATE TABLE tblOrderDetails (
	Id uniqueidentifier NOT NULL,
	OrderId uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	Amount float NOT NULL,
	UserId uniqueidentifier NOT NULL,
	CreatedDate datetime NOT NULL,
	CONSTRAINT PK_tblOrderDetails_1 PRIMARY KEY (Id)
);
GO

CREATE TABLE tblOrg (
	Id uniqueidentifier NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsDubbingClient bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblOrg PRIMARY KEY (Id)
);
GO

CREATE TABLE tblOrganizationType (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK_tblOrganizationType PRIMARY KEY (Id)
);
GO

CREATE TABLE tblPackages (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AmountInr int NULL,
	Device int NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AmountDollar int NULL,
	CONSTRAINT PK_tblPackages PRIMARY KEY (Id)
);
GO

CREATE TABLE tblPayment (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	StartDate datetime NULL,
	EndDate datetime NULL,
	Amount float NOT NULL,
	Description varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Mode int NOT NULL,
	Status int NOT NULL,
	Response varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MerchantPaymentId nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TransactionId uniqueidentifier NULL,
	CONSTRAINT PK_tblPayment PRIMARY KEY (Id)
);
GO

CREATE TABLE tblPermission (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblPermission PRIMARY KEY (Id)
);
GO

CREATE TABLE tblRole (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK_tblRole PRIMARY KEY (Id)
);
GO

CREATE TABLE tblShift (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	StartTime varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	EndTime varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Status int NOT NULL,
	CONSTRAINT PK_tblShift PRIMARY KEY (Id)
);
GO

CREATE TABLE tblTTD (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceApplicationId uniqueidentifier NULL,
	TimeToVisit int NOT NULL,
	PeopleCount int DEFAULT 0 NOT NULL,
	TimeOFEntry datetime NOT NULL,
	CONSTRAINT PK_tblTTD PRIMARY KEY (Id)
);
GO

CREATE TABLE tblTTDParams (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceApplicationId uniqueidentifier NOT NULL,
	PolygonPoints varbinary(MAX) NOT NULL,
	MaxWaitTime int NOT NULL,
	MaxSupportedCount int NOT NULL,
	TimeTakenPerCount real NOT NULL,
	LowDensityDetectionFactor real NOT NULL,
	MidDensityDetectionFactor real NOT NULL,
	HighDensityDetectionFactor real NOT NULL,
	LowDensityLimit int NOT NULL,
	MidDensityLimit int NOT NULL
);
GO

CREATE TABLE tblUserFace (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	FaceId uniqueidentifier NOT NULL,
	UserId uniqueidentifier NOT NULL,
	CONSTRAINT PK_UserFace PRIMARY KEY (Id)
);
GO

CREATE TABLE tblUserPackage (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	UserId uniqueidentifier NULL,
	PackageId uniqueidentifier NULL,
	Status int NULL,
	ActivationDate datetime NULL,
	CONSTRAINT PK_tblUserPackage PRIMARY KEY (Id)
);
GO

CREATE TABLE tblVisitorLog (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	TimeOfDetection datetime NOT NULL,
	ImageLocation varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Age real NULL,
	Gender varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BoundingBox varbinary(MAX) NULL,
	FacialEncoding varbinary(MAX) NULL,
	Masked bit NULL,
	FaceTemperatureCelsius real NULL,
	FacePicture varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FaceCapturePicture varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ThermalPicture varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	isAbnormalTemp bit DEFAULT 0 NULL,
	DeviceId uniqueidentifier NULL,
	DeviceApplicationId uniqueidentifier NULL,
	FaceReferenceId uniqueidentifier NULL,
	BookingId int NULL,
	QRcode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NumberOfBookings int NULL,
	Name varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Email varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Phone varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ManualEntry bit DEFAULT 0 NULL
);
GO

CREATE TABLE tblAreas (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	LayoutId uniqueidentifier NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	BoundingBox nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SerialNumber int NULL,
	CONSTRAINT PK_tblAreas PRIMARY KEY (Id),
	CONSTRAINT FK_tblAreas_tblLayouts FOREIGN KEY (LayoutId) REFERENCES tblLayouts(Id)
);
GO

CREATE TABLE tblFireAreas (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	LayoutId uniqueidentifier NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	BoundingBox nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	SerialNumber int NULL,
	CONSTRAINT PK_tblFireAreas PRIMARY KEY (Id),
	CONSTRAINT FK_tblFireAreas_tblFireLayouts FOREIGN KEY (LayoutId) REFERENCES tblFireLayouts(Id)
);
GO

CREATE TABLE tblTransaction (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Amount float NOT NULL,
	PaymentId uniqueidentifier NULL,
	TransactionCode uniqueidentifier NULL,
	PaymentStatus varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MerchantOrderId nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblTransaction PRIMARY KEY (Id),
	CONSTRAINT FK_tblTransaction_tblPayment FOREIGN KEY (PaymentId) REFERENCES tblPayment(Id)
);
GO

CREATE TABLE tblUser (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	ParentId uniqueidentifier NULL,
	ShiftId uniqueidentifier NULL,
	Name varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Email varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Password varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Dob datetime NULL,
	PhoneNo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Gender int NULL,
	Status int DEFAULT 0 NOT NULL,
	Picture varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Extension varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FcmToken varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PasswordHash varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PasswordCode uniqueidentifier NULL,
	IsSuperAdmin bit NULL,
	ProfileImageUrl varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsActive bit NULL,
	Code nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FathersName varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Address varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Taluka varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	District varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Education varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	WorkEx varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Languages varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Height varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Weight varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OtherDetails varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	EmergencyContactName varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	EmergencyAddress varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	EmergencyPhoneNo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedDate datetime NULL,
	VideoId bigint NULL,
	HasChangedPassword bit DEFAULT 0 NOT NULL,
	HasAddedFace bit DEFAULT 0 NOT NULL,
	Country nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TimeZoneRegion nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TimeDifference int NULL,
	CountryCode nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsProtectionDisabled bit DEFAULT 0 NOT NULL,
	InvitedBy uniqueidentifier NULL,
	ShouldResetPassword bit DEFAULT 0 NOT NULL,
	IsSynced bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK_tblUser PRIMARY KEY (Id),
	CONSTRAINT FK_tblUser_tblShift FOREIGN KEY (ShiftId) REFERENCES tblShift(Id),
	CONSTRAINT FK_tblUser_tblUser FOREIGN KEY (InvitedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblUserPermission (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	UserId uniqueidentifier NOT NULL,
	PermissionId uniqueidentifier NOT NULL,
	CONSTRAINT PK_tblUserPermission PRIMARY KEY (Id),
	CONSTRAINT FK_tblUserPermission_tblPermission FOREIGN KEY (PermissionId) REFERENCES tblPermission(Id),
	CONSTRAINT FK_tblUserPermission_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblUserRole (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	UserId uniqueidentifier NOT NULL,
	RoleId uniqueidentifier NOT NULL,
	Status int DEFAULT 1 NOT NULL,
	CONSTRAINT PK_tblUserRole PRIMARY KEY (Id),
	CONSTRAINT FK_tblUserRole_tblRole FOREIGN KEY (RoleId) REFERENCES tblRole(Id),
	CONSTRAINT FK_tblUserRole_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblWorkflows (
	Id uniqueidentifier NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedBy uniqueidentifier NOT NULL,
	CreatedAt datetime NULL,
	UpdatedBy uniqueidentifier NULL,
	UpdatedAt datetime NULL,
	Config nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NULL,
	isImported bit DEFAULT 0 NULL,
	flow_id uniqueidentifier NULL,
	TrimConfig nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT tblWorkflows_pk PRIMARY KEY (Id),
	CONSTRAINT tblWorkflows_tblUser_FK FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblAgentUser (
	Id uniqueidentifier NOT NULL,
	CreatedBy uniqueidentifier NOT NULL,
	ModelId uniqueidentifier NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	Status int DEFAULT 0 NOT NULL,
	CONSTRAINT tblAgentUser_pk PRIMARY KEY (Id),
	CONSTRAINT tblAgentUser_tblUser_FK FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblAgents (
	Id uniqueidentifier NOT NULL,
	WorkflowId uniqueidentifier NOT NULL,
	Name nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedBy uniqueidentifier NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedBy uniqueidentifier NULL,
	UpdatedAt datetime NULL,
	Config nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NULL,
	MetaData nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TrimConfig nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT tblAgents_pk PRIMARY KEY (Id),
	CONSTRAINT tblAgents_tblUser_FK FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id),
	CONSTRAINT tblAgents_tblUser_FK_1 FOREIGN KEY (UpdatedBy) REFERENCES tblUser(Id),
	CONSTRAINT tblAgents_tblWorkflows_FK FOREIGN KEY (WorkflowId) REFERENCES tblWorkflows(Id)
);
GO

CREATE TABLE tblCartDetails (
	Id uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	Amount float NOT NULL,
	UserId uniqueidentifier NOT NULL,
	CreatedDate datetime NOT NULL,
	CONSTRAINT PK_tblCartDetails_1 PRIMARY KEY (Id),
	CONSTRAINT FK_tblCartDetails_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblConversation (
	Id uniqueidentifier NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedBy uniqueidentifier NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NULL,
	Status int DEFAULT 0 NOT NULL,
	CONSTRAINT tblConversation_pk PRIMARY KEY (Id),
	CONSTRAINT tblConversation_tblUser_FK FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblDocument (
	Id uniqueidentifier NOT NULL,
	Title nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	DataUrl nvarchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	DataType int NOT NULL,
	Description nvarchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedBy uniqueidentifier NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	Status int DEFAULT 0 NOT NULL,
	OrgId uniqueidentifier NOT NULL,
	CONSTRAINT tblDocument_pk PRIMARY KEY (Id),
	CONSTRAINT tblDocument_tblOrg_FK FOREIGN KEY (OrgId) REFERENCES tblOrg(Id),
	CONSTRAINT tblDocument_tblUser_FK FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblIntegration (
	Id uniqueidentifier NOT NULL,
	[Type] int NOT NULL,
	Config nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	isActive bit DEFAULT 0 NOT NULL,
	CreatedBy uniqueidentifier NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	Status int DEFAULT 0 NOT NULL,
	CONSTRAINT tblIntegration_pk PRIMARY KEY (Id),
	CONSTRAINT tblIntegration_tblUser_FK FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblLoginHistory (
	Id int IDENTITY(1,1) NOT NULL,
	UserId uniqueidentifier NOT NULL,
	AppVersion nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OSType nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OSVersion nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeviceModel nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeviceType nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Manufacturer nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedDate datetime NOT NULL,
	CONSTRAINT PK_tblLoginHistory PRIMARY KEY (Id),
	CONSTRAINT FK_tblLoginHistory_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblMessage (
	Id uniqueidentifier NOT NULL,
	ConversationId uniqueidentifier NOT NULL,
	Sender bit NOT NULL,
	Message nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NULL,
	Sorder varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT '0' NOT NULL,
	DataUrl nvarchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DataType int DEFAULT 0 NOT NULL,
	Status int DEFAULT 0 NOT NULL,
	CONSTRAINT tblMessage_pk PRIMARY KEY (Id),
	CONSTRAINT tblMessage_tblConversation_FK FOREIGN KEY (ConversationId) REFERENCES tblConversation(Id)
);
GO

CREATE TABLE tblOrder (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OrderNumber int NOT NULL,
	Amount float NOT NULL,
	CreatedDate datetime NOT NULL,
	ModifiedDate datetime NOT NULL,
	DueDate datetime NULL,
	UserId uniqueidentifier NOT NULL,
	MerchantSubscriptionId varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TypeId uniqueidentifier NULL,
	[Type] int NULL,
	BookedBy uniqueidentifier NULL,
	CONSTRAINT PK_tblOrder PRIMARY KEY (Id),
	CONSTRAINT FK_tblOrder_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id),
	CONSTRAINT FK_tblOrder_tblUser1 FOREIGN KEY (BookedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblOrderTransaction (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OrderId uniqueidentifier NOT NULL,
	TransactionId uniqueidentifier NOT NULL,
	CONSTRAINT PK_tblOrderTransaction PRIMARY KEY (Id),
	CONSTRAINT FK_tblOrderTransaction_tblOrder FOREIGN KEY (OrderId) REFERENCES tblOrder(Id),
	CONSTRAINT FK_tblOrderTransaction_tblTransaction FOREIGN KEY (TransactionId) REFERENCES tblTransaction(Id)
);
GO

CREATE TABLE tblOrganization (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Address nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrganizationId nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int NULL,
	CreatedBy uniqueidentifier NULL,
	CreatedOn datetime2 NULL,
	ApprovedBy uniqueidentifier NULL,
	ApprovedOn datetime2 NULL,
	ModifiedBy uniqueidentifier NULL,
	ModifiedOn datetime2 NULL,
	OrganizationTypeId uniqueidentifier NULL,
	LatLong varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MinWorkingTime int DEFAULT 0 NULL,
	IsSynced bit DEFAULT 1 NOT NULL,
	DeviceLimit int NULL,
	ActiveStreamsLimit int NULL,
	CONSTRAINT PK_tblOrganization PRIMARY KEY (Id),
	CONSTRAINT FK_tblOrganization_tblOrganizationType FOREIGN KEY (OrganizationTypeId) REFERENCES tblOrganizationType(Id),
	CONSTRAINT FK_tblOrganization_tblUser FOREIGN KEY (ApprovedBy) REFERENCES tblUser(Id),
	CONSTRAINT FK_tblOrganization_tblUser1 FOREIGN KEY (ModifiedBy) REFERENCES tblUser(Id),
	CONSTRAINT FK_tblOrganization_tblUser2 FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblOrganizationDocuments (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	FileName nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrganizationId uniqueidentifier NULL,
	CONSTRAINT PK_tblOrganizationDocuments PRIMARY KEY (Id),
	CONSTRAINT FK_tblOrganizationDocuments_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id)
);
GO

CREATE TABLE tblOrganizationHierarchy (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OrganizationId uniqueidentifier NULL,
	ParentOrganizationId uniqueidentifier NULL,
	CONSTRAINT PK_tblOrganizationHierarchy PRIMARY KEY (Id),
	CONSTRAINT FK_tblOrganizationHierarchy_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id),
	CONSTRAINT FK_tblOrganizationHierarchy_tblOrganization1 FOREIGN KEY (ParentOrganizationId) REFERENCES tblOrganization(Id)
);
GO

CREATE TABLE tblOrganizationPermission (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OrganizationId uniqueidentifier NOT NULL,
	PermissionId uniqueidentifier NOT NULL,
	CONSTRAINT PK_tblOrganizationPermission PRIMARY KEY (Id),
	CONSTRAINT FK_tblOrganizationPermission_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id),
	CONSTRAINT FK_tblOrganizationPermission_tblPermission FOREIGN KEY (PermissionId) REFERENCES tblPermission(Id)
);
GO

CREATE TABLE tblProjects (
	Id uniqueidentifier NOT NULL,
	Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrganizationId uniqueidentifier NOT NULL,
	Status int DEFAULT 1 NULL,
	CreatedOn datetime NULL,
	CreatedBy uniqueidentifier NOT NULL,
	UpdatedOn datetime NULL,
	UpdatedBy uniqueidentifier NULL,
	IsSynced bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK_tblProjects PRIMARY KEY (Id),
	CONSTRAINT FK_tblProjects_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id),
	CONSTRAINT FK_tblProjects_tblUser FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblShareProject (
	Id uniqueidentifier NOT NULL,
	UserId uniqueidentifier NULL,
	ProjectId uniqueidentifier NULL,
	Status int NULL,
	CreatedBy uniqueidentifier NULL,
	CreatedOn datetime NULL,
	UpdatedBy uniqueidentifier NULL,
	UpdatedOn datetime NULL,
	IsSynced bit NULL,
	CONSTRAINT PK_tblShareProjectDataset PRIMARY KEY (Id),
	CONSTRAINT FK_tblShareProjectDataset_tblProjects FOREIGN KEY (ProjectId) REFERENCES tblProjects(Id),
	CONSTRAINT FK_tblShareProjectDataset_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblUserOrganization (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	UserId uniqueidentifier NULL,
	OrganizationId uniqueidentifier NULL,
	[Role] nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RoleId uniqueidentifier NULL,
	ManagerId uniqueidentifier NULL,
	CONSTRAINT PK_tblUserOrgnization PRIMARY KEY (Id),
	CONSTRAINT FK_tblUserOrganization_tblUser FOREIGN KEY (ManagerId) REFERENCES tblUser(Id),
	CONSTRAINT FK_tblUserOrgnization_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id),
	CONSTRAINT FK_tblUserOrgnization_tblRole FOREIGN KEY (RoleId) REFERENCES tblRole(Id),
	CONSTRAINT FK_tblUserOrgnization_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblAgentLogs (
	Id uniqueidentifier NOT NULL,
	AgentId uniqueidentifier NOT NULL,
	ExecutionTime datetime NOT NULL,
	Status int NOT NULL,
	InputData nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OutputData nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ErrorMessage nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ExecutionDuration real NULL,
	CreatedAt datetime DEFAULT getutcdate() NOT NULL,
	CONSTRAINT tblAgentLogs_pk PRIMARY KEY (Id),
	CONSTRAINT tblAgentLogs_tblAgents_FK FOREIGN KEY (AgentId) REFERENCES tblAgents(Id)
);
GO

CREATE NONCLUSTERED INDEX IX_tblAgentLogs_AgentId_ExecutionTime ON dbo.tblAgentLogs (  AgentId ASC  , ExecutionTime DESC  )
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
GO

CREATE TABLE tblAttendanceEntry (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	CreatedBy uniqueidentifier NOT NULL,
	UserId uniqueidentifier NOT NULL,
	OrganizationId uniqueidentifier NULL,
	CheckInTime datetime NULL,
	CheckOutTime datetime NULL,
	CreatedDate datetime NOT NULL,
	Mode int NOT NULL,
	ModifiedBy uniqueidentifier NULL,
	ModifiedDate datetime NULL,
	Status int NOT NULL,
	CheckInLatLong varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CheckOutLatLong varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CheckInAddress varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CheckOutAddress varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Duration int DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblAttendanceEntry PRIMARY KEY (Id),
	CONSTRAINT FK_tblAttendanceEntry_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id),
	CONSTRAINT FK_tblAttendanceEntry_tblUser FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id),
	CONSTRAINT FK_tblAttendanceEntry_tblUser1 FOREIGN KEY (ModifiedBy) REFERENCES tblUser(Id),
	CONSTRAINT FK_tblAttendanceEntry_tblUser2 FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblDatasets (
	Id uniqueidentifier NOT NULL,
	Name varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AnnotationTypeId uniqueidentifier NOT NULL,
	ProjectId uniqueidentifier NOT NULL,
	Status int NULL,
	CreatedBy uniqueidentifier NULL,
	CreatedOn datetime NULL,
	UpdatedBy uniqueidentifier NULL,
	UpdatedOn datetime NULL,
	IsSynced bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblDatasets PRIMARY KEY (Id),
	CONSTRAINT FK_tblDatasets_tblAnnotationTypes FOREIGN KEY (AnnotationTypeId) REFERENCES tblAnnotationTypes(Id),
	CONSTRAINT FK_tblDatasets_tblProjects FOREIGN KEY (ProjectId) REFERENCES tblProjects(Id),
	CONSTRAINT FK_tblDatasets_tblUser FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblDevice (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	Name varchar(300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Url varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeviceNo varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Location varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OutputType varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Version varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UserId uniqueidentifier NULL,
	IsActive bit NULL,
	InsertedOn datetime NOT NULL,
	UpdatedOn datetime NULL,
	InsertedBy uniqueidentifier NULL,
	UpdatedBy uniqueidentifier NULL,
	DeviceDimension varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RestrictedArea varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrganizationId uniqueidentifier NULL,
	ProcessId nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	StreamingType int NULL,
	ImageUrl varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Screenshot varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LastUpdateTime datetime NULL,
	DeviceTags varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status int DEFAULT 0 NOT NULL,
	IsHealthCheckOpted bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK__tblDevic__3214EC0781E60B74 PRIMARY KEY (Id),
	CONSTRAINT FK_tblDevice_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id)
);
GO

CREATE TABLE tblDeviceActivityLog (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	UserId uniqueidentifier NULL,
	OrganizationId uniqueidentifier NULL,
	DeviceId uniqueidentifier NULL,
	AppId uniqueidentifier NULL,
	AreaId uniqueidentifier NULL,
	Severity int NOT NULL,
	CreatedDate datetime NOT NULL,
	Message nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ObjectType int NULL,
	ObjectId int NULL,
	ImageLocation nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsSynced bit DEFAULT 0 NULL,
	CONSTRAINT PK_tblDeviceActivityLog PRIMARY KEY (Id),
	CONSTRAINT FK_tblDeviceActivityLog_tblApp FOREIGN KEY (AppId) REFERENCES tblApp(Id),
	CONSTRAINT FK_tblDeviceActivityLog_tblAreas FOREIGN KEY (AreaId) REFERENCES tblAreas(Id),
	CONSTRAINT FK_tblDeviceActivityLog_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblDeviceActivityLog_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id),
	CONSTRAINT FK_tblDeviceActivityLog_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblDeviceApplication (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceId uniqueidentifier NULL,
	ApplicationId uniqueidentifier NULL,
	Status bit DEFAULT 1 NULL,
	CONSTRAINT PK_tblDeviceApplication PRIMARY KEY (Id),
	CONSTRAINT FK_tblDeviceApplication_tblApp FOREIGN KEY (ApplicationId) REFERENCES tblApp(Id),
	CONSTRAINT FK_tblDeviceApplication_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE TABLE tblDeviceSnooze (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	UserId uniqueidentifier NOT NULL,
	CreatedDate datetime NOT NULL,
	EndTime datetime NULL,
	[Type] int DEFAULT 0 NOT NULL,
	Duration int NULL,
	UpdatedDate datetime NULL,
	CONSTRAINT PK_tblDeviceSnooze PRIMARY KEY (Id),
	CONSTRAINT FK_tblDeviceSnooze_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblDeviceSnooze_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblDeviceSnoozeHistory (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	UserId uniqueidentifier NOT NULL,
	CreatedDate datetime NOT NULL,
	EndTime datetime NULL,
	[Type] int DEFAULT 0 NOT NULL,
	Duration int NULL,
	CONSTRAINT PK_tblDeviceSnoozeHistory PRIMARY KEY (Id),
	CONSTRAINT FK_tblDeviceSnoozeHistory_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblDeviceSnoozeHistory_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblFace (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	CreatedBy uniqueidentifier NOT NULL,
	UserId uniqueidentifier NULL,
	OrganizationId uniqueidentifier NULL,
	Name nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Email nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PhoneNo nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedDate datetime NOT NULL,
	Status int NOT NULL,
	UpdatedOn datetime NULL,
	CONSTRAINT PK_Face_1 PRIMARY KEY (Id),
	CONSTRAINT FK_tblFace_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id),
	CONSTRAINT FK_tblFace_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblFaceDetection (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DetectedUserId uniqueidentifier NULL,
	TimeOfDetection datetime NOT NULL,
	CameraId uniqueidentifier NULL,
	Confidence real NULL,
	AppUserId uniqueidentifier NULL,
	ProcessedImageLocation varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CroppedImageLocation varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Age real NULL,
	Gender varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BoundingBox varchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeviceId uniqueidentifier NOT NULL,
	AppId uniqueidentifier NOT NULL,
	CONSTRAINT PK_Detection PRIMARY KEY (Id),
	CONSTRAINT FK_tblFaceDetection_tblApp FOREIGN KEY (AppId) REFERENCES tblApp(Id),
	CONSTRAINT FK_tblFaceDetection_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblFaceDetection_tblUser FOREIGN KEY (DetectedUserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblFaceImage (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	FaceId uniqueidentifier NOT NULL,
	ImageLocation nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Encoding varbinary(MAX) NULL,
	MaskedFace bit NULL,
	CpuEncoding bit NULL,
	CreatedDate datetime NOT NULL,
	Status int NOT NULL,
	UpdatedOn datetime NULL,
	CONSTRAINT PK_tblFaceImage PRIMARY KEY (Id),
	CONSTRAINT FK_tblFaceImage_tblFace FOREIGN KEY (FaceId) REFERENCES tblFace(Id)
);
GO

CREATE TABLE tblFireAlerts (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	AreaId uniqueidentifier NOT NULL,
	FireDetected bit NULL,
	DeviceId uniqueidentifier NULL,
	TimeOfDetection datetime NULL,
	Status int NULL,
	CONSTRAINT PK_tblFireAlerts_1 PRIMARY KEY (Id),
	CONSTRAINT FK_tblFireAlerts_tblAreas1 FOREIGN KEY (AreaId) REFERENCES tblAreas(Id),
	CONSTRAINT FK_tblFireAlerts_tblDevice1 FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE TABLE tblGroup (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	OrganizationId uniqueidentifier NOT NULL,
	Name nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK_tblGroup PRIMARY KEY (Id),
	CONSTRAINT FK_tblGroup_tblOrganization FOREIGN KEY (OrganizationId) REFERENCES tblOrganization(Id)
);
GO

CREATE TABLE tblGroupPermission (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	GroupId uniqueidentifier NOT NULL,
	PermissionId uniqueidentifier NOT NULL,
	CONSTRAINT PK_tblGroupPermission PRIMARY KEY (Id),
	CONSTRAINT FK_tblGroupPermission_tblGroup FOREIGN KEY (GroupId) REFERENCES tblGroup(Id),
	CONSTRAINT FK_tblGroupPermission_tblPermission FOREIGN KEY (PermissionId) REFERENCES tblPermission(Id)
);
GO

CREATE TABLE tblHailstormRequests (
	Id uniqueidentifier NOT NULL,
	DatasetId uniqueidentifier NOT NULL,
	AnnotationformatId uniqueidentifier NULL,
	ModelOptionId uniqueidentifier NULL,
	[Type] int NULL,
	Status int NULL,
	ResultPath varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedOn datetime DEFAULT getdate() NULL,
	CreatedBy uniqueidentifier NULL,
	IsSynced bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblHailstormRequests PRIMARY KEY (Id),
	CONSTRAINT FK_tblHailstormRequests_tblAnnotationFormats FOREIGN KEY (AnnotationformatId) REFERENCES tblAnnotationFormats(Id),
	CONSTRAINT FK_tblHailstormRequests_tblDatasets FOREIGN KEY (DatasetId) REFERENCES tblDatasets(Id),
	CONSTRAINT FK_tblHailstormRequests_tblModelOptions FOREIGN KEY (ModelOptionId) REFERENCES tblModelOptions(Id)
);
GO

CREATE TABLE tblHealthCheck (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	UserId uniqueidentifier NOT NULL,
	DeviceId uniqueidentifier NULL,
	[Type] int NOT NULL,
	CreatedDate datetime NOT NULL,
	LastUpdatedOn datetime NOT NULL,
	IsDowntimeNotified bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblHealthCheck PRIMARY KEY (Id),
	CONSTRAINT FK_tblHealthCheck_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblHealthCheck_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblHeatmapRequest (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	UserId uniqueidentifier NULL,
	StartTime datetime NOT NULL,
	EndTime datetime NOT NULL,
	ImageLocation nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedDate datetime NOT NULL,
	IsProcessed bit DEFAULT 0 NOT NULL,
	ProcessedDate datetime NULL,
	CONSTRAINT PK_tblHeatmapRequest PRIMARY KEY (Id),
	CONSTRAINT FK_tblHeatmapRequest_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblHeatmapRequest_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblLabels (
	Id uniqueidentifier NOT NULL,
	Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	DatasetId uniqueidentifier NOT NULL,
	AnnotationTypeId uniqueidentifier NOT NULL,
	Color varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Status int NULL,
	CreatedBy uniqueidentifier NULL,
	CreatedOn datetime NULL,
	UpdatedBy uniqueidentifier NULL,
	UpdatedOn datetime NULL,
	IsSynced bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK_tblLabels PRIMARY KEY (Id),
	CONSTRAINT FK_tblLabels_tblAnnotationTypes FOREIGN KEY (AnnotationTypeId) REFERENCES tblAnnotationTypes(Id),
	CONSTRAINT FK_tblLabels_tblDatasets FOREIGN KEY (DatasetId) REFERENCES tblDatasets(Id),
	CONSTRAINT FK_tblLabels_tblUser FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblMaskAlert (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	NoMaskDetected bit NOT NULL,
	AreaId uniqueidentifier NULL,
	TimeOfDetection datetime NOT NULL,
	[Image] varbinary(MAX) NULL,
	Status int NULL,
	ImageLocation varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblMaskAlert PRIMARY KEY (Id),
	CONSTRAINT FK_tblMaskAlert_tblAreas FOREIGN KEY (AreaId) REFERENCES tblAreas(Id),
	CONSTRAINT FK_tblMaskAlert_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE TABLE tblObjectDetection (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	ObjectType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ProcessedImageLocation varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CroppedImageLocation varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TimeOfDetection datetime NOT NULL,
	AppUserId uniqueidentifier NULL,
	Confidence real NOT NULL,
	Color varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BoundingBox varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeviceId uniqueidentifier NULL,
	AppId uniqueidentifier NULL,
	[Type] int NULL,
	IsSynced bit DEFAULT 0 NULL,
	CONSTRAINT PK_tblObjectDetection PRIMARY KEY (Id),
	CONSTRAINT fk_tblObjectDetection_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE TABLE tblPeopleCount (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	AreaId uniqueidentifier NULL,
	PersonCount int NULL,
	DeviceId uniqueidentifier NULL,
	TimeOfDetection datetime NULL,
	CONSTRAINT PK_tblPeopleCount PRIMARY KEY (Id),
	CONSTRAINT FK_tblPeopleCount_tblAreas FOREIGN KEY (AreaId) REFERENCES tblAreas(Id),
	CONSTRAINT FK_tblPeopleCount_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE NONCLUSTERED INDEX index_PeopleCount ON dbo.tblPeopleCount (  AreaId ASC  )
	 INCLUDE ( DeviceId , Id , PersonCount , TimeOfDetection )
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
GO

CREATE TABLE tblPeopleCountParameters (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	deviceApplicationId uniqueidentifier NOT NULL,
	gateStartX int NOT NULL,
	gateStartY int NOT NULL,
	gateEndX int NOT NULL,
	gateEndY int NOT NULL,
	Confidence real DEFAULT 40 NOT NULL,
	[Type] int DEFAULT 2 NOT NULL,
	OppositeDirection bit DEFAULT 0 NULL,
	CONSTRAINT IX_tblPeopleCountParameters UNIQUE (deviceApplicationId),
	CONSTRAINT PK_tblPeopleCountParameters PRIMARY KEY (Id),
	CONSTRAINT FK_tblPeopleCountParameters_tblDeviceApplication FOREIGN KEY (deviceApplicationId) REFERENCES tblDeviceApplication(Id)
);
GO

CREATE TABLE tblProjectionParams (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	AppUserId uniqueidentifier NULL,
	BottomLeft_x int NOT NULL,
	BottomLeft_y int NOT NULL,
	TopLeft_x int NOT NULL,
	TopLeft_y int NOT NULL,
	TopRight_x int NOT NULL,
	TopRight_y int NOT NULL,
	BottomRight_x int NOT NULL,
	BottomRight_y int NOT NULL,
	Distance real NOT NULL,
	Point1_x int NOT NULL,
	Point1_y int NOT NULL,
	Point2_x int NOT NULL,
	Point2_y int NOT NULL,
	OrigImage varbinary(MAX) NULL,
	TransformationMatrix varbinary(MAX) NULL,
	CrowdThreshold int DEFAULT 4 NULL,
	[Transform] bit DEFAULT 1 NULL,
	CONSTRAINT PK_tblSocialDistParameters PRIMARY KEY (Id),
	CONSTRAINT FK_tblSocialDistParameters_tblSocialDistParameters FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE TABLE tblUniquePeople (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	TimeOfDetection datetime NOT NULL,
	ImageLocation varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Age real NULL,
	Gender varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BoundingBox varbinary(MAX) NULL,
	FacialEncoding varbinary(MAX) NULL,
	Masked bit NULL,
	FaceTemperatureCelsius real NULL,
	FacePicture varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FaceCapturePicture varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ThermalPicture varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	isAbnormalTemp bit DEFAULT 0 NULL,
	DeviceId uniqueidentifier NULL,
	DeviceApplicationId uniqueidentifier NULL,
	FaceReferenceId uniqueidentifier NULL,
	BookingId int NULL,
	QRcode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NumberOfBookings int NULL,
	Name varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Email varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Phone varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ManualEntry bit DEFAULT 0 NULL,
	CONSTRAINT PK_tblUniquePeople PRIMARY KEY (Id),
	CONSTRAINT FK_tblUniquePeople_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblUniquePeople_tblFaceDetection FOREIGN KEY (FaceReferenceId) REFERENCES tblFaceDetection(Id)
);
GO

CREATE TABLE tblUserDevices (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	DeviceId uniqueidentifier NOT NULL,
	UserId uniqueidentifier NOT NULL,
	CONSTRAINT PK_tblUserDevices PRIMARY KEY (Id),
	CONSTRAINT FK_tblUserDevices_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblUserDevices_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblUserGroup (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	GroupId uniqueidentifier NOT NULL,
	UserId uniqueidentifier NOT NULL,
	Status int NOT NULL,
	CONSTRAINT PK_tblUserGroup PRIMARY KEY (Id),
	CONSTRAINT FK_tblUserGroup_tblGroup FOREIGN KEY (GroupId) REFERENCES tblGroup(Id),
	CONSTRAINT FK_tblUserGroup_tblUser FOREIGN KEY (UserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblAccessGateEntry (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	VisitorId uniqueidentifier NULL,
	DeviceId uniqueidentifier NOT NULL,
	[Timestamp] datetime NOT NULL,
	CONSTRAINT PK_tblAccessGateEntry PRIMARY KEY (Id),
	CONSTRAINT FK_tblAccessGateEntry_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id),
	CONSTRAINT FK_tblAccessGateEntry_tblUniquePeople FOREIGN KEY (VisitorId) REFERENCES tblUniquePeople(Id)
);
GO

CREATE TABLE tblAlerts (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	AreaId uniqueidentifier NULL,
	DeviceId uniqueidentifier NULL,
	TimeOfDetection datetime NULL,
	Status int NULL,
	ImageLocation nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ApplicationId uniqueidentifier NULL,
	FaceReferenceId uniqueidentifier NULL,
	Severity int NULL,
	Message nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsSynced bit DEFAULT 0 NULL,
	SyncDate datetime NULL,
	ImageKey nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_tblFireAlerts PRIMARY KEY (Id),
	CONSTRAINT FK_tblAlerts_tblApp FOREIGN KEY (ApplicationId) REFERENCES tblApp(Id),
	CONSTRAINT FK_tblAlerts_tblFaceDetection FOREIGN KEY (FaceReferenceId) REFERENCES tblFaceDetection(Id),
	CONSTRAINT FK_tblFireAlerts_tblAreas FOREIGN KEY (AreaId) REFERENCES tblAreas(Id),
	CONSTRAINT FK_tblFireAlerts_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE NONCLUSTERED INDEX IX_NC_tblAlerts_DeviceId_TimeOfDetection ON dbo.tblAlerts (  DeviceId ASC  , TimeOfDetection ASC  )
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
GO

CREATE NONCLUSTERED INDEX IX_NC_tblAlerts_TimeOfDetection_Include_DeviceId ON dbo.tblAlerts (  TimeOfDetection ASC  )
	 INCLUDE ( DeviceId )
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;
GO

CREATE TABLE tblAreaDevices (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	AreaId uniqueidentifier NULL,
	DeviceId uniqueidentifier NULL,
	CONSTRAINT PK_tblAreaDevices PRIMARY KEY (Id),
	CONSTRAINT FK_tblAreaDevices_tblAreas FOREIGN KEY (AreaId) REFERENCES tblAreas(Id),
	CONSTRAINT FK_tblAreaDevices_tblDevice FOREIGN KEY (DeviceId) REFERENCES tblDevice(Id)
);
GO

CREATE TABLE tblDatasetImages (
	Id uniqueidentifier NOT NULL,
	DatasetId uniqueidentifier NULL,
	HailstormImageId uniqueidentifier NULL,
	Status int DEFAULT 0 NOT NULL,
	CreatedBy uniqueidentifier NULL,
	CreatedOn datetime NULL,
	UpdatedBy uniqueidentifier NULL,
	UpdatedOn datetime NULL,
	IsAutoAnnotated bit NULL,
	IsSynced bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblDatasetImages PRIMARY KEY (Id),
	CONSTRAINT FK_tblDatasetImages_tblDatasets FOREIGN KEY (DatasetId) REFERENCES tblDatasets(Id),
	CONSTRAINT FK_tblDatasetImages_tblHailstromImages FOREIGN KEY (HailstormImageId) REFERENCES tblHailstormImages(Id),
	CONSTRAINT FK_tblDatasetImages_tblUser FOREIGN KEY (CreatedBy) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblDetectedUserMapping (
	Id uniqueidentifier DEFAULT newid() NOT NULL,
	FaceReferenceId uniqueidentifier NOT NULL,
	DetectedUserId uniqueidentifier NOT NULL,
	Confidence real NOT NULL,
	CONSTRAINT FK_tblDetectedUserMapping_tblFaceDetection FOREIGN KEY (FaceReferenceId) REFERENCES tblFaceDetection(Id),
	CONSTRAINT FK_tblDetectedUserMapping_tblUser FOREIGN KEY (DetectedUserId) REFERENCES tblUser(Id)
);
GO

CREATE TABLE tblDeviceAppConfig (
	Id uniqueidentifier NOT NULL,
	DeviceApplicationId uniqueidentifier NOT NULL,
	PolygonPoints varbinary(MAX) NOT NULL,
	Sensitivity int NULL,
	FireSize int NULL,
	AlertInterval int NULL,
	FrameWidth int NULL,
	FrameHeight int NULL,
	StartTime datetime NULL,
	EndTime datetime NULL,
	Direction int NULL,
	EntryExit int NULL,
	Distance real NULL,
	TransformationPoints varbinary(MAX) NULL,
	CrowdThreshold int DEFAULT 4 NULL,
	[Transform] bit DEFAULT 0 NULL,
	EnableCrowdProximity bit DEFAULT 1 NULL,
	CONSTRAINT PK_tblFireDetectionConfig PRIMARY KEY (Id),
	CONSTRAINT FK_tblDeviceApplication FOREIGN KEY (DeviceApplicationId) REFERENCES tblDeviceApplication(Id)
);
GO

CREATE TABLE tblDatasetImageLabels (
	Id uniqueidentifier NOT NULL,
	LabelId uniqueidentifier NULL,
	DatasetImageId uniqueidentifier NULL,
	Annotation varbinary(MAX) NULL,
	Status int NULL,
	Confidence real NULL,
	IsSynced bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_tblDatasetImageLabels PRIMARY KEY (Id),
	CONSTRAINT FK_tblDatasetImageLabels_tblDatasetImages FOREIGN KEY (DatasetImageId) REFERENCES tblDatasetImages(Id),
	CONSTRAINT FK_tblDatasetImageLabels_tblLabels FOREIGN KEY (LabelId) REFERENCES tblLabels(Id)
);
GO