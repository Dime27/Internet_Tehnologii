/* ----DELETE OLD DATA-----
truncate table Userdata
go 
truncate table Posts
go 
truncate table Likes
go
*/


SET QUOTED_IDENTIFIER OFF
GO
INSERT INTO UserData
([Username],[Firstname],[Lastname],[Password],[PictureFileName])
VALUES
("mare","Marija","Lozanova","123","kate_winslet1100917061651.jpg")
GO
INSERT INTO UserData
([Username],[Firstname],[Lastname],[Password],[PictureFileName])
VALUES
("petar","Petar","Petrovski","123","fb6549ee1e6cbdeb6eba6aa1adbb80b7--male-studio-photography-head-shots-photography-male100917061436.jpg")
GO
SET QUOTED_IDENTIFIER ON
GO






SET IDENTITY_INSERT posts ON
go
SET QUOTED_IDENTIFIER OFF
GO
INSERT INTO Posts
([Username],[Post],[IdPost])
VALUES
("petar","You only live once, but if you do it right, once is enough.","1")
GO
INSERT INTO Posts
([Username],[Post],[IdPost])
VALUES
("mare","Without music, life would be a mistake.","2")
GO
INSERT INTO Posts
([Username],[Post],[IdPost])
VALUES
("petar","To live is the rarest thing in the world. Most people exist, that is all.","3")
GO
SET QUOTED_IDENTIFIER ON
GO
SET IDENTITY_INSERT posts off
go













SET QUOTED_IDENTIFIER OFF
GO
INSERT INTO Likes
([IdPost],[FromUser],[Lajkovi])
VALUES
("1","mare","1")
GO
INSERT INTO Likes
([IdPost],[FromUser],[Lajkovi])
VALUES
("2","petar","1")
GO
INSERT INTO Likes
([IdPost],[FromUser],[Lajkovi])
VALUES
("3","mare","-1")
GO
SET QUOTED_IDENTIFIER ON
GO
