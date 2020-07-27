package Interfaces;

public class Instances {
    private String id;
    private String ami;
    private String type;
    private String state;
    private String launchTime;
    private String placement;
    private String platgorm;
    private String tags;
    private String vpcId;
    private String karnelId;
    private String privateDns;
    private String publicDns;

    public Instances(String id, String ami, String type, String state, String launchTime, String placement, String platgorm, String tags, String vpcId, String karnelId, String privateDns, String publicDns) {
        this.id = id;
        this.ami = ami;
        this.type = type;
        this.state = state;
        this.launchTime = launchTime;
        this.placement = placement;
        this.platgorm = platgorm;
        this.tags = tags;
        this.vpcId = vpcId;
        this.karnelId = karnelId;
        this.privateDns = privateDns;
        this.publicDns = publicDns;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAmi() {
        return ami;
    }

    public void setAmi(String ami) {
        this.ami = ami;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getLaunchTime() {
        return launchTime;
    }

    public void setLaunchTime(String launchTime) {
        this.launchTime = launchTime;
    }

    public String getPlacement() {
        return placement;
    }

    public void setPlacement(String placement) {
        this.placement = placement;
    }

    public String getPlatgorm() {
        return platgorm;
    }

    public void setPlatgorm(String platgorm) {
        this.platgorm = platgorm;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getVpcId() {
        return vpcId;
    }

    public void setVpcId(String vpcId) {
        this.vpcId = vpcId;
    }

    public String getKarnelId() {
        return karnelId;
    }

    public void setKarnelId(String karnelId) {
        this.karnelId = karnelId;
    }

    public String getPrivateDns() {
        return privateDns;
    }

    public void setPrivateDns(String privateDns) {
        this.privateDns = privateDns;
    }

    public String getPublicDns() {
        return publicDns;
    }

    public void setPublicDns(String publicDns) {
        this.publicDns = publicDns;
    }
}
