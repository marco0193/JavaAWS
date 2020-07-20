import Interfaces.Buckets;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.Bucket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/S3List")
public class S3List extends HttpServlet{
    ArrayList<Buckets> listBuckets = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(CredentialsS3.access_key_id, CredentialsS3.secret_access_key);

        AmazonS3Client s3Client = new AmazonS3Client(awsCreds);
        /*AmazonS3 s3Client = AmazonS3ClientBuilder
                .standard()
                .withRegion(Regions.DEFAULT_REGION)
                .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                .build();*/

        List<Bucket> buckets = s3Client.listBuckets();
        for (Bucket b : buckets) {
            Buckets buck = new Buckets(b.getName(), b.getCreationDate().toString());
            listBuckets.add(buck);
        }

        req.setAttribute("listBuckets", listBuckets);

        getServletConfig().getServletContext().getRequestDispatcher("/s3.jsp").forward(req, resp);
    }
}
