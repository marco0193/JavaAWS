import Interfaces.Usuarios;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.identitymanagement.AmazonIdentityManagementClient;
import com.amazonaws.services.identitymanagement.model.ListUsersRequest;
import com.amazonaws.services.identitymanagement.model.ListUsersResult;
import com.amazonaws.services.identitymanagement.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/IamList")
public class IamList  extends HttpServlet{

    ArrayList<Usuarios> listUsers = new ArrayList<>();
    //public static int cont = 0;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(CredentialsIam.access_key_id, CredentialsIam.secret_access_key);

        AmazonIdentityManagementClient iam = new AmazonIdentityManagementClient(awsCreds);

        boolean done = false;
        ListUsersRequest request = new ListUsersRequest();

        while(!done) {
            ListUsersResult response = iam.listUsers(request);

            for(User user : response.getUsers()) {
                Usuarios usuario = new Usuarios(user.getUserId(), user.getUserName(), user.getCreateDate().toString());
                listUsers.add(usuario);
            }

            request.setMarker(response.getMarker());
            if(!response.getIsTruncated()) {
                done = true;
            }

        }

        /*req.setAttribute("userId", userId);
        req.setAttribute("userNombres", userNombres);*/
        req.setAttribute("listUsers", listUsers);

        getServletConfig().getServletContext().getRequestDispatcher("/iam.jsp").forward(req, resp);
    }
}
