import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.identitymanagement.AmazonIdentityManagementClient;
import com.amazonaws.services.identitymanagement.model.ListUsersRequest;
import com.amazonaws.services.identitymanagement.model.ListUsersResult;
import com.amazonaws.services.identitymanagement.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/Index")
public class index extends HttpServlet {
    String nombreUser;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("user");
        String password = req.getParameter("password");

        BasicAWSCredentials awsCreds = new BasicAWSCredentials(CredentialsIam.access_key_id, CredentialsIam.secret_access_key);

        AmazonIdentityManagementClient iam = new AmazonIdentityManagementClient(awsCreds);

        boolean done = false;
        ListUsersRequest request = new ListUsersRequest();

        //Obtenemos el listado de los nombres de los usuarios
        while(!done) {
            ListUsersResult response = iam.listUsers(request);

            for(User user : response.getUsers()) {
                if(userName.equals(user.getUserName()) && password.equals("test321")) {
                    iam.shutdown();
                    RequestDispatcher dd = req.getRequestDispatcher("home.jsp");
                    dd.forward(req, resp);
                }
            }

            request.setMarker(response.getMarker());
            if(!response.getIsTruncated()) {
                done = true;
                iam.shutdown();
                RequestDispatcher dd = req.getRequestDispatcher("index.jsp");
                dd.forward(req, resp);
            }
        }


    }
}
