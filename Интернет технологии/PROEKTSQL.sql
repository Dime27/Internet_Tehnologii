use [Northwind]


if not exists (select * from sysobjects where name = 'userdata' and xtype='u' )
begin 
	CREATE TABLE [dbo].[UserData](
		[Username] [varchar](20) NOT NULL,
		[Firstname] [varchar](20) NULL,
		[Lastname] [varchar](20) NULL,
		[Password] [varchar](20) NULL,
		[PictureFileName] [varchar](200) NULL,
	PRIMARY KEY CLUSTERED 
	(
		[Username] ASC
	)
	) 
end
GO



IF NOT EXISTS (SELECT 1  FROM SYS.COLUMNS WHERE  
OBJECT_ID = OBJECT_ID(N'[dbo].[UserData]') AND name = 'PictureFileName')
BEGIN
	ALTER TABLE [dbo].[UserData] ADD PictureFileName [varchar](200) NULL
END

if  exists (select * from sysobjects where name = 'sp_UploadPhoto' and xtype='p' )
drop procedure [dbo].[sp_UploadPhoto]
go

create procedure[dbo].[sp_UploadPhoto] (
	@Username varchar(20),
	@PictureFileName varchar (200)
)
as 
begin
	update UserData set PictureFileName=@PictureFileName where Username=@username

end
go




if  exists (select * from sysobjects where name = 'sp_GetImageByUsername' and xtype='p' )
drop procedure [dbo].[sp_GetImageByUsername]
go
/*
	test 
	exec [sp_GetImageByUsername] 'ferhunde'
	exec [sp_GetImageByUsername] 'unique'
	exec [sp_GetImageByUsername] 'nikoj'

	select * from UserData

*/ 
create procedure[dbo].[sp_GetImageByUsername] (
	@Username varchar(20)
	
)
as 
begin
	 declare 
		@imauser int, 
		@imaslika int,
		@PictureFileName varchar(200),
		@Firstname varchar(20), 
		@Lastname varchar(20)
	set @imaslika=0	
	set @imauser=0
	set @Firstname='' 
	set @Lastname=''


	Select @imauser=1,
	@PictureFileName=PictureFileName, 
	@Firstname=Firstname,
	@Lastname=Lastname

    from UserData where Username=@Username

	if @PictureFileName is not null
		set @imaslika=1
	select @imauser 'imauser' ,@imaslika 'imaslika' ,@PictureFileName 'PictureFileName',@Firstname 'Firstname',
	@Lastname 'Lastname'
end
go


--drop table Posts 
if not exists (select * from sysobjects where name = 'Posts' and xtype='u' )
begin 
	CREATE TABLE [dbo].[Posts](
		[Username] [varchar](20) NOT NULL,	
		[Post] [varchar](500) NULL,
		[IdPost] [int] identity (1,1))
	
end
GO

 

--drop table Likes 
if not exists (select * from sysobjects where name = 'Likes' and xtype='u' )
begin 
	CREATE TABLE [dbo].[Likes](
		[IdPost] [int] NOT NULL,
		[FromUser] [varchar] (20) NOT NULL,
		[Lajkovi] [smallint] NULL,
		
	PRIMARY KEY CLUSTERED 
	(
		[IdPost], [FromUser] ASC
	)
	) ON [PRIMARY]
end
GO


if  exists (select * from sysobjects where name = 'sp_WritePost' and xtype='p' )
drop procedure [dbo].[sp_WritePost]
go
/*
	test 
	exec [sp_GetImageByUsername] 'ferhunde'
	exec [sp_GetImageByUsername] 'unique'
	exec [sp_GetImageByUsername] 'nikoj'

	select * from UserData

*/ 
create procedure[dbo].[sp_WritePost] (
	@Username varchar(20),
	@Post  varchar(500)
	
)
as 
begin
	insert into Posts(Username,Post) select @Username,@Post
end
go


if  exists (select * from sysobjects where name = 'sp_PutLike' and xtype='p' )
drop procedure [dbo].[sp_PutLike]
go
/*
	test 
	exec [sp_GetImageByUsername] 'ferhunde'
	exec [sp_GetImageByUsername] 'unique'
	exec [sp_GetImageByUsername] 'nikoj'

	select * from UserData

*/ 
create procedure[dbo].[sp_PutLike] (
	@IdPost smallint,
	@FromUser varchar (20),
	@Value  smallint  --  +1 for like, -1 for dislike
	
)
as 
begin
	if exists (select * from Posts where IdPost=@IdPost and Username=@FromUser)
		return

	declare @recordexists smallint,
			@currValue smallint
	if exists (select * from Likes where IdPost=@IdPost and FromUser=@FromUser) 
		set @recordexists=1
	else
		set @recordexists=0
		
	if @recordexists=0
	begin
		insert into Likes (IdPost,FromUser,Lajkovi) select @IdPost,@FromUser,0
	end 


	select @currValue=lajkovi from Likes where IdPost=@IdPost and FromUser=@FromUser
	
	if @currValue=0  and @value=1
		update Likes set Lajkovi=1 where IdPost=@IdPost and FromUser=@FromUser
	else if @currValue=0  and @Value=-1
		update Likes set Lajkovi=-1 where IdPost=@IdPost and FromUser=@FromUser
	else if @currValue=1  and @Value=1
		update Likes set Lajkovi=0 where IdPost=@IdPost and FromUser=@FromUser
	else if @currValue=-1  and @Value=-1
		update Likes set Lajkovi=0 where IdPost=@IdPost and FromUser=@FromUser
	else if (@currValue=1 and @Value=-1) 
		update Likes set Lajkovi=-1 where IdPost=@IdPost and FromUser=@FromUser
	else if (@currValue=-1 and @Value=1) 
		update Likes set Lajkovi=1 where IdPost=@IdPost and FromUser=@FromUser

--	else if (@currValue=1 and @Value=-1) or (@currValue=-1 and @Value=1)
--		update Likes set Lajkovi=0 where IdPost=@IdPost and FromUser=@FromUser
end
go



if  exists (select * from sysobjects where name = 'sp_GetPosts' and xtype='p' )
drop procedure [dbo].[sp_GetPosts]
go
/*
	test 
	exec [sp_GetImageByUsername] 'ferhunde'
	exec [sp_GetImageByUsername] 'unique'
	exec [sp_GetImageByUsername] 'nikoj'

	select * from UserData

*/ 
create procedure[dbo].[sp_GetPosts] 

as 
begin
	select IdPost, count(*) PLikes
	into #tmplikesp 
	from Likes where Lajkovi=1
	group by IdPost

	select IdPost, count(*) NLikes
	into #tmplikesn 
	from Likes where Lajkovi=-1
	group by IdPost

	select p.IdPost, p.Username, p.Post, isnull (tp1.PLikes,0) as Plikes, 
	isnull (tp2.NLikes,0) as Nlikes, u.Firstname, u.Lastname, u.PictureFileName as PictureFileName,
	case when
	u.PictureFileName is null then
	0
	else
	1
	end as HasPicture
	
	from Posts p 
	--left join Likes l on p.IdPost=l.IdPost
	left join #tmplikesp tp1 on tp1.IdPost=p.IdPost
	left join #tmplikesn tp2 on tp2.IdPost=p.IdPost
	join UserData u on u.Username=p.Username
	order by p.IdPost desc
end
go



--select * from Posts

--select * from Likes
--sp_getposts

--select * from userdata

--truncate table Likes
 --delete  from Posts
--update Posts set post='No one can make you feel inferior without your consent.' where IdPost=3



/*  Pump auto data
declare @i int
set @i=100
while @i>0 
begin
 --select * from posts
	insert into posts(username,post) select 'verica', 'Oost number no:'+cast(@i as varchar(10))
	set @i = @i - 1
end

*/


