using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for Servis
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Servis : System.Web.Services.WebService
{

    public Servis()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    public readonly string CONNECTION_STRING = "Data Source=DESKTOP-P4MTA9N\\SQLEXPRESS;Initial Catalog=Northwind;Integrated Security=True";
    List<String> usernames;

    [WebMethod]
    public Boolean SignIn(string displayName, string password)
    {
        FillUsernames();
        
        if (usernames.Contains(displayName))
        {
            if (password == FindPassword(displayName))
            {
                return true;
            }
        }

        return false;
        
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

    private string FindPassword(string username)
    {
        List<string> passwords = new List<string>();
        using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
        {
            connection.Open();
            string query = "SELECT Password FROM UserData WHERE Username='" + username + "'";
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
}
