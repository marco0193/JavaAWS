import Interfaces.Usuarios;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.identitymanagement.AmazonIdentityManagement;
import com.amazonaws.services.identitymanagement.AmazonIdentityManagementClient;
import com.amazonaws.services.identitymanagement.AmazonIdentityManagementClientBuilder;
import com.amazonaws.services.identitymanagement.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/Iam")
public class IamCreate extends HttpServlet {
    public static ArrayList<Usuarios> listUsers = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("nombre");

        crearUser(name);

        req.setAttribute("listUsers", listUsers);

        getServletConfig().getServletContext().getRequestDispatcher("/iam.jsp").forward(req, resp);

    }

    public static void crearUser(String name) {
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(CredentialsIam.access_key_id, CredentialsIam.secret_access_key);
        AmazonIdentityManagementClient iam = new AmazonIdentityManagementClient(awsCreds);
        /*final AmazonIdentityManagement iam = AmazonIdentityManagementClientBuilder
                .standard()
                .withRegion(Regions.US_EAST_1)
                .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                .build();*/

        CreateUserRequest request = new CreateUserRequest().withUserName(name);
        iam.createUser(request);

        boolean done = false;
        ListUsersRequest requestList = new ListUsersRequest();

        while (!done){
            ListUsersResult responseList = iam.listUsers(requestList);

            for(User user : responseList.getUsers()) {
                Usuarios usuario = new Usuarios(user.getUserId(), user.getUserName(), user.getCreateDate().toString());
                listUsers.add(usuario);
            }

            requestList.setMarker(responseList.getMarker());
            if(!responseList.getIsTruncated()) {
                done = true;
            }
        }

        iam.shutdown();

    }
}
