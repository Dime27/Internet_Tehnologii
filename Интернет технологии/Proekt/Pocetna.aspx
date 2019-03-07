<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true" CodeFile="Pocetna.aspx.cs" Inherits="Pocetna" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <title>Ime</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/PocetnaCSS.css" rel="stylesheet">

    <!-- Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Marck+Script" rel="stylesheet">
    <style type="text/css">
        .auto-style1 {
            display: block;
            width: 100%;
            height: 43px;
            font-size: 15px;
            line-height: 1.42857143;
            color: #2c3e50;
            border-radius: 4px;
            -webkit-box-shadow: none;
            box-shadow: none;
            -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            left: 1px;
            top: 1px;
            border: 2px solid #dce4ec;
            padding: 10px 15px;
            background-color: #ffffff;
            background-image: none;
        }
        .auto-style2 {
            display: block;
            width: 100%;
            height: 43px;
            font-size: 15px;
            line-height: 1.42857143;
            color: #2c3e50;
            border-radius: 4px;
            -webkit-box-shadow: none;
            box-shadow: none;
            -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            left: 0px;
            top: 0px;
            border: 2px solid #dce4ec;
            padding: 10px 15px;
            background-color: #ffffff;
            background-image: none;
        }
        .auto-style3 {
            left: 0px;
            top: 2.2em;
            height: 25px;
        }

        .kopceSignIn {
            margin-top: 6px;
            margin-left: 10px;
        }
    </style>
</head>
<body style="background-image: url(img/bg5.jpg); background-size: cover;">
    <form id="form1" runat="server">
    <div>
       <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header col-md-6 col-sm-12">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs1">
                    <span class="sr-only">Toogle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#page-top">Circle of Trust</a>
            </div>

             <div class="collapse navbar-collapse col-md-6 col-sm-12 text-right" id="bs1">
                <ul class="nav navbar-nav navbar-right list-inline">
                        <li>
                            <asp:TextBox ID="tbLoginUsername" placeholder="Display Name" runat="server" CssClass="form-control"></asp:TextBox>
                        </li>
                        <li>
                            <asp:TextBox ID="tbLoginPassword" placeholder="Password" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </li>
                        <li style="margin-left: 20px">
                            <asp:Button ID="btnSignIn" ButtonType="LinkButton" CssClass="btn btn-success btn-block kopceSignIn" runat="server" Text="Sign In" OnClick="btnSignIn_Click"/>
                        </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container" style="padding-top: 180px;">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-5 col-lg-5">
                <h1 class="text-success naslov-font text-center"><i><strong>Welcome to <br> Circle of Trust</strong></i></h1>
            </div>
            <div class="col-xs-offset-1 col-xs-10 col-sm-offset-1 col-sm-10 col-md-offset-2 col-md-5 col-lg-offset-1 col-lg-6 forms">
                    <h1>Sign Up</h1>
                <form class="form-group" role="form">
                    <div class="row">
                        <div class="col-md-6 floating-label-form-group">
                            <label id="lbFirstname" class="auto-style3">First Name</label>
                            <asp:TextBox  placeholder="First Name" ID="tbFirstname" runat="server" CssClass="auto-style2"></asp:TextBox>

                        </div>
                        <div class="col-md-6 floating-label-form-group">
                            <label id="lbLastname">Last Name</label>
                            <asp:TextBox  placeholder="Last Name" ID="tbLastname" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 floating-label-form-group">
                            <label id="lbUsername">Display Name</label>
                            <asp:TextBox  placeholder="Display Name" ID="tbUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 floating-label-form-group">
                            <label id="lbPassword">Password</label>
                            <asp:TextBox  placeholder="Password" ID="tbPassword" runat="server" CssClass="auto-style1" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="col-md-6 floating-label-form-group">
                            <label id="lbConfirmPass">Confirm Password</label>
                            <asp:TextBox  placeholder="Confirm Password" ID="tbConfirmPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="row">
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"style="padding-right:0px;">
                                    <hr style="border-top:3px solid #33CC33">
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3" style="padding-left:0px; padding-right:0px;">
                                    <hr style="border-top:3px solid #fcff42">
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"style="padding-left:0px; padding-right:0px;">
                                    <hr style="border-top:3px solid #FF9933">
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"style="padding-left:0px; padding-right:0px;">
                                    <hr style="border-top:3px solid #FF0000">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <div class="row">
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"style="padding-left:0px; padding-right:0px;">
                                    <hr style="border-top:3px solid #FF33CC">
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"style="padding-left:0px; padding-right:0px;">
                                    <hr style="border-top:3px solid #990099">
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"style="padding-left:0px; padding-right:0px;">
                                    <hr style="border-top:3px solid #0000FF">
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"style="padding-left:0px;">
                                    <hr style="border-top:3px solid #00CCFF">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button ID="btn_Register" ButtonType="LinkButton" runat="server" Text="Register" CssClass="btn btn-success btn-block" OnClick="btn_Register_Click" EnableViewState="False"/>
                        </div>

                    </div>
                </form>
            </div>

        </div>
    </div>
    <footer class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-left">
                <p>Copyright &copy; FINKI 2017</p>
            </div>
        </div>
    </footer>
    </div>
    </form>

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/portfolio.js"></script>

</body>
</html>
