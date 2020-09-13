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
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/ReporteGeneral")
public class ReporteGeneral extends HttpServlet {

    public static ArrayList<Instances> listInstances = new ArrayList<>();
    public static ArrayList<Credentials> listCredentials = new ArrayList<>();

    /*public ReporteGeneral(){
        super();
    }*/

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String access = req.getParameter("faccess");
        String secret = req.getParameter("fsecret");

        resp.setContentType("application/vnd.ms-excel");
        resp.setHeader("Content-disposition", "attachment;filename=ReporteGeneral.xls");

        listInstances.clear();

        BasicAWSCredentials awsCreds = new BasicAWSCredentials(access, secret);
        AmazonEC2Client ec2 = new AmazonEC2Client(awsCreds).withRegion(Regions.US_EAST_1);

        //Llamamos al metodo que se encarga de crear la lista de instancias
        listEc2(ec2);

        PrintWriter out = resp.getWriter();

        try{
            for(Instances i : listInstances){
                out.println("Intance:\t"+i.getName());
                out.println(" \t ");
                out.println("Name\tValue");
                out.println("Id\t"+i.getId());
                out.println("AMI\t"+i.getAmi());
                out.println("Type\t"+i.getType());
                out.println("State\t"+i.getState());
                out.println("Launch Time\t"+i.getLaunchTime());
                out.println("Placement\t"+i.getPlacement());
                out.println("Platform\t"+i.getPlatgorm());
                out.println("VPC ID\t"+i.getVpcId());
                out.println("Karnel ID\t"+i.getKarnelId());
                out.println("Private DNS\t"+i.getPrivateDns());
                out.println(" \t ");
                out.println(" \t ");
                out.println("Este es el:\treporte general");
                out.println(" \t ");
                out.println(" \t ");
                out.println("Access key\tsecretkey");
                out.println(access+"\t"+secret);
            }
        }finally{
            out.close();
        }
    }

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
