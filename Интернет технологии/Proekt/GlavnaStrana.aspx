<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GlavnaStrana.aspx.cs" Inherits="Glavna_strana" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <title>Ime</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/GlavnaCSS.css" rel="stylesheet">

    <!-- Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Marck+Script" rel="stylesheet">

    <style type="text/css">
        .kopceOdjaviSe {
            margin-top: 10px;
        }
    </style>


</head>
<body>
    <form id="form1" runat="server">
    <div>
        <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <div class="row">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 text-center">
                        <asp:Image ID="profile" runat="server" ImageUrl="img/profile.jpg" /><br />
                        <asp:HyperLink ID="changePhoto" href="#modalPhoto" runat="server" data-toggle="modal">Change Photo</asp:HyperLink>
                    </div>
                    <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
                        <p id="displayName" runat="server">Display Name</p>>
                    </div>
                </div>
            </div>

            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 text-right">
                <ul class="nav navbar-nav navbar-right list-inline">
                        <li>
                            <asp:Button ID="sign_out" runat="server" CssClass="btn btn-success btn-block kopceOdjaviSe" Height="46px" OnClick="sign_out_Click" Text="SIGN OUT" Width="165px" />
                        </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6 sectionRow">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="panel panel-primary">
                    <div class="panel-heading text-center">Write a new post</div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-left marginPost">
                                <asp:Image ID="Image1" CssClass="imgPost" runat="server" ImageUrl="img/profile.jpg" />
                                <h4 style="display: inline-block; margin-left: 10px; margin-top: 1px;" id="name" runat="server">Display Name</h4>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-left">
                                <asp:TextBox ID="textPost" rows="5" TextMode="MultiLine" placeholder="Let people know what you have to say..." runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer text-right">
                        <asp:Button type="submit" ID="btnPost" runat="server" Text="Post" CssClass="btn btn-success" OnClick="btnPost_Click" />
                    </div>
                </div>
            </div>
        </div>

        <asp:Placeholder runat="server" ID="ph" />

       

          <div id="divOnPage" runat="server">
    
    </div>

   <!-- </section>-->

    <!-- Modal Content -->
    <div class="portfolio-modal modal fade container" id="modalPhoto">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr"><div class="rl"></div></div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <h2>Change Your Photo</h2>
                            <hr class="star-primary">
                            <asp:Image ID="slikaModal" runat="server" ImageUrl="img/profile.jpg" CssClass="img-responsive"/>
                           
                            <asp:FileUpload ID="fileupload" runat="server" style="display:inline; width: 225px; height: 43px; margin-right: 3px;" CssClass="btn btn-info"  />
                            <asp:Button ID="btnsave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnsave_Click" />
                            <asp:Label ID="lblporaka" runat="server" ></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
       <input id="Hidden1" type="hidden" runat="server" />

        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" 
    EnablePageMethods="true" 
    EnablePartialRendering="true" runat="server" />
    </form>

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/portfolio.js"></script>

    <script>
        /*Change Photo Text*/
        $('nav').hover(function(){
            $('#changePhoto').show();
        }, function(){
            $('#changePhoto').hide();
        })
    </script>
    <!--FILE CHANGE EVENT-->
    <script>
        var names = [];
        $("#fileupload").change(function (e) {
            var name = e.target.files[0].name;
            names.push(name);
            document.getElementById("<%= slikaModal.ClientID %>").src="Uploads/" + name + "";
        });
    </script>


    <!--PRIKAZ NA SLIKA VO KRUGOT-->
    <script>
        var el = document.getElementById("<%= changePhoto.ClientID %>");
        el.onclick = PrikaziSlika;

        function PrikaziSlika() {
            var img_src = document.getElementById("<%= profile.ClientID %>").src;
            document.getElementById("<%= slikaModal.ClientID %>").src = img_src;
             
        }

    </script>

   
 <script>

     $(document).ready(function () {
         $(".btnLikes").append("<span class='fa fa-thumbs-down'></span>");
         //alert("tuka sme");
     });
   
  </script>
    


</body>
</html>
