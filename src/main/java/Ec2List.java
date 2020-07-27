import Interfaces.Credentials;
import Interfaces.Instances;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.ec2.AmazonEC2;
import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.AmazonEC2ClientBuilder;
import com.amazonaws.services.ec2.model.DescribeInstancesRequest;
import com.amazonaws.services.ec2.model.DescribeInstancesResult;
import com.amazonaws.services.ec2.model.Instance;
import com.amazonaws.services.ec2.model.Reservation;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/Ec2")
public class Ec2List extends HttpServlet {
    public static ArrayList<Instances> listInstances = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String accessKey = req.getParameter("accessKay");
        String secretKay = req.getParameter("aecretKay");
        BasicAWSCredentials awsCreds = null;
        Credentials credentials = null;

        if (accessKey != null && secretKay != null) {
            credentials = new Credentials(accessKey, secretKay);
            awsCreds = new BasicAWSCredentials(credentials.getAccessKey(), credentials.getSecretKey());
        }else{
            awsCreds = new BasicAWSCredentials(credentials.getAccessKey(), credentials.getSecretKey());
        }

        //BasicAWSCredentials awsCreds = new BasicAWSCredentials(CredentialsEc2.access_key_id, CredentialsEc2.secret_access_key);

        /*final AmazonEC2 ec2 = AmazonEC2Client.builder()
                .withRegion(Regions.US_EAST_1)
                .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                .build();*/
        AmazonEC2Client ec2 = new AmazonEC2Client(awsCreds).withRegion(Regions.US_EAST_1);

        boolean done = false;

        DescribeInstancesRequest request = new DescribeInstancesRequest();

        while(!done){
            DescribeInstancesResult response = ec2.describeInstances(request);

            for(Reservation reservation:response.getReservations()){
                for (Instance instance : reservation.getInstances()){
                    Instances instances = new Instances(instance.getInstanceId(), instance.getImageId(), instance.getInstanceType(), instance.getState().getName(), instance.getLaunchTime().toString(), instance.getPlacement().getAvailabilityZone(), instance.getPlatform(), instance.getTags().toString(), instance.getVpcId(), instance.getKernelId(), instance.getPrivateDnsName(), instance.getPublicDnsName());
                    listInstances.add(instances);
                }

                request.setNextToken(response.getNextToken());

                if(response.getNextToken() == null){
                    done = true;
                }
            }
        }

        req.setAttribute("listInstances", listInstances);
        getServletConfig().getServletContext().getRequestDispatcher("/ec2.jsp").forward(req, resp);
    }
}
