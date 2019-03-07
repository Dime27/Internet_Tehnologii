using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Web.Services;
using System.Net;
using System.Web.UI.HtmlControls;

public partial class Glavna_strana : System.Web.UI.Page
{
    // SqlConnection con;
    //SqlCommand command;

    protected void Page_Load(object sender, EventArgs e)
    {
        // string username = Session["username"].ToString();

        if (!IsPostBack)
        {
            string cs = (string)Session["connectionstring"];
            using (SqlConnection con = new SqlConnection(cs))
            {
                int imaslika = 0;
                int imauser = 0;
                string displayname = "";

                SqlCommand cmd = new SqlCommand("sp_GetImageByUsername", con);
                cmd.CommandType = CommandType.StoredProcedure;


                SqlParameter paramUsername = new SqlParameter()
                {
                    ParameterName = "@Username",
                    Value = Session["username"]
                };
                cmd.Parameters.Add(paramUsername);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                string slikichka="";

                while (reader.Read())
                {
                    imauser = (int)reader[0];
                    imaslika = (int)reader[1];
                    if (imaslika == 1)
                        slikichka = (string)reader[2];
                    if (imauser == 1)
                        displayname = (string)reader[3] + " " + (string)reader[4];



                }

                if ((imauser == 1) && (imaslika == 1))
                {

                   
                    profile.ImageUrl = "~/Uploads/" + slikichka;
                    Image1.ImageUrl = "~/Uploads/" + slikichka;
                    displayName.InnerText = displayname;
                    name.InnerText = displayname;

                }

                else
                {
                    profile.ImageUrl = "img/profile.jpg";
                    Image1.ImageUrl = "img/profile.jpg";
                    displayName.InnerText = displayname;
                    name.InnerText = displayname;
                }

                con.Close();

                
                  
            }
           
        }
       

      


        //---------READ POSTS FROM TABLES------------
        string cs2 = (string)Session["connectionstring"];
        using (SqlConnection con = new SqlConnection(cs2))
        {

            SqlCommand cmd = new SqlCommand("sp_GetPosts", con);
            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            string strDivs = string.Empty;
            while (reader.Read())
            {

                string profilnaimgurl = "";




                //IdPost,        [0]
                //Username,      [1]
                //Post,          [2]
                //Plikes,        [3]
                //Nlikes,        [4]
                //Firstname,     [5]
                //Lastname       [6]
                //Picture        [7]
                //HasPicture     [8]

                if ((int)reader[8] == 0)
                    profilnaimgurl = "img/profile.jpg";
                else
                {
                    profilnaimgurl = "Uploads/" + (string)reader[7];

                }


                divOnPage.Controls.Add(new LiteralControl("<div class='row'><div class='col-xs-12 col-sm-12 col-md-12 col-lg-12'><div class='panel panel-primary'><div class='panel-body'><div class='row'><div class='col-xs-12 col-sm-12 col-md-12 col-lg-12 text-left marginPost'><div id='zaslika' runat='server'></div><img id='slika' runat='server' class='imgPost' src='" + profilnaimgurl + "'/><asp:Image ID='Image2' CssClass='imgPost' runat='server' ImageUrl='img/profile.jpg' /><h4 style='display:inline-block; margin-left:10px; margin-top:1px;'> " + (string)reader[5] + " " + (string)reader[6] + "</h4></div><div class='col-xs-12 col-sm-12 col-md-12 col-lg-12 text-left'><p class='paragrafPost'>" + (string)reader[2] + "</p></div></div></div>"));


                divOnPage.Controls.Add(new LiteralControl("<div class='panel-footer'>"));

                Button LikeButton = new Button();
                LikeButton.ID = "BtnLike" + (int)reader[0];
                LikeButton.Text ="Like ("+((int)reader[3]).ToString()+ ")";
                LikeButton.CssClass = "btn btn-info btnLikes";
                LikeButton.Click += new EventHandler(Likes);
            

                Button DislikeButton = new Button();
                DislikeButton.ID = "BtnDislike" + (int)reader[0];
                DislikeButton.Text ="Dislike ("+((int)reader[4]).ToString()+ ")";
                DislikeButton.CssClass = "btn btn-danger btnLikes";
                DislikeButton.Click += new EventHandler(Likes);

               
                divOnPage.Controls.Add(LikeButton);
                divOnPage.Controls.Add(DislikeButton);
                divOnPage.Controls.Add(new LiteralControl("</div></div></div></div>"));


            }

            con.Close();

        }
       



    }

   


   
    protected void Likes(object sender, EventArgs e)
    {
        /*@IdPost smallint,
	      @FromUser varchar (20),
	      @Value  smallint  --  +1 for like, -1 for dislike
         */
   


        int value = 0;
        int brpost = 0;

        Button button = (Button)sender;
        string buttonid = button.ID;

        if (buttonid.Substring(0, 7) == "BtnLike")
        {
            value = 1;

            brpost = Convert.ToInt16(buttonid.Substring(7, buttonid.Length - 7));

        }
        else
        if (buttonid.Substring(0, 10) == "BtnDislike")
        {
            value = -1;
            brpost = Convert.ToInt16(buttonid.Substring(10, buttonid.Length - 10));

        }

        String connectionstring;
        connectionstring = (string)Session["connectionstring"];

        using (SqlConnection con = new SqlConnection(connectionstring))
        {
            SqlCommand cmd = new SqlCommand("sp_PutLike", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter paramIdPost = new SqlParameter()
            {
                ParameterName = @"IdPost",
                Value = brpost
            };
            cmd.Parameters.Add(paramIdPost);

            SqlParameter paramValue = new SqlParameter()
            {
                ParameterName = "@Value",
                Value = value
            };
            cmd.Parameters.Add(paramValue);

            SqlParameter paramName = new SqlParameter()
            {
                ParameterName = @"FromUser",
                Value = Session["username"].ToString()
            };
            cmd.Parameters.Add(paramName);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();


        }

       Response.Redirect("GlavnaStrana.aspx");
       


    }


    //------------------SIGN OUT---------------

    protected void sign_out_Click(object sender, EventArgs e)
    {
        
        Response.Redirect("Pocetna.aspx");
        //ne bi trebalo ova da treba// Session["username"] = "";
    }

    //---------------------UPLOAD PHOTO--------------
    protected void btnsave_Click(object sender, EventArgs e)
    {
        

        // If the user has selected a file
        if (fileupload.HasFile)
        {
            // Get the file extension
            string fileExtension = System.IO.Path.GetExtension(fileupload.FileName);
            string FileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(fileupload.FileName);
            string ime = FileNameWithoutExtension + System.DateTime.Now.ToString("ddMMyyhhmmss") + fileExtension;

            if (fileExtension.ToLower() != ".jpg")
            {
                lblporaka.ForeColor = System.Drawing.Color.Red;
                lblporaka.Text = "Only files with .jpg extension are allowed";
            }
            else
            {

                // Get the file size
                int fileSize = fileupload.PostedFile.ContentLength;
                // If file size is greater than 10 MB
                if (fileSize > 10485760)
                {
                    lblporaka.ForeColor = System.Drawing.Color.Red;
                    lblporaka.Text = "File size cannot be greater than 10 MB";
                }
                else
                {
                    //---------START SQL UPLOAD---------

                    String connectionstring;
                      connectionstring = (string)Session["connectionstring"];

                    Stream stream = fileupload.PostedFile.InputStream;
                    BinaryReader binaryReader = new BinaryReader(stream);
                    Byte[] bytes = binaryReader.ReadBytes((int)stream.Length);



                    using (SqlConnection con = new SqlConnection(connectionstring))
                    {
                        SqlCommand cmd = new SqlCommand("sp_UploadPhoto", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        SqlParameter paramName = new SqlParameter()
                        {
                            ParameterName = @"Username",
                            Value = Session["username"]
                        };
                        cmd.Parameters.Add(paramName);

                        SqlParameter paramImageData = new SqlParameter()
                        {
                            ParameterName = "@PictureFileName",
                            Value = ime
                        };
                        cmd.Parameters.Add(paramImageData);



                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();





                    }


                    //--------END SQL UPLOAD-----------


                    // Upload the file
                   

                    fileupload.SaveAs(Server.MapPath("~/Uploads/" + ime));
                    lblporaka.ForeColor = System.Drawing.Color.Green;
                    lblporaka.Text = "File uploaded successfully";
                    profile.ImageUrl = "~/Uploads/" + ime;
                    Image1.ImageUrl = "~/Uploads/" + ime;



                }
            }
        }
        else
        
            {
                lblporaka.ForeColor = System.Drawing.Color.Red;
                lblporaka.Text = "Please select a file";
            }

      
       Response.Redirect("GlavnaStrana.aspx");


    }



    protected void btnPost_Click(object sender, EventArgs e)
    {
        /* create procedure[dbo].[sp_WritePost] (
     @Username varchar(20),
     @Post varchar(500)
     */

        //---------START SQL UPLOAD---------

        String connectionstring;
        connectionstring = (string)Session["connectionstring"];

        using (SqlConnection con = new SqlConnection(connectionstring))
        {
            SqlCommand cmd = new SqlCommand("sp_WritePost", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter paramName = new SqlParameter()
            {
                ParameterName = @"Username",
                Value = Session["username"]
            };
            cmd.Parameters.Add(paramName);

            SqlParameter paramText = new SqlParameter()
            {
                ParameterName = "@Post",
                Value = textPost.Text 
            };
            cmd.Parameters.Add(paramText);



            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            textPost.Text = "";
           

        }
        
        Response.Redirect("GlavnaStrana.aspx");
        //--------END SQL UPLOAD-----------

    }
}

        