package Interfaces;

public class Credentials {
    private String AccessKey;
    private String SecretKey;

    public Credentials(String accessKey, String secretKey) {
        AccessKey = accessKey;
        SecretKey = secretKey;
    }

    public String getAccessKey() {
        return AccessKey;
    }

    public void setAccessKey(String accessKey) {
        AccessKey = accessKey;
    }

    public String getSecretKey() {
        return SecretKey;
    }

    public void setSecretKey(String secretKey) {
        SecretKey = secretKey;
    }
}
