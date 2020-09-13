import Interfaces.Credentials;
import Interfaces.Instances;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.model.DescribeInstancesRequest;
import com.amazonaws.services.ec2.model.DescribeInstancesResult;
import com.amazonaws.services.ec2.model.Instance;
import com.amazonaws.services.ec2.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/Ec2NewGrid")
public class Ec2 extends HttpServlet {
    public static ArrayList<Instances> listInstances = new ArrayList<>();
    public static ArrayList<Credentials> listCredentials = new ArrayList<>();
    BasicAWSCredentials awsCreds = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String accessKey = req.getParameter("accessKay");
        String secretKay = req.getParameter("aecretKay");
        String idInsrance = req.getParameter("select");
        listInstances.clear();

        if(accessKey != null && secretKay != null){
            listCredentials.clear();
        }

        /*for(Credentials c : listCredentials){
            //agregamos la nueva access kay a la lista
            if(accessKey != c.getAccessKey() && secretKay != c.getSecretKey()){

            }
        }*/

        Credentials credentials = new Credentials(accessKey, secretKay);
        listCredentials.add(credentials);

        BasicAWSCredentials awsCreds = new BasicAWSCredentials(listCredentials.get(0).getAccessKey(),listCredentials.get(0).getSecretKey());

        /*final AmazonEC2 ec2 = AmazonEC2Client.builder()
                .withRegion(Regions.US_EAST_1)
                .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                .build();*/
        AmazonEC2Client ec2 = new AmazonEC2Client(awsCreds).withRegion(Regions.US_EAST_1);

        //Llamamos al metodo que se encarga de crear la lista de instancias
        listEc2(ec2);



        //Cerramos el cliente de Amazon Ec2
        ec2.shutdown();

        req.setAttribute("listInstances", listInstances);
        req.setAttribute("listCred", listCredentials);
        //req.setAttribute("secretKey", secretKay);
        getServletConfig().getServletContext().getRequestDispatcher("/ec2NewGrid.jsp").forward(req, resp);
    }

    //Se encarga de crear el listado de intancias
    public void listEc2(AmazonEC2Client ec2){
        boolean done = false;

        DescribeInstancesRequest request = new DescribeInstancesRequest();

        while(!done){
            DescribeInstancesResult response = ec2.describeInstances(request);

            for(Reservation reservation:response.getReservations()){
                for (Instance instance : reservation.getInstances()){
                    Instances instances = new Instances(instance.getInstanceId(),
                            instance.getTags().get(0).getValue(),
                            instance.getImageId(),
                            instance.getInstanceType(),
                            instance.getState().getName(),
                            instance.getLaunchTime().toString(),
                            instance.getPlacement().getAvailabilityZone(),
                            instance.getPlatform(),
                            instance.getVpcId(),
                            instance.getKernelId(),
                            instance.getPrivateDnsName());

                    listInstances.add(instances);
                }

                request.setNextToken(response.getNextToken());

                if(response.getNextToken() == null){
                    done = true;
                }
            }
        }
    }
}
