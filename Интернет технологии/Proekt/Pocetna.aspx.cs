using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pocetna : System.Web.UI.Page
{
    SqlConnection connection;
    SqlCommand command;
    //public readonly string CONNECTION_STRING = "Data Source=NAUMPS\\SQLEXPRESS;Initial Catalog = Northwind; Integrated Security = True";
    public readonly string CONNECTION_STRING = "Data Source=DESKTOP-P4MTA9N\\SQLEXPRESS;Initial Catalog=Northwind;Integrated Security=True";
    List<String> usernames;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            Session["connectionstring"] = CONNECTION_STRING;
            command = new SqlCommand();
            usernames = new List<string>();
        }
    }

    protected void btnSignIn_Click(object sender, EventArgs e)
    {
        
     /* FillUsernames();
        if (ValidateSignInBtn())
        {
            if (usernames.Contains(tbLoginUsername.Text))
            {
                if (tbLoginPassword.Text == FindPassword(tbLoginUsername.Text))
                {
                    Session["username"] = tbLoginUsername.Text;
                    
                    Response.Redirect("GlavnaStrana.aspx");
                }
            }
        }

    */
        if (ValidateSignInBtn())
        {
            localhost.Servis korisnik = new localhost.Servis();

            string displayName = tbLoginUsername.Text;
            string password = tbLoginPassword.Text;

            Session["username"] = tbLoginUsername.Text;

            Boolean postoiKorisnik = korisnik.SignIn(displayName, password);

            if (postoiKorisnik)
                Response.Redirect("GlavnaStrana.aspx");
        }

    }
    private Boolean ValidateSignInBtn()
    {
        Boolean flag = true;
        if (tbLoginUsername.Text == "")
        {
            tbLoginUsername.Attributes.Add("placeholder", "Please enter your username!");
            tbLoginUsername.Text = "";
            flag = false;
        }
        if (tbLoginPassword.Text == "")
        {
            tbLoginPassword.Attributes.Add("placeholder", "Please enter your password!");
            tbLoginPassword.Text = "";
            flag = false;
        }
        return flag;
    }

    protected void btn_Register_Click(object sender, EventArgs e)
    {
        // Response.Redirect("GlavnaStrana.aspx");
        if (ValidatedFields())
        {
            UpdateData();
        }

    }

    private Boolean ValidatedFields()
    {
        // true ako nema greski vo input
        Boolean flag = true;
        if (tbFirstname.Text == "")
        {
            tbFirstname.Attributes.Add("placeholder", "This field is required!");
            tbFirstname.Focus();
            flag = false;
        }
        if (tbLastname.Text == "")
        {
            tbLastname.Attributes.Add("placeholder", "This field is required!");
            flag = false;
        }
        if (tbUsername.Text == "")
        {
            tbUsername.Attributes.Add("placeholder", "This field is required!");
            flag = false;
        }
        else
        {
            FillUsernames();
            if(usernames.Contains(tbUsername.Text)){
                tbUsername.Attributes.Add("placeholder", "This username is already in use!");
                tbUsername.Text = "";
                flag = false;
            }
          
        }
        if (tbPassword.Text == "")
        {
            tbPassword.Attributes.Add("placeholder", "This field is required!");
            flag = false;
        }
        if (tbConfirmPass.Text == "")
        {
            tbConfirmPass.Attributes.Add("placeholder", "This field is required!");
            flag = false;
        }
        if(tbPassword.Text != tbConfirmPass.Text)
        {
            tbPassword.Attributes.Add("placeholder", "Your passwords don't match!");
            flag = false;
        }


        return flag;
    }

    private string FindPassword(string username)
    {
        List<string> passwords = new List<string>();
        using(SqlConnection connection = new SqlConnection(CONNECTION_STRING))
        {
            connection.Open();
            string query = "SELECT Password FROM UserData WHERE Username='"+username+"'";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                //command.Parameters.Add("@Username", SqlDbType.Text);
                //command.Parameters["@Username"].Value = username; 
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        passwords.Add(reader.GetString(0));
                    }
                }
            }
        }

        return passwords[0];
    }

    private void FillUsernames()
    {
        usernames = new List<string>();
        using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
        {
            connection.Open();
            string query = "SELECT Username FROM UserData";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        usernames.Add(reader.GetString(0));
                    }
                }
            }

        }
    }

    private void UpdateData()
    {
        connection = new SqlConnection(CONNECTION_STRING);
        command = new SqlCommand();
        command.Connection = connection;
        command.CommandText = "INSERT INTO UserData (Username, Firstname, Lastname, Password) VALUES ('" + tbUsername.Text + "', '" + tbFirstname.Text + "', '" + tbLastname.Text + "', '" + tbPassword.Text + "')";
        try
        {
            connection.Open();
            command.ExecuteNonQuery();
        }
        catch (Exception ex)
        {

        }
        finally
        {
            connection.Close();
            tbFirstname.Attributes.Add("placeholder", "First Name");
            tbLastname.Attributes.Add("placeholder", "Last Name");
            tbUsername.Attributes.Add("placeholder", "Display Name");
            tbPassword.Attributes.Add("placeholder", "Password");
            tbConfirmPass.Attributes.Add("placeholder", "Confirm Password");
            tbFirstname.Text = "";
            tbLastname.Text = "";
            tbUsername.Text = "";
        }
    }
}