import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

public class dB2Connection {
    public static void main(String[] argv) {
        try {
            Class.forName("com.ibm.db2.jdbc.app.DB2Driver");
        }
        catch (ClassNotFoundException e) {
            System.out.println("Please include Classpath  Where your DB2 Driver is located");
            e.printStackTrace();
            return;
        }
        System.out.println("DB2 driver is loaded successfully");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        boolean found = false;
        try {
            conn = DriverManager.getConnection("jdbc:db2:admin", "db2admin", "P@22W0rD");
            if (conn != null)
            {
                System.out.println("DB2 Database Connected");
            }
            else
            {
                System.out.println("Db2 connection Failed ");
            }
            pstmt = conn.prepareStatement("Select * from Demo");
            rset = pstmt.executeQuery();
            if(rset != null)
            {
                while(rset.next())
                {
                    found = true;
                    System.out.println("Class Code: " + rset.getString("clcode"));
                    System.out.println("Name: " + rset.getString("name"));
                }
            }
            if (found == false)
            {
                System.out.println("No Information Found");
            }
        } catch (SQLException e) {
            System.out.println("DB2 Database connection Failed");
            e.printStackTrace();
            return;
        }
    }

}